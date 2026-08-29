import Quickshell.Services.Mpris
import QtQuick

BarBlock {
    id: root

    property int lastPlaying: 0

    readonly property var player: {
        const activePlayers = Mpris.players.values.filter(player => player.playbackState !== MprisPlaybackState.Stopped)
        const playing = activePlayers.findIndex(player => player.isPlaying)
        if (playing >= 0) {
            lastPlaying = playing
        } else {
            return activePlayers[lastPlaying]
        }
        return activePlayers[playing] ?? activePlayers[lastPlaying] ?? null;
    }

    function truncate(value, maxLength) {
        if (!value) {
            return ""
        }

        return value.length > maxLength ? value.slice(0, maxLength - 1) + "…" : value
    }

    visible: player !== null && text.length > 0
    textColor: player && player.isPlaying ? "#1c2929" : "#b1f0cd"
    backgroundColor: player && player.isPlaying ? "#95d5b2" : "#1c2929"
    fontPixelSize: 14
    text: player ? `${player.isPlaying ? "" : ""}  ${truncate(player.trackTitle, 50)}  ${truncate(player.trackArtist, 20)}` : ""

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
