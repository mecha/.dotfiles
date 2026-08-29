import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick

BarBlock {
    id: root

    readonly property int iconSize: 20
    readonly property int itemSpacing: 6

    implicitWidth: Math.max(row.implicitWidth + 18, 0)
    visible: SystemTray.items.values.some(item => item.status !== Status.Passive)

    Row {
        id: row
        anchors.centerIn: parent
        spacing: root.itemSpacing
        layoutDirection: Qt.RightToLeft

        Repeater {
            model: SystemTray.items.values.filter(item => item.status !== Status.Passive)

            delegate: Item {
                id: trayItem

                required property var modelData
                readonly property var item: modelData

                width: root.iconSize
                height: root.iconSize

                IconImage {
                    anchors.fill: parent
                    source: trayItem.item.icon
                    implicitSize: root.iconSize
                    asynchronous: true
                }

                QsMenuAnchor {
                    id: menuAnchor

                    menu: trayItem.item.menu
                    anchor.item: trayItem
                }

                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                    cursorShape: Qt.PointingHandCursor

                    onClicked: mouse => {
                        if (mouse.button === Qt.RightButton && trayItem.item.hasMenu) {
                            menuAnchor.open()
                        } else if (mouse.button === Qt.MiddleButton) {
                            trayItem.item.secondaryActivate()
                        } else if (trayItem.item.onlyMenu && trayItem.item.hasMenu) {
                            menuAnchor.open()
                        } else {
                            trayItem.item.activate()
                        }
                    }

                    onWheel: wheel => {
                        trayItem.item.scroll(wheel.angleDelta.y, false)
                    }
                }
            }
        }
    }
}
