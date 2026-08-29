import Quickshell.Io
import QtQuick

BarBlock {
    id: root

    property int count: 0
    property bool dnd: false

    function setState(data) {
        const parsed = JSON.parse(data.trim())
        root.count = parsed.count ?? 0
        root.dnd = parsed.dnd ?? false
    }

    function refresh() {
        statusRunner.running = false
        statusRunner.running = true
    }

    text: `${dnd ? "" : ""} ${count}`
    textColor: dnd || count > 0 ? "#101e18" : "#95d5b2"
    backgroundColor: dnd ? "#e07870" : count > 0 ? "#e3ca65" : "#1c2929"

    Process {
        id: subscriptionRunner
        running: true
        command: ["swaync-client", "-s", "-sw"]

        stdout: SplitParser {
            onRead: data => root.setState(data)
        }

        onExited: restartSubscriptionTimer.start()
    }

    Process {
        id: statusRunner
        command: ["sh", "-c", "count=$(swaync-client -c 2>/dev/null || echo 0); dnd=$(swaync-client -D 2>/dev/null || echo false); printf '{\"count\":%s,\"dnd\":%s}\\n' \"${count:-0}\" \"${dnd:-false}\""]

        stdout: SplitParser {
            onRead: data => root.setState(data)
        }
    }

    Process {
        id: togglePanelRunner
        command: ["swaync-client", "-t", "-sw"]
        onExited: root.refresh()
    }

    Process {
        id: toggleDndRunner
        command: ["swaync-client", "-d", "-sw"]
        onExited: root.refresh()
    }

    Timer {
        id: restartSubscriptionTimer
        interval: 1000
        repeat: false
        onTriggered: subscriptionRunner.running = true
    }

    Component.onCompleted: root.refresh()

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        cursorShape: Qt.PointingHandCursor

        onClicked: mouse => {
            if (mouse.button === Qt.RightButton) {
                toggleDndRunner.running = false
                toggleDndRunner.running = true
            } else {
                togglePanelRunner.running = false
                togglePanelRunner.running = true
            }
        }
    }
}
