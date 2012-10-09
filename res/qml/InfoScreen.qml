import QtQuick 1.1
import "..///js/Global.js" as GlobalJS

Rectangle {

    property double mainOpacity:0

    FontLoader {
             id: helveticaNeueUltraLight
             source: "qrc:../..///fonts/Helvetica Neue UltraLight.ttf"
    }

    id:mainInfoWindow
    anchors.centerIn: parent;
    opacity: mainOpacity
    color:mainWindow.tileBackground
    width:parent.width-100
    height:parent.height-100



        Item {

            id:topBar
            anchors.top: parent.top
            width:parent.width;
            height:parent.height*0.2

            Text {
                text:"Breaking Bad."
                font.family: helveticaNeueUltraLight.name
                font.pointSize: 60
                font.capitalization: Font.AllLowercase
                color: 'black'
                anchors.left:parent.left
                anchors.leftMargin: 60
                anchors.verticalCenter: parent.verticalCenter

            }

            }

        Item {

            id:imageArea
            anchors.top: topBar.bottom
            anchors.left:parent.left
            width:parent.width/2;
            height:parent.height*0.8

                Image {
                    id:image
                    smooth:true
                    anchors.centerIn: parent
                    source:"http://blogs.amctv.com/breaking-bad/TWD-S5-Key-Art-796.jpg"
                    height:imageArea.height*0.8
                    width:sourceSize.width/(sourceSize.height/height)
                    transform: Rotation { origin.x: height/2; origin.y: width/2; angle: 5}
                    z:1
                }

                Rectangle {
                    color:"white"
                    smooth:true
                    anchors.centerIn: image
                    height:image.height+10
                    width:image.width+10
                    transform: Rotation { origin.x: height/2; origin.y: width/2; angle: 5}

                }

            }

        Item {

            id:infoArea
            anchors.top: topBar.bottom
            anchors.left:imageArea.right
            width:parent.width/2;
            height:parent.height*(4/5)*(2/3)

            }

        Item {

            id:airTimeArea
            anchors.top: infoArea.bottom
            anchors.left:imageArea.right
            width:parent.width/2;
            height:parent.height*(4/5)*(1/3)

            }


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


