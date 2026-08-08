import Quickshell.Io
import QtQuick

DrawerPanel {
    id: root

    property var codexUsage: ({})
    property var codexRateLimits: codexUsage?.rateLimits || ({})
    property var codexTokenUsage: codexUsage?.usage || ({})
    property var codexNotifications: codexUsage?.notifications || []
    property var codexInitialize: codexUsage?.initialize || ({})
    property var codexErrors: codexUsage?.errors || ({})
    property var codexActiveLimit: codexRateLimits?.rateLimits || ({})
    property var codexLimitsById: codexRateLimits?.rateLimitsByLimitId || ({})
    property var codexResetCredits: codexRateLimits?.rateLimitResetCredits || ({})
    property var codexPrimaryLimit: codexActiveLimit?.primary || ({})
    property var codexSecondaryLimit: codexActiveLimit?.secondary || ({})
    property var codexCredits: codexActiveLimit?.credits || ({})
    property var codexIndividualLimit: codexActiveLimit?.individualLimit || ({})
    property var codexUsageSummary: codexTokenUsage?.summary || ({})
    property var codexDailyUsageBuckets: codexTokenUsage?.dailyUsageBuckets || []
    property string codexPlan: codexActiveLimit?.planType || "unknown"
    property int codexUsedPercent: Number(codexUsage?.derived?.usedPercent || codexPrimaryLimit?.usedPercent || 0)
    property int codexLeftPercent: Number(codexUsage?.derived?.leftPercent ?? Math.max(0, 100 - codexUsedPercent))
    property string codexResetsIn: codexUsage?.derived?.resetsInText || "unknown"
    property bool codexOk: codexUsage?.ok ?? false

    width: 400
    height: 96
    padding: 10

    function refresh() {
        codexRunner.running = false
        codexRunner.running = true
    }

    function percentBar(value) {
        const blocks = 24
        const filled = Math.max(0, Math.min(blocks, Math.round(value / 100 * blocks)))
        return "[" + "■".repeat(filled) + "-".repeat(blocks - filled) + "]"
    }

    function titleCase(value) {
        if (!value) {
            return "Unknown"
        }

        return value.charAt(0).toUpperCase() + value.slice(1)
    }

    function windowLabel(minutes) {
        if (minutes === 10080) {
            return "Weekly"
        }

        if (minutes === 1440) {
            return "Daily"
        }

        return "Limit"
    }

    function parseCodexUsage(text) {
        root.codexUsage = JSON.parse(text)
    }

    Column {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        spacing: 2

        Item {
            width: parent.width
            height: 18

            Text {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                color: "#95d5b2"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 13
                text: "󰧑 Codex"
            }

            Text {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                color: "#d7fbe8"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 13
                text: "Plan: " + root.titleCase(root.codexPlan)
            }
        }

        Text {
            width: parent.width
            height: 18
            clip: true
            color: "#95d5b2"
            font.family: "JetBrainsMono Nerd Font"
            font.pixelSize: 14
            text: "┄".repeat(80)
        }

        Item {
            width: parent.width
            height: 18

            Text {
                id: codexWindow

                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                width: 56
                color: "#95d5b2"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 13
                text: root.windowLabel(root.codexPrimaryLimit?.windowDurationMins)
            }

            Row {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                spacing: 8

                Text {
                    width: 28
                    horizontalAlignment: Text.AlignRight
                    color: "#d7fbe8"
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 13
                    text: root.codexUsedPercent + "%"
                }

                Text {
                    color: "#95d5b2"
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 13
                    text: root.percentBar(root.codexUsedPercent)
                }

                Text {
                    color: "#d7fbe8"
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 13
                    text: root.codexLeftPercent + "% left"
                }
            }
        }

        Item {
            width: parent.width
            height: 18

            Text {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                color: "#6f8f83"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 13
                text: "Resets in " + root.codexResetsIn
            }
        }
    }

    Process {
        id: codexRunner
        command: ["codex-usage"]

        stdout: StdioCollector {
            waitForEnd: true
            onStreamFinished: root.parseCodexUsage(text)
        }
    }

    Timer {
        interval: 300000
        running: true
        repeat: true
        onTriggered: root.refresh()
    }

    Component.onCompleted: root.refresh()
}
