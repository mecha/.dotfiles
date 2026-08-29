import Quickshell.Io
import QtQuick

DrawerPanel {
    id: root

    property string frameText: "Waiting for frames on\n${XDG_RUNTIME_DIR}/quickshell/jumbotron.pipe\n\nTerminate each frame with \\f."
    property string pipePath: ""

    padding: 10
    clip: true

    Text {
        anchors.fill: parent
        color: "#d7fbe8"
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: 13
        lineHeight: 0.825
        lineHeightMode: Text.ProportionalHeight
        textFormat: Text.PlainText
        wrapMode: Text.NoWrap
        clip: true
        text: root.frameText
    }

    Process {
        id: frameReader
        running: true
        command: ["jumbotron-reader"]

        stdout: SplitParser {
            onRead: data => {
                const parsed = JSON.parse(data.trim())

                if (parsed.text !== undefined) {
                    root.frameText = parsed.text
                }

                if (parsed.path !== undefined) {
                    root.pipePath = parsed.path
                    root.frameText = "Waiting for frames on\n" + parsed.path + "\n\nTerminate each frame with \\f."
                }
            }
        }
    }
}
