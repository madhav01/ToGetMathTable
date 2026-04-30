import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import ToGetMathTable 1.0
Page{
    MathTable{id:math}
    id:root
    title: "Factorial"

    property bool showResult: false

    ColumnLayout{
        anchors.fill: parent
        anchors.margins: 20
        spacing: 18

        //text UI
        TextField{
            id:inputFileld
            Layout.fillWidth: true
            placeholderText: "Enter Number"
            inputMethodHints: Qt.ImhDigitsOnly
            font.pixelSize: 20
            selectByMouse: true
        }

        //Button UI
        RowLayout{
            Layout.fillWidth: true
            spacing: 12

            Button{
                text: qsTr("Calculate")
                Layout.fillWidth: true
                Layout.preferredHeight: 48

                onClicked: {
                    if(inputFileld.text.length===0)return;
                    resultText.text = math.factorial(inputFileld.text)
                    showResult=true
                }
            }
            Button{
                text: "Clear"
                Layout.preferredWidth: 104
                Layout.preferredHeight: 48

                onClicked: {
                    inputFileld.clear()
                    resultText.text=""
                    showResult=false
                }
            }
        }
        //Result UI
        Rectangle{
            Layout.fillWidth: true
            Layout.fillHeight: true
            visible: showResult
            color: "white"
            radius: 8
            border.color: "#d8dde8"

            Text {
                id: resultText
                anchors.centerIn: parent
                wrapMode: Text.Wrap
                font.family: "monospace"
                font.pixelSize: 22
                color: "#202124"
            }
        }
        Item{
            Layout.fillHeight: true
            visible: !showResult
        }

    }
}
