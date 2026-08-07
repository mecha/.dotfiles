import QtQuick

Rectangle {
    id: root

    property int padding: 10
    default property alias content: contentItem.data

    color: "#232828"
    radius: 10
    border.width: 1
    border.color: "#95d5b2"

    Item {
        id: contentItem
        anchors.fill: parent
        anchors.margins: root.padding
    }
}
