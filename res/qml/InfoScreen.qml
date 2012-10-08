import QtQuick 1.1
import "..///js/Global.js" as GlobalJS

Rectangle {

    property double mainOpacity:0

    id:mainInfoWindow
    anchors.centerIn: parent;
    opacity: mainOpacity
    color:mainWindow.tileBackground
    width:parent.width-100
    height:parent.height-100

        Button {
            id:closeScreenButton
            anchors.top:parent.top
            anchors.topMargin: -11
            anchors.rightMargin: -11
            anchors.right:parent.right
            buttonHeight: 22
            buttonWidth: 22
            buttonNormal: "qrc:../..///img/closeScreenButton.png"
            onClicked: mainInfoWindow.opacity=0

    }
}


