import Quickshell.Io
import QtQuick

DrawerPanel {
    id: root

    property string networkName: "Unknown network"
    property string localAddress: "No local address"
    property string tailscaleAddress: "No Tailscale address"
    property string wifiName: "Not connected"
    property string wifiAddress: ""
    property bool wifiConnected: false

    width: 420
    height: 74
    padding: 10

    function refresh() {
        networkRunner.running = false
        networkRunner.running = true
    }

    Column {
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 6

        Item {
            width: parent.width
            height: 18

            Text {
                id: networkIcon

                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                color: "#95d5b2"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 14
                text: "󰛳"
            }

            Text {
                id: addressLabel

                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                color: "#d7fbe8"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 13
                text: root.localAddress
            }

            Text {
                anchors.left: networkIcon.right
                anchors.right: addressLabel.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 8
                anchors.rightMargin: 12
                color: "#95d5b2"
                elide: Text.ElideRight
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 14
                font.bold: true
                text: root.networkName
            }
        }

        Item {
            width: parent.width
            height: 18

            Text {
                id: tailscaleLabel

                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                color: "#95d5b2"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 14
                font.bold: true
                text: " Tailscale"
            }

            Text {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                color: "#d7fbe8"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 13
                text: root.tailscaleAddress
            }
        }

        Item {
            width: parent.width
            height: 18

            Text {
                id: wifiLabel

                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                color: root.wifiConnected ? "#95d5b2" : "#6f8f83"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 14
                font.bold: root.wifiConnected
                text: "󰖩 " + root.wifiName
            }

            Text {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                color: root.wifiConnected ? "#d7fbe8" : "#6f8f83"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 13
                text: root.wifiAddress
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            nmEditorRunner.running = false
            nmEditorRunner.running = true
        }
    }

    Process {
        id: nmEditorRunner
        command: ["nm-connection-editor"]
    }

    Process {
        id: networkRunner
        command: ["sh", "-c", "line=$(ip route get 1.1.1.1 2>/dev/null | head -1); dev=$(printf '%s\\n' \"$line\" | awk '{ for (i = 1; i <= NF; i++) if ($i == \"dev\") { print $(i + 1); exit } }'); src=$(printf '%s\\n' \"$line\" | awk '{ for (i = 1; i <= NF; i++) if ($i == \"src\") { print $(i + 1); exit } }'); name=$(nmcli -g GENERAL.CONNECTION device show \"$dev\" 2>/dev/null | head -1); [ -n \"$name\" ] || name=$dev; tailscale=$(tailscale ip -4 2>/dev/null | head -1); wifi_dev=$(nmcli -t -f DEVICE,TYPE,STATE device status | awk -F: '$2 == \"wifi\" && $3 == \"connected\" { print $1; exit }'); wifi_name=\"Not connected\"; wifi_addr=\"\"; wifi_connected=false; if [ -n \"$wifi_dev\" ]; then wifi_name=$(nmcli -g GENERAL.CONNECTION device show \"$wifi_dev\" 2>/dev/null | head -1); wifi_addr=$(nmcli -g IP4.ADDRESS device show \"$wifi_dev\" 2>/dev/null | head -1 | cut -d/ -f1); wifi_connected=true; fi; jq -cn --arg name \"$name\" --arg addr \"$src\" --arg tailscale \"$tailscale\" --arg wifi_name \"$wifi_name\" --arg wifi_addr \"$wifi_addr\" --argjson wifi_connected \"$wifi_connected\" '{name: ($name // \"Unknown network\"), address: ($addr // \"No local address\"), tailscale: ($tailscale // \"No Tailscale address\"), wifiName: $wifi_name, wifiAddress: $wifi_addr, wifiConnected: $wifi_connected}'"]

        stdout: SplitParser {
            onRead: data => {
                const parsed = JSON.parse(data.trim())
                root.networkName = parsed.name || "Unknown network"
                root.localAddress = parsed.address || "No local address"
                root.tailscaleAddress = parsed.tailscale || "No Tailscale address"
                root.wifiName = parsed.wifiName || "Not connected"
                root.wifiAddress = parsed.wifiAddress || ""
                root.wifiConnected = parsed.wifiConnected ?? false
            }
        }
    }

    Timer {
        interval: 10000
        running: true
        repeat: true
        onTriggered: root.refresh()
    }

    Component.onCompleted: root.refresh()
}
