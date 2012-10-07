import QtQuick 1.1
import "..///js/imdb.js" as Imdb

Item {
    Rectangle{

        id:topControles
        color:mainWindow.appBackground
        height: parent.height
        width:(parent.width*0.8)-versionInfo.width
        anchors.left: versionInfo.right
        anchors.rightMargin: (parent.width*0.2)/2
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15

            ShutdownButton {
                id:shutdown
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5
                anchors.rightMargin: 10
                anchors.right:parent.right
                onReleased: Qt.quit()
            }

            DarkGreenShemeButton {
               id:darkColor
               anchors.bottom: parent.bottom
               anchors.bottomMargin:5
               anchors.rightMargin: 10
               anchors.right:shutdown.left
               onClicked:mainWindow.colorSheme="dark"
}
            LighGreyShemeButton {
                anchors.bottom: parent.bottom
                anchors.bottomMargin:5
                anchors.rightMargin: 10
                anchors.right:darkColor.left
                onClicked:mainWindow.colorSheme="light"

    }
    }

    Rectangle{

        id:versionInfo
        color:mainWindow.appBackground
        height:parent.height
        width:160

            Text {

                anchors.centerIn: parent
                text:"Watchlist v1.0"
                color:"#00aaff"
                font.pixelSize: 16
                font.capitalization:Font.AllLowercase;
                font.family: "Helvetica-Neue"
                font.weight: Font.Light
                transform: Rotation {origin.x: (width)/2
                origin.y: height/2
                axis.x: 0; axis.y: 1; axis.z: 0
                angle: 0.01 }

            }
            PlusButtonDark {
                onReleased: Imdb.getShow("Breaking+Bad")
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
}
