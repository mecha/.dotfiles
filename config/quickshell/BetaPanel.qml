import QtQuick

DrawerPanel {
    id: root

    padding: 10

    Text {
        id: alphaTodo

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        color: "#95d5b2"
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: 14
        text: "/* TODO :: BetaPanel */"
    }
}
