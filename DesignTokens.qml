import QtQuick

QtObject {
    // Central color palette used by every screen.
    readonly property color appBackground: "#f4f7fb"
    readonly property color surface: "#ffffff"
    readonly property color surfaceMuted: "#eef4ff"
    readonly property color primary: "#24439b"
    readonly property color primaryPressed: "#1b3278"
    readonly property color primarySoft: "#e7edff"
    readonly property color accent: "#0f9f9a"
    readonly property color text: "#172033"
    readonly property color textMuted: "#6f7787"
    readonly property color border: "#d8deea"
    readonly property color borderStrong: "#aeb8cc"
    readonly property color shadow: "#1f2a44"

    // Shared sizing values for spacing and rounded controls.
    readonly property int pageMargin: 20
    readonly property int blockSpacing: 18
    readonly property int controlHeight: 54
    readonly property int controlRadius: 14
    readonly property int cardRadius: 8
}
