import QtQuick 1.0

Rectangle {

    id: splashScreenContainer
    property alias imageSource: splashImage.source
    signal splashScreenCompleted()
    color:mainWindow.appBackground
    smooth: true
    opacity: 1;

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
        PauseAnimation { duration: 300 }
        PropertyAnimation {

            target: splashScreenContainer
            duration: 200
            properties: "opacity"
            to:0
        }

        onCompleted: {

            splashScreenContainer.splashScreenCompleted();

        }
    }

    Component.onCompleted: splashanimation.start();
 }
