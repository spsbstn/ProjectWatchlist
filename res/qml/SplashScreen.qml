import QtQuick 1.0

Rectangle {
    color:mainWindow.appBackground
    smooth: true
    id: splashScreenContainer
    property alias imageSource: splashImage.source
    opacity: 1;

    signal splashScreenCompleted()
    Image {
        id: splashImage
        source: imageSource
        width:mainWindow.width*0.8
        fillMode: Image.PreserveAspectFit
        smooth:true;
        anchors.centerIn: splashScreenContainer
    }


    SequentialAnimation {
        id:splashanimation
        PauseAnimation { duration: 2200 }
        SequentialAnimation{
        PropertyAnimation {
            target: splashScreenContainer
            duration: 200
            properties: "opacity"
            to:0
        }
        PropertyAnimation {
            target: grid
            duration: 2000
            properties: "opacity"
            to:1
        }
        }
        onCompleted: {
            splashScreenContainer.splashScreenCompleted()
        }
    }
    Component.onCompleted: splashanimation.start()
 }
