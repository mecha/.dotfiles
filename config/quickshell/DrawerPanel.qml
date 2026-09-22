import QtQuick

Rectangle {
    id: root

    property int padding: 10
    default property alias content: contentItem.data

    color: "#1d3836"
    radius: 10
    border.width: 2
    opacity: 0.9
    border.color: "#080c0c"

    Item {
        id: contentItem
        anchors.fill: parent
        anchors.margins: root.padding
    }
}
