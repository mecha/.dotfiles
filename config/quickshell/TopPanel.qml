import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Wayland
import QtQuick

Scope {
    id: panel

    readonly property bool fullscreenActive: Hyprland.focusedWorkspace?.hasFullscreen ?? false
    readonly property int barHeight: 24
    readonly property int edgeMargin: 8
    readonly property int topMargin: 8
    readonly property int bottomMargin: fullscreenActive ? topMargin : 0
    readonly property int verticalMargin: topMargin + bottomMargin
    readonly property int pillGap: 8
    readonly property int networkPanelWidth: 380
    readonly property int drawerHeight: fullscreenActive ? 200 : 192
    readonly property int headerHeight: effectiveBarShown ? edgeMargin + barHeight : 0
    readonly property int drawerPanelHeight: headerHeight + drawerHeight
    readonly property int reservedHeight: drawerOpen ? drawerPanelHeight : (effectiveBarShown ? headerHeight : 0)
    readonly property bool effectiveBarShown: barShown && !fullscreenActive
    readonly property bool drawerExpanded: drawerOpen || drawerRenderVisible

    property bool barShown: true
    property bool drawerOpen: false
    property bool drawerRenderVisible: false
    property real drawerSlideY: -drawerPanelHeight
    property string drawerBackground: "transparent"

    onDrawerOpenChanged: {
        if (drawerOpen) {
            drawerRenderVisible = true
        }

        drawerSlideY = drawerOpen ? 0 : -drawerPanelHeight
        persistDrawerState()
    }

    function persistDrawerState() {
        drawerStateWriter.command = ["sh", "-c", "state_dir=\"${XDG_STATE_HOME:-$HOME/.local/state}/quickshell\"; mkdir -p \"$state_dir\"; printf %s \"$1\" > \"$state_dir/top-panel-drawer-open\"", "sh", panel.drawerOpen ? "true" : "false"]
        drawerStateWriter.running = false
        drawerStateWriter.running = true
    }

    function restoreDrawerState(text) {
        panel.drawerOpen = text.trim() === "true"
    }

    Component.onCompleted: {
        drawerStateReader.running = true
    }

    Process {
        id: drawerStateReader
        command: ["sh", "-c", "state_file=\"${XDG_STATE_HOME:-$HOME/.local/state}/quickshell/top-panel-drawer-open\"; [ -r \"$state_file\" ] && cat \"$state_file\" || printf false"]

        stdout: StdioCollector {
            waitForEnd: true
            onStreamFinished: panel.restoreDrawerState(text)
        }
    }

    Process {
        id: drawerStateWriter
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
                x: networkPanel.x
                y: panel.headerHeight + panel.topMargin
                width: 380
                height: 94
            }

            NetworkPanel {
                id: networkPanel
                x: panel.edgeMargin
                y: hardwareStatsPanel.y + hardwareStatsPanel.height + panel.pillGap
                width: hardwareStatsPanel.width
                height: 82
            }

            AudioPanel {
                id: audioPanel
                x: hardwareStatsPanel.x + hardwareStatsPanel.width + panel.pillGap
                y: panel.headerHeight + panel.topMargin
            }

            AlphaPanel {
                id: alphaPanel
                x: audioPanel.x
                y: audioPanel.y + audioPanel.closedHeight + panel.pillGap
                width: audioPanel.width
                height: panel.headerHeight + panel.drawerHeight - panel.bottomMargin - y
            }

            CalendarPanel {
                id: calendarPanel
                x: drawerBackground.width - width - panel.edgeMargin
                y: panel.headerHeight + panel.topMargin
                height: panel.drawerHeight - panel.verticalMargin
            }

            CodexPanel {
                id: codexPanel
                x: calendarPanel.x - width - panel.pillGap
                y: panel.headerHeight + panel.topMargin
            }

            BetaPanel {
                id: betaPanel
                x: codexPanel.x
                y: codexPanel.y + codexPanel.height + panel.pillGap
                width: codexPanel.width
                height: panel.headerHeight + panel.drawerHeight - panel.bottomMargin - y
            }

            Jumbotron {
                id: jumbotron
                x: audioPanel.x + audioPanel.width + panel.pillGap
                y: panel.headerHeight + panel.topMargin
                width: codexPanel.x - panel.pillGap - x
                height: panel.drawerHeight - panel.verticalMargin
            }
        }

        Item {
            id: barLayer
            x: panel.edgeMargin
            y: panel.topMargin
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
