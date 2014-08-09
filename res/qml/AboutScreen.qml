import QtQuick 1.1
import "..///js/Global.js" as GlobalJS
import Cursors 1.0

Rectangle {

    id: aboutScreen
    opacity: 0
    anchors.centerIn: parent
    height: 0.6 * parent.height
    width: 0.6 * parent.width
    color: mainWindow.tileBackground

    Keys.onEscapePressed: {

    aboutScreen.opacity = 0
    removeClickProtection.start()

    }

    Item {

        id: headline
        anchors.top: parent.top
        anchors.topMargin: parent.height/7
        width: parent.width
            Text {
                 color: mainWindow.textColor3
                 text: "Watchlist 2.2 | Diamond"
                 anchors.centerIn: parent
                 font {
                     family: mainWindow.uiFont
                     capitalization: Font.AllUppercase
                     pointSize: 35
                 }
            }
    }

    Text {
        text:"<html>Watchlist is a two-men project started in 2012.<br>Watchlist is open source.<br>The source can be found <a href='https://github.com/Embisto/ProjectWatchlist'>here</a>.<br>Feel free to fork or submit issues.<br><br>The changelog can be found <a href='https://github.com/Embisto/ProjectWatchlist'>here</a>.</html>"
        width:parent.width
        anchors.top:headline.bottom
        anchors.topMargin: parent.height/5
        onLinkActivated: Qt.openUrlExternally(link)
        color: mainWindow.textColor3
        horizontalAlignment:Text.AlignHCenter
        font {
            family: mainWindow.uiFont
            capitalization: Font.AllUppercase
            pointSize: 25
        }
    }



    Button {

        id:closeButton
        anchors.top:parent.top
        anchors.topMargin: -11
        anchors.rightMargin: -11
        anchors.right:parent.right
        buttonHeight:22
        buttonWidth: 22
        buttonNormal: "qrc:../..///img/closeScreenButton.png"
        onClicked: {
            aboutScreen.opacity = 0
            removeClickProtection.start()
        }

    }

}
