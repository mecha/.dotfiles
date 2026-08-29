import QtQuick
import Quickshell.Widgets

ClippingRectangle {
    id: block

    property alias text: label.text
    property color textColor: "#b1f0cd"
    property color backgroundColor: "#1c2929"
    property int horizontalPadding: 12
    property bool fontBold: false
    property int fontPixelSize: 16

    height: 28
    implicitWidth: label.implicitWidth + horizontalPadding * 2
    radius: 10
    color: backgroundColor
    opacity: 0.92
    border.width: 2
    border.color: "#080c0c"

    Text {
        id: label
        anchors.centerIn: parent
        color: block.textColor
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: block.fontPixelSize
        font.bold: block.fontBold
        text: ""
    }
}
