import QtQuick

Text {
    id: root

    property real value: 0
    property real maximum: 100
    property int blocks: 8
    property string filledCharacter: "■"
    property string emptyCharacter: "-"

    readonly property real fraction: maximum > 0 ? Math.max(0, Math.min(1, value / maximum)) : 0
    readonly property int filledBlocks: Math.max(0, Math.min(blocks, Math.round(fraction * blocks)))

    color: "#95d5b2"
    font.family: "JetBrainsMono Nerd Font"
    font.pixelSize: 13
    text: "[" + filledCharacter.repeat(filledBlocks) + emptyCharacter.repeat(blocks - filledBlocks) + "]"
}
