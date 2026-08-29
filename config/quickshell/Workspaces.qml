import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick

ClippingRectangle {
    id: root

    readonly property int itemHeight: 24
    readonly property int horizontalPadding: 12

    function workspaceIcon(workspace) {
        const windows = workspace.toplevels?.values || []
        if (!windows.length) {
            return ""
        }

        const window = windows[0]
        const ipc = window.lastIpcObject || {}
        const wayland = window.wayland || {}
        const app = [
            window.title,
            wayland.appId,
            wayland.title,
            ipc.class,
            ipc.initialClass,
            ipc.title,
            ipc.initialTitle
        ].filter(value => value).join(" ").toLowerCase()

        if (app.includes("firefox") || app.includes("zen browser") || app.includes("zen")) {
            return "󰈹"
        }

        if (app.includes("ghostty")) {
            return ""
        }

        if (app.includes("steam")) {
            return "󰓓"
        }

        if (app.includes("discord")) {
            return ""
        }

        if (app.includes("slack")) {
            return "󰒱"
        }

        if (app.includes("gimp")) {
            return ""
        }

        if (app.includes("nautilus")) {
            return "󰉋"
        }

        if (app.includes("obsidian")) {
            return ""
        }

        return "󰣆"
    }

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
                color: workspace.focused ? "#b1f0cd" : "transparent"

                Text {
                    id: label
                    anchors.centerIn: parent
                    text: {
                        const icon = root.workspaceIcon(workspace)
                        return icon ? workspace.name + " " + icon : workspace.name
                    }
                    color: workspace.focused ? "#101e18" : "#95d5b2"
                    font.family: "JetBrainsMono Nerd Font"
                    font.bold: workspace.focused
                    font.pixelSize: 16
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
