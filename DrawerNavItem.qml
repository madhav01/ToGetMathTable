import QtQuick

Item {
    id: root

    // Public data used by the drawer to show each navigation destination.
    property string text: ""
    property string iconText: ""
    property bool selected: false
    signal clicked()

    DesignTokens {
        id: theme
    }

    implicitHeight: 52

    // Selected and pressed states make the drawer feel interactive and app-like.
    Rectangle {
        anchors.fill: parent
        radius: 12
        color: root.selected ? theme.primarySoft : (tap.pressed ? "#eef2f7" : "transparent")
        border.width: root.selected ? 1 : 0
        border.color: root.selected ? "#cbd7ff" : "transparent"
    }

    // Compact row with a small visual marker and clear label.
    Row {
        anchors.fill: parent
        anchors.leftMargin: 14
        anchors.rightMargin: 14
        spacing: 12

        Rectangle {
            width: 30
            height: 30
            radius: 8
            anchors.verticalCenter: parent.verticalCenter
            color: root.selected ? theme.primary : theme.surfaceMuted

            Text {
                anchors.centerIn: parent
                text: root.iconText
                color: root.selected ? "white" : theme.primary
                font.pixelSize: 13
                font.weight: Font.Bold
            }
        }

        Text {
            width: parent.width - 56
            anchors.verticalCenter: parent.verticalCenter
            text: root.text
            color: root.selected ? theme.primary : theme.text
            font.pixelSize: 15
            font.weight: root.selected ? Font.DemiBold : Font.Medium
            elide: Text.ElideRight
        }
    }

    // Mouse area sends one simple navigation signal to the drawer.
    MouseArea {
        id: tap
        anchors.fill: parent
        onClicked: root.clicked()
    }
}
