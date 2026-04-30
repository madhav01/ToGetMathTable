import QtQuick
import QtQuick.Controls

Button {
    id: control

    // Public style option: primary for main action, secondary for supporting action.
    property string variant: "primary"

    DesignTokens {
        id: theme
    }

    // Button sizing and typography shared by all app actions.
    implicitHeight: theme.controlHeight
    font.pixelSize: 15
    font.weight: Font.DemiBold
    hoverEnabled: true

    // Custom text content keeps colors consistent with the chosen button variant.
    contentItem: Text {
        text: control.text
        color: control.variant === "primary" ? "white" : theme.text
        font: control.font
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    // Layered background gives the button subtle elevation and a clear press state.
    background: Item {
        implicitWidth: 120
        implicitHeight: theme.controlHeight

        Rectangle {
            anchors.fill: parent
            anchors.topMargin: 3
            radius: theme.controlRadius
            color: theme.shadow
            opacity: control.enabled ? 0.10 : 0.0
        }

        Rectangle {
            anchors.fill: parent
            radius: theme.controlRadius
            color: {
                if (control.variant === "primary")
                    return control.down ? theme.primaryPressed : theme.primary

                return control.down ? "#dde5ef" : "#edf1f6"
            }
            border.width: control.variant === "primary" ? 0 : 1
            border.color: control.down ? theme.borderStrong : theme.border
        }
    }
}
