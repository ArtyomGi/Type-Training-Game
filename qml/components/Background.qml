import QtQuick 2.0

Grid {
    id: mud
    columns: Math.ceil(root.width / 64)

    Repeater {
        model: (root.width / 64 + 1) * (root.height / 64 + 1)
        delegate: Image {
            width: 64
            height: 64
            source: "qrc:/images/background.png"
            fillMode: Image.PreserveAspectFit
            smooth: false
        }
    }
}
