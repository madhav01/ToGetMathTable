import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ToGetMathTable 1.0

Page{
    id:root
    title: "Math Table"

    MathTable {
        id: math
    }
    property bool showResult: false
    readonly property int pageMargin: 20

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: root.pageMargin
        spacing: 18

        TextField {
            id: inputField
            Layout.fillWidth: true
            placeholderText: qsTr("Enter number")
            inputMethodHints: Qt.ImhFormattedNumbersOnly
            font.pixelSize: 20
            selectByMouse: true
            onAccepted: genButton.clicked()
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 12

            Button {
                id: genButton
                text: qsTr("Generate")
                Layout.fillWidth: true
                Layout.preferredHeight: 48
                onClicked: {
                    if (inputField.text.length === 0) {
                        showResult = false
                        return
                    }
                    resultText.text = math.generateTable(inputField.text)
                    showResult = true
                }
            }

            Button {
                id: clear
                text: qsTr("Clear")
                Layout.preferredWidth: 104
                Layout.preferredHeight: 48
                onClicked: {
                    inputField.clear()
                    resultText.text=""
                    showResult = false
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: showResult
            color: "white"
            radius: 8
            border.color: "#d8dde8"
            border.width: 1

            ScrollView {
                anchors.fill: parent
                anchors.margins: 18
                // clip: true

                TextArea {
                    id: resultText
                    readOnly: true
                    wrapMode: Text.WrapAnywhere
                    color: "#202124"
                    font.pixelSize: 20
                    font.family: "monospace"
                    background: null
                }
            }
        }

        Item {
            Layout.fillHeight: true
            visible: !showResult
        }
    }


}
