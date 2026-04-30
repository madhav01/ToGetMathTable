import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ToGetMathTable 1.0

Page {
    id: root
    title: "Math Table"

    // Backend object that generates the multiplication table text.
    MathTable {
        id: math
    }

    DesignTokens {
        id: theme
    }

    // Screen state: controls whether the result card shows data or an empty state.
    property bool showResult: false

    // Page background: Controls Page uses background, not a direct color property.
    background: Rectangle {
        color: theme.appBackground
    }

    // Main page layout: input, actions, and result surface.
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: theme.pageMargin
        spacing: theme.blockSpacing

        // Number input: styled field with numeric keyboard hints.
        PremiumTextField {
            id: inputField
            Layout.fillWidth: true
            placeholderText: qsTr("Enter number")
            inputMethodHints: Qt.ImhFormattedNumbersOnly
            selectByMouse: true
            onAccepted: genButton.clicked()
        }

        // Action row: primary action expands, secondary action stays compact.
        RowLayout {
            Layout.fillWidth: true
            spacing: 12

            PremiumButton {
                id: genButton
                text: qsTr("Generate")
                variant: "primary"
                Layout.fillWidth: true

                onClicked: {
                    if (inputField.text.length === 0) {
                        showResult = false
                        return
                    }

                    resultText.text = math.generateTable(inputField.text)
                    showResult = true
                }
            }

            PremiumButton {
                id: clear
                text: qsTr("Clear")
                variant: "secondary"
                Layout.preferredWidth: 110

                onClicked: {
                    inputField.clear()
                    resultText.text = ""
                    showResult = false
                }
            }
        }

        // Result card: always visible so the page keeps a complete app structure.
        ResultCard {
            Layout.fillWidth: true
            Layout.fillHeight: true

            // Empty state: quiet placeholder before the user generates a table.
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

            // Generated table: header plus scrollable monospace result for clean alignment.
            ColumnLayout {
                anchors.fill: parent
                spacing: 14
                visible: showResult

                Text {
                    Layout.fillWidth: true
                    text: inputField.text + qsTr(" times table")
                    color: theme.text
                    font.pixelSize: 18
                    font.weight: Font.Bold
                    elide: Text.ElideRight
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 1
                    color: theme.border
                }

                ScrollView {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true

                    TextArea {
                        id: resultText
                        readOnly: true
                        wrapMode: Text.WrapAnywhere
                        color: theme.text
                        font.pixelSize: 22
                        font.family: "monospace"
                        background: null
                    }
                }
            }
        }
    }
}
