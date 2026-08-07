import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import QtQuick

Item {
    id: root

    property bool outputOpen: false
    property bool inputOpen: false
    readonly property bool anyOpen: outputOpen || inputOpen

    function closeMenus() {
        outputOpen = false
        inputOpen = false
    }

    readonly property int iconWidth: 22
    readonly property int iconGap: 8
    readonly property int dropdownWidth: 360
    readonly property int rowGap: 8
    readonly property int closedHeight: 32 * 2 + rowGap

    readonly property var outputDevices: Pipewire.nodes.values
        .filter(node => node.isSink && !node.isStream)
        .sort((a, b) => deviceLabel(a, "Unknown output").localeCompare(deviceLabel(b, "Unknown output")))
    readonly property var inputDevices: Pipewire.nodes.values
        .filter(node => !node.isSink && !node.isStream && node.audio)
        .sort((a, b) => deviceLabel(a, "Unknown input").localeCompare(deviceLabel(b, "Unknown input")))
    readonly property var currentOutput: Pipewire.defaultAudioSink
    readonly property var currentInput: Pipewire.defaultAudioSource
    readonly property string currentOutputText: currentOutput ? deviceLabel(currentOutput, "Unknown output") : "No output device"
    readonly property string currentInputText: currentInput ? deviceLabel(currentInput, "Unknown input") : "No input device"

    function deviceLabel(node, fallback) {
        if (!node) {
            return fallback
        }

        return node.description || node.nickname || node.name || fallback
    }

    width: iconWidth + iconGap + dropdownWidth
    height: closedHeight + Math.max(
        outputOpen ? outputOptionsColumn.height + 6 : 0,
        inputOpen ? inputOptionsColumn.height + 6 : 0
    )
    z: 10

    Column {
        width: parent.width
        spacing: root.rowGap

        Item {
            id: outputRow

            width: parent.width
            height: outputButton.height
            z: root.outputOpen ? 2 : 1

            Text {
                id: outputIcon

                width: root.iconWidth
                anchors.top: outputButton.top
                anchors.topMargin: 4
                horizontalAlignment: Text.AlignHCenter
                color: "#95d5b2"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 18
                text: "󰓃"
            }

            Rectangle {
                id: outputButton

                x: root.iconWidth + root.iconGap
                width: root.dropdownWidth
                height: 32
                radius: 10
                color: "#232828"
                border.width: 1
                border.color: "#3c4747"

                Text {
                    anchors.left: parent.left
                    anchors.right: outputChevron.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 12
                    anchors.rightMargin: 8
                    color: "#95d5b2"
                    elide: Text.ElideRight
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 14
                    text: root.currentOutputText
                }

                Text {
                    id: outputChevron

                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: 12
                    color: "#95d5b2"
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 14
                    text: root.outputOpen ? "󰅀" : "󰅂"
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        root.outputOpen = !root.outputOpen
                        if (root.outputOpen) {
                            root.inputOpen = false
                        }
                    }
                }
            }

            ClippingRectangle {
                id: outputMenu

                anchors.top: outputButton.bottom
                anchors.topMargin: 4
                x: outputButton.x
                width: outputButton.width
                height: outputOptionsColumn.height + 2
                radius: 10
                color: "#232828"
                border.width: 1
                border.color: "#3c4747"
                visible: root.outputOpen
                clip: true
                z: 20

                Column {
                    id: outputOptionsColumn

                    x: 1
                    y: 1
                    width: parent.width - 2

                    Repeater {
                        model: root.outputDevices

                        Rectangle {
                            id: outputOption

                            required property var modelData
                            readonly property bool selected: root.currentOutput && modelData.id === root.currentOutput.id

                            width: outputOptionsColumn.width
                            height: 30
                            color: outputOptionMouse.containsMouse ? "#2d3838" : (selected ? "#263131" : "transparent")

                            Text {
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.leftMargin: 12
                                anchors.rightMargin: 12
                                color: outputOption.selected ? "#d7fbe8" : "#95d5b2"
                                elide: Text.ElideRight
                                font.family: "JetBrainsMono Nerd Font"
                                font.pixelSize: 13
                                text: (outputOption.selected ? "✓ " : "  ") + root.deviceLabel(outputOption.modelData, "Unknown output")
                            }

                            MouseArea {
                                id: outputOptionMouse

                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor

                                onClicked: {
                                    Pipewire.preferredDefaultAudioSink = outputOption.modelData
                                    Quickshell.execDetached(["wpctl", "set-default", String(outputOption.modelData.id)])
                                    root.outputOpen = false
                                }
                            }
                        }
                    }
                }
            }
        }

        Item {
            id: inputRow

            width: parent.width
            height: inputButton.height
            z: root.inputOpen ? 2 : 1

            Text {
                id: inputIcon

                width: root.iconWidth
                anchors.top: inputButton.top
                anchors.topMargin: 4
                horizontalAlignment: Text.AlignHCenter
                color: "#95d5b2"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 18
                text: ""
            }

            Rectangle {
                id: inputButton

                x: root.iconWidth + root.iconGap
                width: root.dropdownWidth
                height: 32
                radius: 10
                color: "#232828"
                border.width: 1
                border.color: "#3c4747"

                Text {
                    anchors.left: parent.left
                    anchors.right: inputChevron.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 12
                    anchors.rightMargin: 8
                    color: "#95d5b2"
                    elide: Text.ElideRight
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 14
                    text: root.currentInputText
                }

                Text {
                    id: inputChevron

                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.rightMargin: 12
                    color: "#95d5b2"
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 14
                    text: root.inputOpen ? "󰅀" : "󰅂"
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        root.inputOpen = !root.inputOpen
                        if (root.inputOpen) {
                            root.outputOpen = false
                        }
                    }
                }
            }

            ClippingRectangle {
                id: inputMenu

                anchors.top: inputButton.bottom
                anchors.topMargin: 4
                x: inputButton.x
                width: inputButton.width
                height: inputOptionsColumn.height + 2
                radius: 10
                color: "#232828"
                border.width: 1
                border.color: "#3c4747"
                visible: root.inputOpen
                clip: true
                z: 20

                Column {
                    id: inputOptionsColumn

                    x: 1
                    y: 1
                    width: parent.width - 2

                    Repeater {
                        model: root.inputDevices

                        Rectangle {
                            id: inputOption

                            required property var modelData
                            readonly property bool selected: root.currentInput && modelData.id === root.currentInput.id

                            width: inputOptionsColumn.width
                            height: 30
                            color: inputOptionMouse.containsMouse ? "#2d3838" : (selected ? "#263131" : "transparent")

                            Text {
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.leftMargin: 12
                                anchors.rightMargin: 12
                                color: inputOption.selected ? "#d7fbe8" : "#95d5b2"
                                elide: Text.ElideRight
                                font.family: "JetBrainsMono Nerd Font"
                                font.pixelSize: 13
                                text: (inputOption.selected ? "✓ " : "  ") + root.deviceLabel(inputOption.modelData, "Unknown input")
                            }

                            MouseArea {
                                id: inputOptionMouse

                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor

                                onClicked: {
                                    Pipewire.preferredDefaultAudioSource = inputOption.modelData
                                    Quickshell.execDetached(["wpctl", "set-default", String(inputOption.modelData.id)])
                                    root.inputOpen = false
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
