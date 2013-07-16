import QtQuick 1.1

Item {

    property bool isMaximized: true;
    property bool htmlErrorIsVisible: false;
    property bool busyIndicatorVisible: true;

    Rectangle{

        id:topControles
        color:mainWindow.appBackground
        height: parent.height
        width:(parent.width*0.8)-versionInfo.width
        anchors.left: versionInfo.right
        anchors.rightMargin: (parent.width*0.2)/2
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15

        Button {

            id:shutdownButton
            buttonHeight:12
            buttonWidth: 12
            buttonNormal: "qrc:../..///img/shutdown.png"
            buttonActive: "qrc:../..///img/shutdown_Active.png"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            anchors.rightMargin: 10
            anchors.right:parent.right
            onReleased: {
                console.log("Terminating Watchlist with no errors.\n");
                Qt.quit();
            }
        }

        Button {

            id:sizeToggleButton
            buttonHeight:12
            buttonWidth: 12
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            anchors.rightMargin: 10
            anchors.right:shutdownButton.left
            onClicked: {

                    if(isMaximized){

                        controller.windowMinimize();
                    }

                    else {

                        controller.windowMaximize();
                    }

                isMaximized=!isMaximized;
            }
        }

        Button {

            id:hideButton
            buttonHeight:12
            buttonWidth: 12
            buttonNormal: "qrc:../..///img/hide.png"
            buttonActive: "qrc:../..///img/hide_Active.png"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            anchors.rightMargin: 10
            anchors.right:sizeToggleButton.left
            onClicked: controller.windowHide();
        }

        Button {

            id:greenButton
            buttonHeight:12
            buttonWidth: 12
            buttonNormal: "qrc:../..///img/darkGreenScheme.png"
            anchors.bottom: parent.bottom
            anchors.bottomMargin:5
            anchors.rightMargin: 10
            anchors.right:hideButton.left
            onClicked:mainWindow.colorScheme="darkGreen"
        }

        Button {

            id: cyanButton
            buttonHeight:12
            buttonWidth: 12
            buttonNormal: "qrc:../..///img/blackCyanScheme.png"
            anchors.bottom: parent.bottom
            anchors.bottomMargin:5
            anchors.rightMargin: 10
            anchors.right:greenButton.left
            onClicked:mainWindow.colorScheme="blackCyan"
        }

        Button {

            id: orangeButton
            buttonHeight:12
            buttonWidth: 12
            buttonNormal: "qrc:../..///img/darkOrangeScheme.png"
            anchors.bottom: parent.bottom
            anchors.bottomMargin:5
            anchors.rightMargin: 10
            anchors.right:cyanButton.left
            onClicked:mainWindow.colorScheme="darkOrange"
        }

        Button {

            id: redButton
            buttonHeight:12
            buttonWidth: 12
            buttonNormal: "qrc:../..///img/redGreyScheme.png"
            anchors.bottom: parent.bottom
            anchors.bottomMargin:5
            anchors.rightMargin: 10
            anchors.right:orangeButton.left
            onClicked:mainWindow.colorScheme="redGrey"
        }

        Button {

            id: remoteButton
            buttonHeight:12
            buttonWidth: 12
            buttonNormal: "qrc:../..///img/remoteIcon.png"
            anchors.bottom: parent.bottom
            anchors.bottomMargin:5
            anchors.rightMargin: 11
            anchors.right:redButton.left
            onClicked:{

                mainWindow.showHosterSelect();
            }
        }

        Text {

            id:totalShows
            text:qsTr("total shows: ")+grid.count + " "
            color:mainWindow.textColor2
            font.pixelSize: 16
            font.capitalization:Font.AllLowercase;
            font.family: mainWindow.uiFont
            anchors.bottom: parent.bottom
            anchors.bottomMargin:2
            anchors.rightMargin: 9
            anchors.right:remoteButton.left
        }

        Text {

            visible:htmlErrorIsVisible
            text:qsTr("Connection Error: Please try again.")
            color:"red"
            font.pixelSize: 16
            font.family: mainWindow.uiFont
            anchors.bottom: parent.bottom
            anchors.bottomMargin:2
            anchors.rightMargin: (border.width - width)/2
            anchors.right:parent.right
        }
    }

    Rectangle{

        id:versionInfo
        color:"transparent"
        height:parent.height
        width:160

        Text {

            anchors.centerIn: parent
            id:versionInfoText
            text:"Watchlist 2.2"
            color:mainWindow.textColor2
            font.pixelSize: 16
            font.capitalization:Font.AllLowercase;
            font.family: mainWindow.uiFont
        }

        LoadingCircle {

            anchors.bottom:versionInfoText.bottom
            anchors.left: versionInfoText.right
            anchors.leftMargin: 5
            radiusPoints: 2
            visible: busyIndicatorVisible;
            colorPoints: mainWindow.tileBackground
            dotColor: mainWindow.tileBackground
            circleDiameter: versionInfo.height/2-5


        }
    }



    Rectangle {

        id:border
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        height:1
        color:'#CCCCCC'
        width:parent.width*0.8
    }

    states: [

        State {

            name: "maximized"
            PropertyChanges { target: sizeToggleButton; buttonNormal:"./..///img/restore.png"  }
            PropertyChanges { target: sizeToggleButton; buttonActive:"./..///img/restore_Active.png"}
            when: isMaximized==true

        },

        State {

             name: "normalSize"
             PropertyChanges { target: sizeToggleButton; buttonNormal:"./..///img/maximize.png" }
             PropertyChanges { target: sizeToggleButton; buttonActive:"./..///img/maximize_Active.png" }
             when: isMaximized==false

        }
    ]
}
