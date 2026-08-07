import QtQuick

DrawerPanel {
    id: root

    readonly property date today: new Date()
    readonly property int year: today.getFullYear()
    readonly property int month: today.getMonth()
    readonly property date firstDay: new Date(year, month, 1)
    readonly property int daysInMonth: new Date(year, month + 1, 0).getDate()
    readonly property int startOffset: (firstDay.getDay() + 6) % 7
    readonly property var dayNames: ["M", "T", "W", "T", "F", "S", "S"]

    width: 250
    height: 160
    padding: 12

    Column {
        anchors.fill: parent
        spacing: 8

        Grid {
            width: parent.width
            columns: 7
            rowSpacing: 4
            columnSpacing: 4

            Repeater {
                model: root.dayNames

                Text {
                    required property int index
                    required property string modelData
                    readonly property bool weekend: index >= 5

                    width: (parent.width - parent.columnSpacing * 6) / 7
                    height: 16
                    color: weekend ? "#5b706a" : "#6f8f83"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 14
                    text: modelData
                }
            }

            Repeater {
                model: 42

                Rectangle {
                    required property int index
                    readonly property int dayNumber: index - root.startOffset + 1
                    readonly property bool inMonth: dayNumber >= 1 && dayNumber <= root.daysInMonth
                    readonly property bool isToday: inMonth && dayNumber === root.today.getDate()
                    readonly property bool weekend: index % 7 >= 5

                    width: (parent.width - parent.columnSpacing * 6) / 7
                    height: 20
                    radius: 6
                    color: isToday ? "#95d5b2" : "transparent"

                    Text {
                        anchors.centerIn: parent
                        color: parent.isToday ? "#101e18" : (parent.inMonth ? (parent.weekend ? "#9fbdb2" : "#d7fbe8") : "#52655f")
                        font.family: "JetBrainsMono Nerd Font"
                        font.pixelSize: 13
                        font.bold: parent.isToday
                        text: parent.inMonth ? String(parent.dayNumber) : ""
                    }
                }
            }
        }
    }
}
