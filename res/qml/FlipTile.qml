import QtQuick 1.0
import "..///js/Global.js" as GlobalJS

 Flipable {
     id: flipable
     width: parseInt(grid.height / 2) - tileMargin
     height: width - tileMargin

property bool flipped: false

front: Rectangle {

         width: parent.width - tileMargin
         height: parent.height - tileMargin
         color: mainWindow.tileBackground

                 Text {

                    id: seriesName
                    anchors.centerIn: parent
                    color: mainWindow.textColor
                    text: title
                    font.family: "Helvetica Neue"
                    font.weight:Font.Light
                    width:parent.width
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                    font {
                        capitalization: Font.AllUppercase;
                        pointSize: mainWindow.tileHeaderFontSize
                        }
             }

        Text {

             id: genreName
             anchors.right: parent.right
             anchors.rightMargin: 5
             anchors.bottom:parent.bottom
             anchors.bottomMargin: 5
             color: mainWindow.textColor
             text: genre
             font.family: "Helvetica Neue"
             font.weight:Font.Light
             wrapMode: Text.WordWrap
             font {pointSize: mainWindow.tileHeaderFontSize-5}
            }

         MouseArea {
             anchors.fill:parent
             onClicked: flipable.flipped = !flipable.flipped
         }

         MinusButtonDark {

              anchors.bottom: parent.bottom
              anchors.left:parent.left
              anchors.leftMargin: 5
              onPressed: GlobalJS.activeSeries = seriesName.text;
              onReleased: NumberAnimation { target:removeScreen; property:"opacity"; to:1; duration: 400}

         }

}

//back
     back: Rectangle {

         width: parent.width - tileMargin
         height: parent.height - tileMargin
         color: mainWindow.tileBackground

            MouseArea {

                anchors.fill:parent
                onClicked: flipable.flipped = !flipable.flipped
                     }

        Rectangle {

             id: episodeTxt
             width:parent.width
             height:22
             color:mainWindow.tileBackground
             anchors.top: parent.top
             anchors.topMargin: tileMargin+50

           Text {

             id:text1
             anchors.centerIn: parent
             color: mainWindow.textColor
             font.weight: Font.Light
             text: "Folge: " + episode
             wrapMode: Text.WordWrap;
             font { family: mainWindow.uiFont; pointSize: mainWindow.tileInfoFontSize }
         }
           RightButton{

                    id: episodeIncrease
                    anchors.right:parent.right
                    anchors.rightMargin: (episodeTxt.width-text1.width-(2*width))/2-width
                    anchors.verticalCenter: parent.verticalCenter
                    onClicked: controller.setEpisode(seriesName.text, +1);
           }

           LeftButton {

                    id: episodeDecrease
                    anchors.left:parent.left
                    anchors.leftMargin: (episodeTxt.width-text1.width-(2*width))/2-width
                    anchors.verticalCenter: parent.verticalCenter
                    onClicked: controller.setEpisode(seriesName.text, -1);
           }

           states: State{

               PropertyChanges { target: episodeDecrease; opacity: 0 }
               when: episode === 1

           }
}

        Rectangle {
            id: seasonTxt
            width: parent.width;
            anchors.top: parent.top
            anchors.topMargin: tileMargin +100
            color:mainWindow.tileBackground
            height:22

            Text {

                   id:text2
                   anchors.centerIn: parent
                   color: mainWindow.textColor
                   text: "Staffel: " + season
                   font.weight: Font.Light
                   wrapMode: Text.WordWrap;
                   font { family: mainWindow.uiFont; pointSize: mainWindow.tileInfoFontSize }
}
             RightButton{

                   id: seasonIncrease
                   anchors.right:parent.right
                   anchors.rightMargin: (seasonTxt.width-text2.width-(2*width))/2-width
                   anchors.verticalCenter: parent.verticalCenter
                   onClicked: controller.setSeason(seriesName.text, +1);
             }

             LeftButton {

                    id: seasonDecrease
                    anchors.left:parent.left
                    anchors.leftMargin: (seasonTxt.width-text2.width-(2*width))/2-width
                    anchors.verticalCenter: parent.verticalCenter
                    onClicked: controller.setSeason(seriesName.text, -1);
             }

             states: State{

                 PropertyChanges{ target: seasonDecrease; opacity: 0 }
                 when: season === 1
             }
         }
     }

     transform: Rotation {

         id: rotation
         origin.x: (flipable.width-tileMargin)/2
         origin.y: flipable.height/2
         axis.x: 0; axis.y: 1; axis.z: 0
         angle: 0.01    // the default angle
     }

     states: State {

             name: "back"
             PropertyChanges { target: rotation; angle: 179.99 }
             when: flipable.flipped
          }

     transitions: Transition {
         NumberAnimation { target: rotation; property: "angle"; duration: 1000 }
     }
 }
