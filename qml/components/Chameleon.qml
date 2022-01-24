import QtQuick 2.6

SpriteSequence {
    id: root

    function idleAnimation() {
        goalSprite = "idle"
    }

    function runAnimation() {
        goalSprite = "run"
    }

    function attackAnimation() {
        goalSprite = "attack"
    }

    width: 168
    height: 76
    interpolate: false
    transform:  Matrix4x4 {
        matrix: Qt.matrix4x4( -1, 0, 0, root.width, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)
    }

    Sprite {
        name: "idle"
        source: "qrc:/images/chameleon/idle.png"
        frameWidth: 84
        frameHeight: 38
        frameCount: 11
        frameDuration: 50
        to: { "run" : 0, "attack" : 0 }
    }

    Sprite {
        name: "run"
        source: "qrc:/images/chameleon/run.png"
        frameCount: 8
        frameWidth: 84
        frameHeight: 38
        frameDuration: 50
        to: { "idle" : 0, "attack" : 0 }
    }

    Sprite {
        name: "attack"
        source: "qrc:/images/chameleon/attack.png"
        frameCount: 10
        frameWidth: 84
        frameHeight: 38
        frameDuration: 50
        to: { "idle" : 0, "run" : 0 }
    }
}
