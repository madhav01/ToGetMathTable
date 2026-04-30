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
    Material.theme: Material.Light

    //Top ToolBar (App Bar)
    header: ToolBar{
        id:toolBar
        // 🔷 Background (Material Indigo style)
        background: Rectangle{
            color: "#3f51b5"
        }
        height: 56//// Standard Android app bar height
        // 🍔 LEFT: Hamburger menu
        ToolButton{
            id:menuButton
            icon.source: "qrc:/humburggerIcon.png"
            icon.width: 26
            icon.height: 26

            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 12
            onClicked: drawer.open()//open side menu

            background: Rectangle{
                radius: width/2
                color: "transparent"

                //subtle press effect
                opacity: menuButton.pressed?0.15:0

                Behavior on opacity {
                    NumberAnimation{
                        duration: 120
                    }
                }
            }
        }
        // Title in center (dynamic based on current page)
        Label{
            id: titleLabel
            text: stackView.currentItem.title//takes title from page
            anchors.centerIn: parent
            font.bold: true
            color: "white"
            font.pixelSize: 20
            font.weight: Font.DemiBold
            opacity: 0.95

            // 🔥 Smooth text change when switching pages
            Behavior on text {
                NumberAnimation{
                    duration: 120
                }
            }
        }
        // }
    }
    //SIDE DRAWER (Menu)
    Drawer{
        id:drawer
        edge: Qt.LeftEdge
        width: root.width * 0.7// Drawer width = 70% of screen


        //vertical menu layout
        Pane {
            anchors.fill: parent
            spacing: 10

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
