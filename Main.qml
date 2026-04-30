import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Layouts

ApplicationWindow {
    id: root

    // Window setup: default phone-sized preview and shared app background.
    width: 390
    height: 720
    visible: true
    title: qsTr("GetMathTable")
    color: theme.appBackground
    Material.theme: Material.Light

    DesignTokens {
        id: theme
    }

    // Top app bar: fixed mobile header with centered page title and custom menu icon.
    header: ToolBar {
        id: toolBar
        height: 64

        background: Rectangle {
            color: theme.primary

            Rectangle {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                height: 1
                color: "#10245f"
                opacity: 0.35
            }
        }

        // Left menu button: drawn with simple bars so it stays crisp on every density.
        ToolButton {
            id: menuButton
            width: 48
            height: 48
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 8
            onClicked: drawer.open()

            contentItem: Item {
                Repeater {
                    model: 3

                    Rectangle {
                        width: 26
                        height: 3
                        radius: 2
                        x: 11
                        y: 15 + index * 9
                        color: "white"
                        opacity: 0.92
                    }
                }
            }

            background: Rectangle {
                radius: width / 2
                color: menuButton.down ? "#ffffff" : "transparent"
                opacity: menuButton.down ? 0.16 : 1
            }
        }

        // Center title: bound to the active StackView page title.
        Label {
            id: titleLabel
            text: stackView.currentItem ? stackView.currentItem.title : qsTr("Math Table")
            anchors.centerIn: parent
            color: "white"
            font.pixelSize: 21
            font.weight: Font.Bold
            opacity: 0.98
        }
    }

    // Side drawer: premium navigation surface with selected-page feedback.
    Drawer {
        id: drawer
        edge: Qt.LeftEdge
        width: Math.min(root.width * 0.78, 320)

        background: Rectangle {
            color: theme.surface
        }

        Pane {
            anchors.fill: parent
            padding: 0
            background: null

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 16

                // Drawer header: simple brand block at the top of the menu.
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 4

                    Text {
                        text: qsTr("Get Math Table")
                        color: theme.text
                        font.pixelSize: 21
                        font.weight: Font.Bold
                    }

                    Text {
                        text: qsTr("Practice tools")
                        color: theme.textMuted
                        font.pixelSize: 13
                    }
                }

                // Navigation list: each item updates the StackView and closes the drawer.
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 8

                    DrawerNavItem {
                        Layout.fillWidth: true
                        text: qsTr("Math Table")
                        iconText: "x"
                        selected: stackView.currentItem && stackView.currentItem.title === "Math Table"

                        onClicked: {
                            stackView.replace("qrc:/MathTablePage.qml")
                            drawer.close()
                        }
                    }

                    DrawerNavItem {
                        Layout.fillWidth: true
                        text: qsTr("Factorial")
                        iconText: "n!"
                        selected: stackView.currentItem && stackView.currentItem.title === "Factorial"

                        onClicked: {
                            stackView.replace("qrc:/FactorialPage.qml")
                            drawer.close()
                        }
                    }
                }

                // Spacer keeps navigation pinned near the top on tall phones.
                Item {
                    Layout.fillHeight: true
                }
            }
        }
    }

    // Page container: owns the active calculator screen.
    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: "qrc:/MathTablePage.qml"
    }
}
