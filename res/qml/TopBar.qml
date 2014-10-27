import QtQuick 1.1
import Cursors 1.0


Item {

    property bool isMaximized: true;
    property bool htmlErrorIsVisible: false;
    property bool busyIndicatorSpinning: false;
    property string lastSync: "";
    property bool isTileMode: true;
    property string switchLogoUrl: "../..///img/"+mainWindow.colorScheme+"/lineMode.png";

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

            id: themeButton
            buttonHeight:12
            buttonWidth: 12
            buttonNormal: "../..///img/"+mainWindow.colorScheme+"/themes.png"
            anchors.bottom: parent.bottom
            anchors.bottomMargin:5
            anchors.rightMargin: 10
            anchors.right:hideButton.left
            onClicked:mainWindow.showThemeSelect();
        }

        Button {

            id: remoteButton
            buttonHeight:12
            buttonWidth: 12
            buttonNormal: "../..///img/"+mainWindow.colorScheme+"/switchChannel.png"
            anchors.bottom: parent.bottom
            anchors.bottomMargin:5
            anchors.rightMargin: 11
            anchors.right:themeButton.left
            onClicked:{

                mainWindow.showHosterSelect();
            }
        }

        Button {

            id: switchLayoutButton
            buttonHeight:12
            buttonWidth: 12
            buttonNormal: switchLogoUrl
            anchors.bottom: parent.bottom
            anchors.bottomMargin:5
            anchors.rightMargin: 11
            anchors.right:remoteButton.left
            onClicked:{

                if(isTileMode) {
                    switchLogoUrl= "../..///img/"+mainWindow.colorScheme+"/tileMode.png";
                    isTileMode = false;
                }

                else {
                    switchLogoUrl= "../..///img/"+mainWindow.colorScheme+"/lineMode.png";
                    isTileMode = true;
                }
                mainWindow.switchLayout();
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
            anchors.right:switchLayoutButton.left
        }

        Text {

            visible:htmlErrorIsVisible
            text:qsTr("Connection Error: Please check your connection and try syncing.")
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

            MouseArea {
                anchors.fill: parent
                onClicked: mainWindow.showAbout();

                CursorShapeArea {

                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor

                  }

            }
        }



        Button {

            id: syncButton
            buttonHeight:32
            buttonWidth: 32
            buttonNormal: "../..///img/"+mainWindow.colorScheme+"/sync.png"
            anchors.bottom:versionInfoText.bottom
            anchors.bottomMargin: -4
            anchors.left: versionInfoText.right
            anchors.leftMargin: 5
            onReleased: {
                if (!busyIndicatorSpinning)
                {
                    htmlErrorIsVisible = false;
                    busyIndicatorSpinning = true;
                    controller.manualNetworkUpdate();
                    fuzzyTimeTimer.stop();
                    lastSync = "Syncing..."
                }
            }

            SyncIndicator {
               anchors.left: parent.left
               anchors.top: parent.top
               anchors.leftMargin: 11
               anchors.topMargin:11
               spinning: busyIndicatorSpinning
            }

        }

       Text {

           id : syncText
           anchors.bottom:versionInfoText.bottom
           anchors.bottomMargin: 1
           anchors.left: syncButton.right
           anchors.leftMargin: 5
           text:lastSync;
           color:mainWindow.textColor2
           font.pixelSize: 12
           font.capitalization:Font.AllLowercase;
           font.family: mainWindow.uiFont

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
