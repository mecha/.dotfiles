import QtQuick

Rectangle {
    id: block

    property alias text: label.text
    property color textColor: "#95d5b2"
    property color backgroundColor: "#232828"
    property int horizontalPadding: 10
    property bool fontBold: false
    property int fontPixelSize: 16

    height: 24
    implicitWidth: label.implicitWidth + horizontalPadding * 2
    radius: 10
    color: backgroundColor

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
