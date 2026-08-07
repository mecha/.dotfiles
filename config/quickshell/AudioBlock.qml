import Quickshell.Io
import QtQuick

BarBlock {
    id: root

    property int volume: 0
    property bool muted: false

    function refresh() {
        statusRunner.running = false
        statusRunner.running = true
    }

    function volumeIcon() {
        if (muted) {
            return ""
        }

        return volume < 50 ? "" : ""
    }

    text: `${volumeIcon()}  ${volume}%`
    textColor: muted ? "#101e18" : "#95d5b2"
    backgroundColor: muted ? "#e07870" : "#232828"

    Process {
        id: statusRunner
        command: ["sh", "-c", "wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{ printf \"{\\\"volume\\\":%d,\\\"muted\\\":%s}\\n\", $2 * 100, ($0 ~ /MUTED/) ? \"true\" : \"false\" }'"]

        stdout: SplitParser {
            onRead: data => {
                const parsed = JSON.parse(data.trim())
                root.volume = parsed.volume ?? 0
                root.muted = parsed.muted ?? false
            }
        }
    }

    Process {
        id: drawerRunner
        command: ["quickshell", "ipc", "call", "drawer", "toggle"]
    }

    Process {
        id: muteRunner
        command: ["wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle"]
        onExited: root.refresh()
    }

    Process {
        id: volumeRunner
        property string step: "1%+"
        command: ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", step]
        onExited: root.refresh()
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: root.refresh()
    }

    Component.onCompleted: root.refresh()

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        cursorShape: Qt.PointingHandCursor

        onClicked: mouse => {
            if (mouse.button === Qt.RightButton) {
                muteRunner.running = false
                muteRunner.running = true
            } else {
                drawerRunner.running = false
                drawerRunner.running = true
            }
        }

        onWheel: wheel => {
            volumeRunner.step = wheel.angleDelta.y > 0 ? "1%+" : "1%-"
            volumeRunner.running = false
            volumeRunner.running = true
        }
    }
}
