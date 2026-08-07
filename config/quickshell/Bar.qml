import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick

PanelWindow {
    id: bar

    readonly property int barHeight: 24
    readonly property int edgeMargin: 8
    readonly property int pillGap: 8
    property bool shown: true
    readonly property bool fullscreenActive: Hyprland.focusedWorkspace?.hasFullscreen ?? false
    readonly property bool effectiveShown: shown && !fullscreenActive

    anchors {
        top: true
        left: true
        right: true
    }

    margins {
        top: edgeMargin
        left: edgeMargin
        right: edgeMargin
    }

    implicitHeight: effectiveShown ? barHeight : 0
    color: "transparent"
    visible: effectiveShown
    exclusionMode: effectiveShown ? ExclusionMode.Normal : ExclusionMode.Ignore
    exclusiveZone: effectiveShown ? barHeight : 0

    IpcHandler {
        target: "bar"

        function toggle() {
            bar.shown = !bar.shown
        }

        function show() {
            bar.shown = true
        }

        function hide() {
            bar.shown = false
        }
    }

    Row {
        id: leftModules
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        spacing: pillGap

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

        AudioBlock {}

        MprisBlock {}
    }

    Row {
        id: centerModules
        anchors.centerIn: parent
        spacing: pillGap

        Workspaces {}
    }

    Row {
        id: rightModules
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        spacing: pillGap

        UpdatesBlock {}

        Tray {}

        ClockBlock {}

        NotificationBlock {}
    }
}
