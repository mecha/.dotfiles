import Quickshell.Io
import QtQuick

BarBlock {
    id: root

    property date now: new Date()

    function pad(value) {
        return value.toString().padStart(2, "0")
    }

    function format() {
        const weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

        return `${weekdays[now.getDay()]} ${pad(now.getDate())} ${months[now.getMonth()]}  ${pad(now.getHours())}:${pad(now.getMinutes())}`
    }

    text: format()

    Process {
        id: drawerRunner
        command: ["quickshell", "ipc", "call", "drawer", "toggle"]
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: root.now = new Date()
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            drawerRunner.running = false
            drawerRunner.running = true
        }
    }
}
