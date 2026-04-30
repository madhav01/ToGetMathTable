import QtQuick
import QtQuick.Controls

TextField {
    id: control

    DesignTokens {
        id: theme
    }

    // Input field spacing and font size are tuned for one-handed mobile use.
    implicitHeight: 58
    leftPadding: 18
    rightPadding: 18
    topPadding: 8
    bottomPadding: 8
    color: theme.text
    placeholderTextColor: "#9aa2b2"
    selectionColor: theme.primarySoft
    selectedTextColor: theme.text
    font.pixelSize: 19

    // Custom surface highlights focus without changing the layout size.
    background: Item {
        implicitHeight: 58

        Rectangle {
            anchors.fill: parent
            anchors.topMargin: 2
            radius: theme.cardRadius
            color: theme.shadow
            opacity: control.activeFocus ? 0.08 : 0.04
        }

        Rectangle {
            anchors.fill: parent
            radius: theme.cardRadius
            color: theme.surface
            border.width: control.activeFocus ? 2 : 1
            border.color: control.activeFocus ? theme.primary : theme.border
        }
    }
}
