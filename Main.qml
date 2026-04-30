import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
ApplicationWindow {

    id: root
    width: 390
    height: 720
    visible: true
    title: qsTr("GetMathTable")
    color: "#f6f7fb"

    //Top ToolBar (App Bar)
    header: ToolBar{
        // RowLayout used for proper spacing/alignment
        RowLayout{
            anchors.fill: parent
            // 🍔 Hamburger menu button
            ToolButton{
                text: "☰"
                onClicked: drawer.open()//open side menu
            }
            // Title in center (dynamic based on current page)
            Label{
                text: stackView.currentItem.title//takes title from page
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
            }
        }
    }
    //SIDE DRAWER (Menu)
    Drawer{
        id:drawer

        width: root.width * 0.7// Drawer width = 70% of screen


        //vertical menu layout
        Item {
            anchors.fill: parent
            anchors.margins: 10//act like padding

            ColumnLayout{
                anchors.fill: parent
                spacing: 10

                // ---- Menu Item: Math Table ----
                Button{
                    text: "Math Table"
                    Layout.fillWidth: true

                    onClicked: {
                        // Replace current page with MathTablePage
                        stackView.replace("qrc:/MathTablePage.qml")
                        drawer.close()
                    }
                }
                Button{
                    text: "Factorial"
                    Layout.fillWidth: true

                    onClicked: {
                        // Replace current page with FactorialPage
                        stackView.replace("qrc:/FactorialPage.qml")
                        drawer.close()
                    }
                }
                // ---- Future features placeholder ----
                // We can add more like:
                // Button { text: "Prime Check" }
            }
        }
    }

    //Page Container
    StackView{
        id:stackView

        //Fill entire window
        anchors.fill: parent


        // First screen when app opens
        initialItem: "qrc:/MathTablePage.qml"
    }

}
