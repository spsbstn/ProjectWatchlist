import QtQuick 1.1

Item {

    property bool isMaximized: true;
    property bool htmlErrorIsVisible: false;
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
                onReleased: Qt.quit()
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
                isMaximized=!isMaximized;}
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
               id:darkColorButton
               buttonHeight:12
               buttonWidth: 12
               buttonNormal: "qrc:../..///img/darkGreenSheme.png"
               anchors.bottom: parent.bottom
               anchors.bottomMargin:5
               anchors.rightMargin: 10
               anchors.right:hideButton.left
               onClicked:mainWindow.colorScheme="darkGreen"
            }
            Button {
                id: lightColorButton
                buttonHeight:12
                buttonWidth: 12
                buttonNormal: "qrc:../..///img/lightGreySheme.png"
                anchors.bottom: parent.bottom
                anchors.bottomMargin:5
                anchors.rightMargin: 10
                anchors.right:darkColorButton.left
                onClicked:mainWindow.colorScheme="grey"
            }
            Button {
                id: redColorButton
                buttonHeight:12
                buttonWidth: 12
                buttonNormal: "qrc:../..///img/darkOrangeSheme.png"
                anchors.bottom: parent.bottom
                anchors.bottomMargin:5
                anchors.rightMargin: 10
                anchors.right:lightColorButton.left
                onClicked:mainWindow.colorScheme="darkOrange"

    }
            Text {

                id:totalShows
                text:"total shows: "+grid.count + " "
                color:mainWindow.textColor2
                font.pixelSize: 16
                font.capitalization:Font.AllLowercase;
                font.family: mainWindow.uiFont
                anchors.bottom: parent.bottom
                anchors.bottomMargin:2
                anchors.rightMargin: 10
                anchors.right:redColorButton.left
            }

            Text {

                visible:htmlErrorIsVisible
                text:"Connection Error: Please try again."
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
        color:mainWindow.appBackground
        height:parent.height
        width:160

            Text {

                anchors.centerIn: parent
                text:"Watchlist 2.1"
                color:mainWindow.textColor2
                font.pixelSize: 16
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
    states: [ State {

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
