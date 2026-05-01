import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ToGetMathTable 1.0

Page {
    id: root
    title: "Prime Number"

    // Backend object that checks whether the input is a prime number.
    MathTable {
        id: math
    }

    DesignTokens {
        id: theme
    }

    // Screen state and result message shown in the card.
    property bool showResult: false
    property string resultMessage: ""

    // Page background: Controls Page uses background, not a direct color property.
    background: Rectangle {
        color: theme.appBackground
    }

    // Main page layout: input, actions, and result surface.
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: theme.pageMargin
        spacing: theme.blockSpacing

        // Number input: numeric-only keyboard and consistent premium field style.
        PremiumTextField {
            id: inputField
            Layout.fillWidth: true
            placeholderText: qsTr("Enter number")
            inputMethodHints: Qt.ImhDigitsOnly
            selectByMouse: true
            onAccepted: calculateButton.clicked()
        }

        // Action row: calculate is primary, clear is secondary.
        RowLayout {
            Layout.fillWidth: true
            spacing: 12

            PremiumButton {
                id: calculateButton
                text: qsTr("Calculate")
                variant: "primary"
                Layout.fillWidth: true

                onClicked: {
                    if (inputField.text.length === 0) {
                        root.showResult = false
                        return
                    }

                    root.resultMessage = math.isPrime(inputField.text)
                    root.showResult = true
                }
            }

            PremiumButton {
                text: qsTr("Clear")
                variant: "secondary"
                Layout.preferredWidth: 110

                onClicked: {
                    inputField.clear()
                    root.resultMessage = ""
                    root.showResult = false
                }
            }
        }

        // Result card: keeps the screen balanced even before calculation.
        ResultCard {
            Layout.fillWidth: true
            Layout.fillHeight: true

            // Empty state shown before any prime check is calculated.
            Column {
                anchors.centerIn: parent
                spacing: 8
                visible: !root.showResult

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Prime check result")
                    color: theme.text
                    font.pixelSize: 18
                    font.weight: Font.DemiBold
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("No result yet")
                    color: theme.textMuted
                    font.pixelSize: 14
                }
            }

            // Prime result message from the backend.
            Text {
                anchors.centerIn: parent
                width: parent.width
                visible: root.showResult && root.resultMessage.length > 0
                text: root.resultMessage
                color: theme.text
                font.pixelSize: 20
                font.weight: Font.DemiBold
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.Wrap
            }
        }
    }
}
