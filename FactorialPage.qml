import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ToGetMathTable 1.0

Page {
    id: root
    title: "Factorial"
    color: theme.appBackground

    // Backend object that performs the factorial calculation.
    MathTable {
        id: math
    }

    DesignTokens {
        id: theme
    }

    // Screen state and formatted result pieces shown in the card.
    property bool showResult: false
    property string factorialInput: ""
    property string factorialValue: ""
    property string resultMessage: ""

    // Formats long numeric results with commas for better readability.
    function formatNumber(value) {
        return value.replace(/\B(?=(\d{3})+(?!\d))/g, ",")
    }

    // Converts the existing backend text into a premium two-line result layout.
    function showFactorialResult(rawResult) {
        var parts = rawResult.split("=")

        if (parts.length < 2) {
            resultMessage = rawResult
            factorialInput = ""
            factorialValue = ""
            showResult = true
            return
        }

        factorialInput = inputField.text
        factorialValue = formatNumber(parts[1].trim())
        resultMessage = ""
        showResult = true
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
                        showResult = false
                        return
                    }

                    showFactorialResult(math.factorial(inputField.text))
                }
            }

            PremiumButton {
                text: qsTr("Clear")
                variant: "secondary"
                Layout.preferredWidth: 110

                onClicked: {
                    inputField.clear()
                    factorialInput = ""
                    factorialValue = ""
                    resultMessage = ""
                    showResult = false
                }
            }
        }

        // Result card: keeps the screen balanced even before calculation.
        ResultCard {
            Layout.fillWidth: true
            Layout.fillHeight: true

            // Empty state shown before any factorial is calculated.
            Column {
                anchors.centerIn: parent
                spacing: 8
                visible: !showResult

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Result")
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

            // Formatted result layout: clear label, large value, and compact metadata.
            ColumnLayout {
                anchors.fill: parent
                spacing: 12
                visible: showResult && resultMessage.length === 0

                Text {
                    Layout.fillWidth: true
                    text: factorialInput + "!"
                    color: theme.primary
                    font.pixelSize: 28
                    font.weight: Font.Bold
                    elide: Text.ElideRight
                }

                Text {
                    Layout.fillWidth: true
                    text: factorialValue
                    color: theme.text
                    font.pixelSize: 34
                    font.weight: Font.DemiBold
                    wrapMode: Text.WrapAnywhere
                }

                Rectangle {
                    Layout.fillWidth: true
                    height: 1
                    color: theme.border
                }

                Text {
                    Layout.fillWidth: true
                    text: qsTr("Factorial result")
                    color: theme.textMuted
                    font.pixelSize: 14
                }

                Item {
                    Layout.fillHeight: true
                }
            }

            // Fallback result message for invalid input or backend errors.
            Text {
                anchors.centerIn: parent
                width: parent.width
                visible: showResult && resultMessage.length > 0
                text: resultMessage
                color: theme.text
                font.pixelSize: 20
                font.weight: Font.DemiBold
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.Wrap
            }
        }
    }
}
