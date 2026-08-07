import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Wayland
import QtQuick

Scope {
    id: panel

    readonly property int barHeight: 24
    readonly property int edgeMargin: 8
    readonly property int pillGap: 8
    readonly property int drawerHeight: 200
    readonly property int headerHeight: effectiveBarShown ? edgeMargin + barHeight : 0
    readonly property int drawerPanelHeight: headerHeight + drawerHeight
    readonly property int reservedHeight: drawerOpen ? drawerPanelHeight : (effectiveBarShown ? headerHeight : 0)
    readonly property bool fullscreenActive: Hyprland.focusedWorkspace?.hasFullscreen ?? false
    readonly property bool effectiveBarShown: barShown && !fullscreenActive
    readonly property bool drawerExpanded: drawerOpen || drawerRenderVisible

    property bool barShown: true
    property bool drawerOpen: false
    property bool drawerRenderVisible: false
    property real drawerSlideY: -drawerPanelHeight
    property string drawerBackground: fullscreenActive ? "#232828" : "transparent"

    onDrawerOpenChanged: {
        if (drawerOpen) {
            drawerRenderVisible = true
        }

        drawerSlideY = drawerOpen ? 0 : -drawerPanelHeight
    }

    IpcHandler {
        target: "bar"

        function toggle() {
            panel.barShown = !panel.barShown
        }

        function show() {
            panel.barShown = true
        }

        function hide() {
            panel.barShown = false
        }
    }

    IpcHandler {
        target: "drawer"

        function toggle() {
            panel.drawerOpen = !panel.drawerOpen
        }

        function open() {
            panel.drawerOpen = true
        }

        function close() {
            panel.drawerOpen = false
        }
    }

    PanelWindow {
        id: reserveWindow

        anchors {
            top: true
            left: true
            right: true
        }

        implicitHeight: panel.reservedHeight
        color: "transparent"
        visible: panel.reservedHeight > 0
        exclusionMode: panel.reservedHeight > 0 ? ExclusionMode.Normal : ExclusionMode.Ignore
        exclusiveZone: panel.reservedHeight
    }

    PanelWindow {
        id: visualWindow

        anchors {
            top: true
            bottom: true
            left: true
            right: true
        }

        color: "transparent"
        visible: panel.effectiveBarShown || panel.drawerExpanded
        WlrLayershell.layer: WlrLayer.Overlay
        exclusionMode: ExclusionMode.Ignore
        exclusiveZone: 0

        mask: Region {
            Region { item: drawerBackground }
            Region { item: barLayer }
        }

        Rectangle {
            id: drawerBackground
            y: panel.drawerSlideY
            width: visualWindow.width
            height: panel.drawerPanelHeight
            visible: panel.drawerExpanded
            color: panel.drawerBackground

            Behavior on y {
                NumberAnimation {
                    duration: 150
                    easing.type: Easing.InOutCubic
                }
            }

            onYChanged: {
                if (!panel.drawerOpen && y <= -panel.drawerPanelHeight) {
                    panel.drawerRenderVisible = false
                }
            }

            MouseArea {
                anchors.fill: parent
                enabled: audioPanel.anyOpen

                onClicked: {
                    audioPanel.closeMenus()
                }
            }

            HardwareStatsPanel {
                id: hardwareStatsPanel
                x: panel.edgeMargin
                y: panel.headerHeight + panel.edgeMargin
                width: Math.max(120, audioPanel.x - x - panel.pillGap)
                height: panel.drawerHeight - panel.edgeMargin * 2
            }

            AudioPanel {
                id: audioPanel
                x: Math.max(panel.edgeMargin + 120 + panel.pillGap, barLayer.x + leftModules.x + audioBlock.x)
                y: panel.headerHeight + panel.edgeMargin
            }
        }

        Item {
            id: barLayer
            x: panel.edgeMargin
            y: panel.edgeMargin
            width: visualWindow.width - panel.edgeMargin * 2
            height: panel.barHeight
            visible: panel.effectiveBarShown

            Row {
                id: leftModules
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                spacing: panel.pillGap

                CommandBlock {
                    textColor: "#a09af8"
                    command: ["sh", "-c", "LC_ALL=C top -bn1 | awk '/Cpu|%Cpu/ { gsub(/,/, \"\"); print \" \" int(100 - $8) \"%\"; exit }'"]
                    clickCommand: ["ghostty", "-e", "btop"]
                }

                CommandBlock {
                    textColor: "#88c1e9"
                    command: ["sh", "-c", "gpu-usage | jq -r '\"󰢮 \" + (.text // \"--\")'"]
                    clickCommand: ["lact"]
                }

                CommandBlock {
                    textColor: "#bbc2cf"
                    command: ["sh", "-c", "free | awk '/Mem:/ { printf \" %d%%\\n\", ($3 / $2) * 100 }'"]
                }

                CommandBlock {
                    textColor: "#d2b487"
                    interval: 60000
                    command: ["sh", "-c", "ssh homebase \"df --output=pcent / | tail -1 | tr -dc '0-9'\" | awk '{ print \"󰒋 \" $1 \"%\" }'"]
                    clickCommand: ["ghostty", "-e", "ssh", "homebase"]
                }

                AudioBlock {
                    id: audioBlock
                }

                MprisBlock {}
            }

            Row {
                id: centerModules
                anchors.centerIn: parent
                spacing: panel.pillGap

                Workspaces {}
            }

            Row {
                id: rightModules
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                spacing: panel.pillGap

                UpdatesBlock {}

                Tray {}

                ClockBlock {}

                NotificationBlock {}
            }
        }
    }
}
