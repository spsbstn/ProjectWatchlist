import QtQuick 1.0

Rectangle {
    color:"black"
    smooth: true
    id: splashScreenContainer
    property alias imageSource: splashImage.source

    signal splashScreenCompleted()
    Image {
        id: splashImage
        source: imageSource
        anchors.centerIn: splashScreenContainer
    }


    SequentialAnimation {
        id:splashanimation
        PauseAnimation { duration: 2200 }
        PropertyAnimation {
            target: splashScreenContainer
            duration: 2000
            properties: "opacity"
            to:0
        }
        onCompleted: {
            splashScreenContainer.splashScreenCompleted()
        }
    }
    Component.onCompleted: splashanimation.start()
 }
