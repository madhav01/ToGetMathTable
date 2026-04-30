import QtQuick

Item {
    id: root

    // Children placed inside ResultCard are automatically inserted into this padded area.
    default property alias content: contentHost.data
    property int padding: 22

    DesignTokens {
        id: theme
    }

    // Soft shadow separates the result area from the app background.
    Rectangle {
        anchors.fill: parent
        anchors.topMargin: 3
        radius: theme.cardRadius
        color: theme.shadow
        opacity: 0.06
    }

    // White surface with a light border matches a real app card without looking heavy.
    Rectangle {
        id: surface
        anchors.fill: parent
        radius: theme.cardRadius
        color: theme.surface
        border.width: 1
        border.color: theme.border
    }

    // Content host keeps internal spacing consistent on both result screens.
    Item {
        id: contentHost
        anchors.fill: surface
        anchors.margins: root.padding
    }
}
