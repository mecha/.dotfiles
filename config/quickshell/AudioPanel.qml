import QtQuick

Item {
    id: root

    readonly property int padding: 10
    readonly property int closedHeight: deviceSwitcher.closedHeight + padding * 2
    readonly property bool anyOpen: deviceSwitcher.anyOpen

    function closeMenus() {
        deviceSwitcher.closeMenus()
    }

    width: deviceSwitcher.width + padding * 2
    height: closedHeight
    z: anyOpen ? 20 : 1

    DrawerPanel {
        id: panel
        width: parent.width
        height: root.closedHeight
        padding: 0
    }

    AudioDeviceSwitcher {
        id: deviceSwitcher
        x: root.padding
        y: root.padding
    }
}
