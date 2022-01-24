import QtQuick 2.0

Item {
    id: root

    Row {
        id: grass

        Repeater {
            model: root.width / 64 + 1
            delegate: Image {
                width: 64
                height: 64
                source: "qrc:/images/terrain-top.png"
                fillMode: Image.PreserveAspectFit
                smooth: false
            }
        }
    }

    Grid {
        id: mud
        anchors.top: grass.bottom
        columns: Math.ceil(root.width / 64)

        Repeater {
            model: (root.width / 64 + 1) * (root.height / 64 + 1)
            delegate: Image {
                width: 64
                height: 64
                source: "qrc:/images/terrain-bottom.png"
                fillMode: Image.PreserveAspectFit
                smooth: false
            }
        }
    }
}
