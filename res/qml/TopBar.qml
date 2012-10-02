import QtQuick 1.1

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

                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5
                anchors.rightMargin: 10
                anchors.right:parent.right
                onReleased: Qt.quit()
            }
    }

    Rectangle{

        id:versionInfo
        color:mainWindow.appBackground
        height:parent.height
        width:160

            Text {

                anchors.centerIn: parent
                text:"Watchlist alpha"
                color:"#aaaaaa"
                font.pixelSize: 16
                font.family: "Helvetica-Neue"
                font.weight: Font.Light
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
