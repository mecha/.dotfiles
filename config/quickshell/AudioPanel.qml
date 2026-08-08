import Quickshell.Io
import QtQuick
import QtQuick.Controls

Item {
    id: root

    readonly property int hpadding: 8
    readonly property int vpadding: 12
    readonly property int rowGap: 12
    readonly property int volumeRowHeight: 24
    readonly property int closedHeight: volumeRowHeight + rowGap + deviceSwitcher.closedHeight + vpadding * 2
    readonly property bool anyOpen: deviceSwitcher.anyOpen

    property int volume: 0

    function closeMenus() {
        deviceSwitcher.closeMenus()
    }

    function refreshVolume() {
        volumeStatusRunner.running = false
        volumeStatusRunner.running = true
    }

    function volumeIcon() {
        if (volume === 0) {
            return ""
        }

        return volume < 50 ? "" : ""
    }

    width: deviceSwitcher.width + vpadding * 2
    height: closedHeight
    z: anyOpen ? 20 : 1

    DrawerPanel {
        id: panel
        width: parent.width
        height: root.closedHeight
        padding: 0
    }

    Item {
        id: volumeRow
        x: root.hpadding
        y: root.vpadding
        width: deviceSwitcher.width
        height: root.volumeRowHeight

        Text {
            width: deviceSwitcher.iconWidth
            anchors.verticalCenter: volumeSlider.verticalCenter
            horizontalAlignment: Text.AlignHCenter
            color: "#95d5b2"
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 16
            text: root.volumeIcon()
        }

        Slider {
            id: volumeSlider

            x: deviceSwitcher.iconWidth + deviceSwitcher.iconGap + 4
            width: deviceSwitcher.dropdownWidth - 8
            height: 32
            from: 0
            to: 100
            stepSize: 1
            value: root.volume
            live: true

            onMoved: {
                root.volume = Math.round(value)
                volumeSetRunner.volume = root.volume
                volumeSetRunner.running = false
                volumeSetRunner.running = true
            }

            background: Rectangle {
                x: volumeSlider.leftPadding
                y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
                width: volumeSlider.availableWidth
                height: 8
                radius: 4
                color: "#1b2020"
                border.width: 1
                border.color: "#3c4747"

                Rectangle {
                    width: volumeSlider.visualPosition * parent.width
                    height: parent.height
                    radius: parent.radius
                    color: "#95d5b2"
                }
            }

            handle: Rectangle {
                x: volumeSlider.leftPadding + volumeSlider.visualPosition * (volumeSlider.availableWidth - width)
                y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
                width: 16
                height: 16
                radius: 8
                color: volumeSlider.pressed ? "#d7fbe8" : "#95d5b2"
                border.width: 1
                border.color: "#1b2020"
            }
        }
    }

    AudioDeviceSwitcher {
        id: deviceSwitcher
        x: root.hpadding
        y: volumeRow.y + volumeRow.height + root.rowGap
    }

    Process {
        id: volumeStatusRunner
        command: ["sh", "-c", "wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{ printf \"{\\\"volume\\\":%d}\\n\", $2 * 100 }'"]

        stdout: SplitParser {
            onRead: data => {
                const parsed = JSON.parse(data.trim())
                root.volume = parsed.volume ?? 0
            }
        }
    }

    Process {
        id: volumeSetRunner
        property int volume: 0
        command: ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", volume + "%"]
        onExited: root.refreshVolume()
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: root.refreshVolume()
    }

    Component.onCompleted: root.refreshVolume()
}
