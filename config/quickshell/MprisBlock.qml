import Quickshell.Services.Mpris
import QtQuick

BarBlock {
    id: root

    readonly property var player: {
        const activePlayers = Mpris.players.values.filter(player => player.playbackState !== MprisPlaybackState.Stopped)
        const playing = activePlayers.find(player => player.isPlaying)
        return playing ?? activePlayers[0] ?? null
    }

    function truncate(value, maxLength) {
        if (!value) {
            return ""
        }

        return value.length > maxLength ? value.slice(0, maxLength - 1) + "…" : value
    }

    function playerIcon(player) {
        if (!player) {
            return "󰎇"
        }

        return player.desktopEntry === "firefox" || player.identity.toLowerCase().includes("firefox") ? "󰈹" : "󰎇"
    }

    visible: player !== null && text.length > 0
    textColor: player && player.isPlaying ? "#232828" : "#48534a"
    backgroundColor: player && player.isPlaying ? "#95d5b2" : "#84a98c"
    fontPixelSize: 13
    text: player ? `${player.isPlaying ? "" : ""}  ${playerIcon(player)} ${truncate(player.trackTitle, 50)}  ${truncate(player.trackArtist, 20)}` : ""

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        enabled: root.player !== null
        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

        onClicked: mouse => {
            if (!root.player) {
                return
            }

            if (mouse.button === Qt.LeftButton) {
                root.player.togglePlaying()
            } else if (mouse.button === Qt.RightButton && root.player.canGoNext) {
                root.player.next()
            } else if (mouse.button === Qt.MiddleButton && root.player.canGoPrevious) {
                root.player.previous()
            }
        }
    }
}
