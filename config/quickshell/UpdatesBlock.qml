import Quickshell.Io
import QtQuick

BarBlock {
    id: root

    property int updates: 0

    function refresh() {
        statusRunner.running = false
        statusRunner.running = true
    }

    visible: updates > 0
    text: ` ${updates}`
    textColor: "#101e18"
    backgroundColor: "#95d5b2"
    fontBold: true

    Process {
        id: statusRunner
        command: ["sh", "-c", "checkupdates 2>/dev/null | wc -l"]

        stdout: SplitParser {
            onRead: data => root.updates = Number.parseInt(data.trim() || "0", 10)
        }
    }

    Process {
        id: upgradeRunner
        command: ["ghostty", "-e", "bash", "-c", "packages upgrade; read -n 1"]
        onExited: root.refresh()
    }

    Process {
        id: archNewsRunner
        command: ["xdg-open", "https://archlinux.org/news"]
    }

    Timer {
        interval: 600000
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
                archNewsRunner.running = false
                archNewsRunner.running = true
            } else {
                upgradeRunner.running = false
                upgradeRunner.running = true
            }
        }
    }
}
