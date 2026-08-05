import Quickshell
import Quickshell.Io
import QtQuick

PanelWindow {
    id: indicator
    anchors {
        bottom: true
        left: true
        right: true
    }
    margins.bottom: 80

    implicitHeight: 60
    color: "transparent"

    exclusionMode: ExclusionMode.Ignore

    visible: isRecording

    property bool isRecording: false

    Process {
        id: statusChecker
        command: ["hyprvoice", "status"]

        stdout: SplitParser {
            onRead: data => {
                indicator.isRecording = data.includes("status=transcribing")
            }
        }
    }

    // Poll hyprvoice status
    Timer {
        interval: 150
        running: true
        repeat: true

        onTriggered: {
            statusChecker.running = false
            statusChecker.running = true
        }
    }

    // Visual indicator - centered in window
    Rectangle {
        anchors.centerIn: parent
        width: 180
        height: 40
        radius: 20
        color: "#95d5b2"
        opacity: pulseAnimation.opacity

        SequentialAnimation on opacity {
            id: pulseAnimation
            running: indicator.isRecording
            loops: Animation.Infinite

            NumberAnimation { from: 0.5; to: 1.0; duration: 600; easing.type: Easing.InOutQuad }
            NumberAnimation { from: 1.0; to: 0.5; duration: 600; easing.type: Easing.InOutQuad }
        }

        Text {
            anchors.centerIn: parent
            text: " Recording"
            color: "#1a1b26"
            font { pixelSize: 16; bold: true }
        }
    }
}
