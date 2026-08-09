import Quickshell.Io
import QtQuick

DrawerPanel {
    id: root

    property var rows: [
        { icon: "󰘚", label: "Memory", used: 0, total: 0 },
        { icon: "󰓡", label: "Swap", used: 0, total: 0 },
        { icon: "󰋊", label: "/", used: 0, total: 0 },
        { icon: "󰋊", label: "/files", used: 0, total: 0 }
    ]

    padding: 10

    function refresh() {
        statsRunner.running = false
        statsRunner.running = true
    }

    function gib(bytes) {
        return bytes / 1024 / 1024 / 1024
    }

    function sizeText(bytes) {
        return gib(bytes).toFixed(1) + " GiB"
    }

    function percent(used, total) {
        if (!total) {
            return 0
        }

        return Math.floor(used / total * 100)
    }

    function progressBar(used, total) {
        const blocks = 8
        const filled = total ? Math.max(0, Math.min(blocks, Math.round(used / total * blocks))) : 0
        return "[" + "■".repeat(filled) + "-".repeat(blocks - filled) + "]"
    }

    function parseStats(text) {
        const data = JSON.parse(text)
        const memory = data.find(item => item.type === "Memory")?.result
        const swap = data.find(item => item.type === "Swap")?.result?.[0]
        const disks = data.find(item => item.type === "Disk")?.result || []
        const rootDisk = disks.find(disk => disk.mountpoint === "/")?.bytes
        const filesDisk = disks.find(disk => disk.mountpoint === "/files")?.bytes

        root.rows = [
            { icon: "󰘚", label: "Memory", used: memory?.used || 0, total: memory?.total || 0 },
            { icon: "󰓡", label: "Swap", used: swap?.used || 0, total: swap?.total || 0 },
            { icon: "󰋊", label: "/", used: rootDisk?.used || 0, total: rootDisk?.total || 0 },
            { icon: "󰋊", label: "/files", used: filesDisk?.used || 0, total: filesDisk?.total || 0 }
        ]
    }

    Column {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        spacing: 2

        Repeater {
            model: root.rows

            Item {
                required property var modelData

                width: parent.width
                height: 18

                Text {
                    id: labelText

                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    width: 60
                    color: "#95d5b2"
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 13
                    text: modelData.icon + " " + modelData.label
                }

                Text {
                    id: progressText

                    anchors.left: labelText.right
                    anchors.leftMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    color: "#95d5b2"
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 13
                    text: root.progressBar(modelData.used, modelData.total)
                }

                Text {
                    id: totalText

                    anchors.left: progressText.right
                    anchors.leftMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    width: 130
                    horizontalAlignment: Text.AlignRight
                    color: "#d7fbe8"
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 13
                    text: gib(modelData.used).toFixed(1) + " / " + gib(modelData.total).toFixed(1) + " GiB"
                }

                Text {
                    id: separatorText

                    anchors.left: totalText.right
                    anchors.leftMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    color: "#95d5b2"
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 13
                    text: ""
                }

                Text {
                    anchors.left: separatorText.right
                    anchors.leftMargin: 8
                    anchors.verticalCenter: parent.verticalCenter
                    color: "#d7fbe8"
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 13
                    text: root.percent(modelData.used, modelData.total) + "%"
                }
            }
        }
    }

    Process {
        id: statsRunner
        command: ["fastfetch", "-j"]

        stdout: StdioCollector {
            waitForEnd: true
            onStreamFinished: root.parseStats(text)
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: root.refresh()
    }

    Component.onCompleted: root.refresh()
}
