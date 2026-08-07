import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick

ClippingRectangle {
    id: root

    readonly property int itemHeight: 24
    readonly property int horizontalPadding: 10

    height: itemHeight
    implicitWidth: row.implicitWidth
    radius: 10
    color: "#232828"

    Row {
        id: row
        anchors.verticalCenter: parent.verticalCenter

        Repeater {
            model: Hyprland.workspaces.values
                .filter(workspace => workspace.id > 0)
                .sort((a, b) => a.id - b.id)

            delegate: Rectangle {
                id: workspaceButton

                required property var modelData
                readonly property var workspace: modelData

                width: label.implicitWidth + root.horizontalPadding * 2
                height: root.itemHeight
                radius: 0
                color: workspace.focused ? "#95d5b2" : "transparent"

                Text {
                    id: label
                    anchors.centerIn: parent
                    text: workspace.name
                    color: workspace.focused ? "#101e18" : "#95d5b2"
                    font.family: "JetBrainsMono Nerd Font"
                    font.bold: workspace.focused
                    font.pixelSize: 15
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: workspace.activate()
                }
            }
        }
    }
}
