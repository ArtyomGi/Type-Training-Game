import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"

Page {
    id: root

    property var viewModel
    property int level
    property int count

    signal succeed
    signal failed

    function move() {
        mainCharacter.runAnimation()
        ground.x -= 66
        enemy.x -= 66
    }

    function handleKey(key) {
        if (!tickTimer.running) {
            tickTimer.running = true
            enemy.runAnimation()
        }

        if (key === viewModel.getCurrentLetter()) {
            viewModel.popLetter()
            move()
            count++

            if (viewModel.lettersList.rowCount() === 0)
                succeed()
        }
    }

    function tick() {
        if (Math.abs(enemy.x - mainCharacter.x) < 100) {
            enemy.attackAnimation()
            tickTimer.running = false
            endGameOverlay.visible = true
        } else {
            enemy.move()
        }
    }

    Timer {
        id: tickTimer
        interval: 500
        repeat: true
        onTriggered: tick()
    }

    TextField {
        id: tf
        anchors.bottom: parent.bottom
        Component.onCompleted: forceActiveFocus()
        inputMethodHints: Qt.ImhNoAutoUppercase
        enabled: !endGameOverlay.visible
        onTextChanged: {
            handleKey(text)
            text = ""
        }
    }

    Background {
        anchors.fill: parent
    }

    Text {
        anchors {
            right: parent.right
            rightMargin: 20
            top: parent.top
            topMargin: 20
        }

        text: qsTr("Счет") + ": " + count
        font.pixelSize: Theme.fontSizeMedium
        font.bold: true
        color: "white"
    }

    VirtualGuy {
        id: mainCharacter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -30
        anchors.bottom: ground.top
    }

    Chameleon {
        id: enemy
        anchors.bottom: ground.top

        property real velocity: 10 * level

        function move() {
            if (behavior.animation && behavior.animation.running)
                return

            x += velocity
        }

        Behavior on x {
            id: behavior
            NumberAnimation { duration: 400 }
        }
    }

    ListView {
        id: lettersList
        x: mainCharacter.x + mainCharacter.width
        anchors {
            bottom: ground.top
            bottomMargin: -5
        }
        width: contentWidth
        height: 48
        spacing: 10
        orientation: ListView.Horizontal
        model: viewModel && viewModel.lettersList
        delegate: Box {
            id: box
            Text {
                anchors.centerIn: parent
                text: modelData
                color: "white"
                font.bold: true
            }
        }
        removeDisplaced: Transition {
            NumberAnimation { properties: "x,y"; duration: 400 }
        }
    }

    Terrain {
        id: ground
        anchors {
            top: parent.verticalCenter
            bottom: parent.bottom
        }
        width: parent.width + 15 * 66

        Behavior on x {
            SequentialAnimation {
                NumberAnimation { duration: 400 }
                ScriptAction { script: mainCharacter.idleAnimation() }
            }
        }
    }

    EndGameOverlay {
        id: endGameOverlay
        anchors.fill: parent
        visible: false
        count: root.count
        onClicked: failed()
    }
}
