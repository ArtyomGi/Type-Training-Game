import QtQuick 2.0
import Sailfish.Silica 1.0

Item {
    id: root

    Rectangle {
        anchors.fill: parent
        color: "black"
        opacity: 0.2
    }

    signal clicked

    property int count

    Text {
        anchors.centerIn: parent
        text: "Ваш счет" + ": " + count
        font.pixelSize: Theme.fontSizeLarge
        font.bold: true
        color: "white"
    }

    Text {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Нажмите в любое место для выхода"
        font.pixelSize: Theme.fontSizeSmall
        color: "white"
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.clicked()
    }
}
