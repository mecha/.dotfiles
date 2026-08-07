import Quickshell.Io
import QtQuick

BarBlock {
    id: block

    property list<string> command: []
    property list<string> clickCommand: []
    property int interval: 5000
    property bool runOnStart: true

    function refresh() {
        if (command.length === 0) {
            return
        }

        commandRunner.running = false
        commandRunner.running = true
    }

    function setFromOutput(data) {
        const trimmed = data.trim()

        if (trimmed.length === 0) {
            block.visible = false
            return
        }

        try {
            const parsed = JSON.parse(trimmed)
            block.text = parsed.text ?? trimmed
        } catch (e) {
            block.text = trimmed
        }

        block.visible = block.text.length > 0
    }

    Process {
        id: commandRunner
        command: block.command

        stdout: SplitParser {
            onRead: data => block.setFromOutput(data)
        }
    }

    Process {
        id: clickRunner
        command: block.clickCommand
    }

    Timer {
        interval: block.interval
        running: block.command.length > 0
        repeat: true
        onTriggered: block.refresh()
    }

    Component.onCompleted: {
        if (runOnStart) {
            refresh()
        }
    }

    MouseArea {
        anchors.fill: parent
        enabled: block.clickCommand.length > 0
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            clickRunner.running = false
            clickRunner.running = true
        }
    }
}
