import QtQuick

FocusScope {
    id: control

    // Public API kept similar to TextField so page code can use text, clear(), and accepted.
    property alias text: editor.text
    property alias inputMethodHints: editor.inputMethodHints
    property alias selectByMouse: editor.selectByMouse
    property string placeholderText: ""
    signal accepted()

    DesignTokens {
        id: theme
    }

    // Field sizing used by layouts on both calculator pages.
    implicitHeight: 58

    // Public helper used by the Clear buttons.
    function clear() {
        editor.clear()
    }

    // Field container: custom drawn so Android Material does not float the placeholder.
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

    // Placeholder is a simple overlay and disappears completely after typing.
    Text {
        anchors.left: parent.left
        anchors.leftMargin: 18
        anchors.verticalCenter: parent.verticalCenter
        text: control.placeholderText
        visible: editor.text.length === 0 && !editor.activeFocus
        color: "#9aa2b2"
        font.pixelSize: 19
        elide: Text.ElideRight
    }

    // Actual editable number input.
    TextInput {
        id: editor
        anchors.fill: parent
        anchors.leftMargin: 18
        anchors.rightMargin: 18
        verticalAlignment: TextInput.AlignVCenter
        color: theme.text
        selectedTextColor: theme.text
        selectionColor: theme.primarySoft
        font.pixelSize: 19
        clip: true
        focus: control.activeFocus
        onAccepted: control.accepted()
    }

    // Tapping anywhere inside the field focuses the editor.
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton
        onPressed: function(mouse) {
            editor.forceActiveFocus()
            mouse.accepted = false
        }
    }
}
