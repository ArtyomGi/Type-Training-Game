import QtQuick 2.0

SpriteSequence {
    id: root

    function idleAnimation() {
        goalSprite = "idle"
    }

    function runAnimation() {
        goalSprite = "run"
    }

    width: 80
    height: 80
    interpolate: false

    Sprite {
        name: "idle"
        source: "qrc:/images/virtual-guy/idle.png"
        frameWidth: 32
        frameHeight: 32
        frameCount: 11
        frameDuration: 50
        to: { "run" : 0 }
    }

    Sprite {
        name: "run"
        source: "qrc:/images/virtual-guy/run.png"
        frameCount: 12
        frameWidth: 32
        frameHeight: 32
        frameDuration: 50
        to: { "idle" : 0 }
    }
}
