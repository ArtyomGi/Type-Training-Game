import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    property var viewModel
    property int bestCount

    property int currentCount
    property int currentLevel: 1
    property int difficulty: difficultyMenu.currentIndex + 1

    Component {
        id: gameScreen

        GameScreen {
            viewModel: page.viewModel

            onSucceed: {
                currentCount = count
                currentLevel++

                viewModel.generateLetters(difficulty)

                pageStack.replace(gameScreen, { count: currentCount, level: currentLevel })
            }

            onFailed: {
                currentCount = 0
                bestCount = Math.max(count, bestCount)
                pageStack.pop()
            }
        }
    }

    Column {
        width: parent.width
        spacing: Theme.paddingLarge

        Text {
            id: countLabel
            anchors {
                horizontalCenter: parent.horizontalCenter
            }
            text: "Лучший счет: " + bestCount
            font.pixelSize: Theme.fontSizeMedium
            color: "white"
        }

        ComboBox {
            id: difficultyMenu
            anchors {
                horizontalCenter: parent.horizontalCenter
            }
            width: parent.width
            label: "Сложность:"

            menu: ContextMenu {
                MenuItem { text: "r, f, v, u, j, m" }
                MenuItem { text: "+ t, g, b, y, h, n" }
                MenuItem { text: "+ e, d, c, i, k" }
                MenuItem { text: "+ w, s, x, o, l" }
                MenuItem { text: "+ q, a, z, p" }
            }
        }

        Button {
            id: startButton
            anchors {
                horizontalCenter: parent.horizontalCenter
            }
            text: "Начать игру"
            onClicked: {
                viewModel.generateLetters(difficulty)
                pageStack.push(gameScreen, { level: currentLevel })
            }
        }
    }
}
