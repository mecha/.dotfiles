import QtQuick

Item {
    id: root

    property real value: 0
    property real maximum: 100
    property int blocks: 8
    property color color: "#95d5b2"
    property color backgroundColor: "#071c1a"
    property string backgroundCharacter: "█"
    readonly property var partialCharacters: ["", "▏", "▎", "▍", "▌", "▋", "▊", "▉"]

    readonly property real fraction: maximum > 0 ? Math.max(0, Math.min(1, value / maximum)) : 0
    readonly property int eighths: Math.max(0, Math.min(blocks * 8, Math.round(fraction * blocks * 8)))
    readonly property int fullBlocks: Math.floor(eighths / 8)
    readonly property int partialEighths: eighths % 8
    readonly property int emptyBlocks: Math.max(0, blocks - fullBlocks - (partialEighths > 0 ? 1 : 0))

    width: implicitWidth
    height: implicitHeight
    implicitWidth: backgroundText.implicitWidth
    implicitHeight: backgroundText.implicitHeight

    Text {
        id: backgroundText

        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        color: root.backgroundColor
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: 13
        text: "[" + root.backgroundCharacter.repeat(root.blocks) + "]"
    }

    Text {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        color: root.color
        font.family: backgroundText.font.family
        font.pixelSize: backgroundText.font.pixelSize
        text: "[" + "█".repeat(root.fullBlocks) + root.partialCharacters[root.partialEighths] + " ".repeat(root.emptyBlocks) + "]"
    }
}
