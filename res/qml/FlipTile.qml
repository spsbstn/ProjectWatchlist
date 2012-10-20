import QtQuick 1.0
import "..///js/Global.js" as GlobalJS

 Flipable {
     id: flipable
     width: parseInt(grid.height / 3) - tileMargin
     height: width - tileMargin

property bool flipped: false
property bool loadingCircleVisible: false



front: Rectangle {

         width: parent.width - tileMargin
         height: parent.height - tileMargin
         color:mainWindow.tileBackground

                 Text {

                    id: seriesName
                    anchors.centerIn: parent
                    color: mainWindow.textColor
                    text: title
                    smooth:true
                    font.family: mainWindow.uiFont
                    width:parent.width
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
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
             font.family: mainWindow.uiFont
             wrapMode: Text.WordWrap
             font {pointSize: mainWindow.tileHeaderFontSize*0.4}
            }

         MouseArea {
             anchors.fill:parent
             onClicked: flipable.flipped = !flipable.flipped
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
             text: "Episode: " + episode
             wrapMode: Text.WordWrap;
             font { family: mainWindow.uiFont; pointSize: 25 }
         }
           Button{

                    id: episodeIncrease
                    buttonHeight: 18
                    buttonWidth: 18
                    buttonNormal: "../..///img/"+mainWindow.colorScheme+"/rightButton.png"
                    buttonActive: "../..///img/"+mainWindow.colorScheme+"/rightButton_Active.png"
                    anchors.right:parent.right
                    anchors.rightMargin: (episodeTxt.width-text1.width-(2*width))/2
                    anchors.verticalCenter: parent.verticalCenter
                    onClicked: controller.setEpisode(seriesName.text, +1);
           }

           Button {

                    id: episodeDecrease
                    buttonHeight: 18
                    buttonWidth: 18
                    buttonNormal: "../..///img/"+mainWindow.colorScheme+"/leftButton.png"
                    buttonActive: "../..///img/"+mainWindow.colorScheme+"/leftButton_Active.png"
                    anchors.left:parent.left
                    anchors.leftMargin: (episodeTxt.width-text1.width-(2*width))/2
                    anchors.verticalCenter: parent.verticalCenter
                    onClicked: controller.setEpisode(seriesName.text, -1);
           }

           states: [
               State{
               PropertyChanges { target: episodeDecrease; opacity: 0 }
               when: episode === 1
                },

               State{
               PropertyChanges { target: episodeIncrease; opacity: 0 }
               when: episode === 99
               }
        ]
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
                   text: "Season: " + season
                   wrapMode: Text.WordWrap;
                   font { family: mainWindow.uiFont; pointSize: 25 }
}
             Button{

                   id: seasonIncrease
                   buttonHeight: 18
                   buttonWidth: 18
                   buttonNormal: "../..///img/"+mainWindow.colorScheme+"/rightButton.png"
                   buttonActive: "../..///img/"+mainWindow.colorScheme+"/rightButton_Active.png"
                   anchors.right:parent.right
                   anchors.rightMargin: (seasonTxt.width-text2.width-(2*width))/2
                   anchors.verticalCenter: parent.verticalCenter
                   onClicked: controller.setSeason(seriesName.text, +1);
             }

             Button {

                    id: seasonDecrease
                    buttonHeight: 18
                    buttonWidth: 18
                    buttonNormal: "../..///img/"+mainWindow.colorScheme+"/leftButton.png"
                    buttonActive: "../..///img/"+mainWindow.colorScheme+"/leftButton_Active.png"
                    anchors.left:parent.left
                    anchors.leftMargin: (seasonTxt.width-text2.width-(2*width))/2
                    anchors.verticalCenter: parent.verticalCenter
                    onClicked: controller.setSeason(seriesName.text, -1);
             }

             states: [
                 State{
                 PropertyChanges{ target: seasonDecrease; opacity: 0 }
                 when: season === 1
                },

                 State{
                 PropertyChanges{ target: seasonIncrease; opacity: 0 }
                 when: season === 99
                 }
             ]
         }
        Button {
             id:removeButton
             buttonHeight:15
             buttonWidth:15
             buttonNormal: "../..///img/"+mainWindow.colorScheme+"/removeIcon.png"
             buttonActive:"../..///img/"+mainWindow.colorScheme+"/removeIcon_Active.png"
             anchors.top: parent.top
             anchors.right:parent.right
             anchors.topMargin: 10
             anchors.rightMargin: 8
             onPressed: {GlobalJS.activeSeries = seriesName.text;
                         clickProtection.enabled=true;}
             onReleased:NumberAnimation { target:removeScreen; property:"opacity"; to:1; duration: 400}


        }

        Button {
             id:infoButton
             buttonHeight:16
             buttonWidth:16
             buttonNormal: "../..///img/"+mainWindow.colorScheme+"/info.png"
             anchors.bottom: parent.bottom
             anchors.right:parent.right
             anchors.bottomMargin: 10
             anchors.rightMargin: 8
             hoverEnabled: true
             onPressed: {loadingCircleVisible=true;
                         grid.currentIndex = index;   }
             onReleased:xmlDataRequired(title);

     }
    LoadingCircle{
                  id:loadingCircel
                  circleDiameter:20
                  radiusPoints: 2
                  visible: loadingCircleVisible;
                  anchors.left:parent.left
                  anchors.leftMargin: 10
                  anchors.bottom:parent.bottom
                  anchors.bottomMargin: 8}
}
     transform: Rotation {

         id: rotation
         origin.x: (flipable.width-tileMargin)/2
         origin.y: flipable.height/2
         axis.x: 0; axis.y: 1; axis.z: 0
         angle: 0.01    // the default angle
     }

     states: [ State {

             name: "back"
             PropertyChanges { target: rotation; angle: 179.99 }
             when: flipable.flipped
          }


]
     transitions: Transition {
         NumberAnimation { target: rotation; property: "angle"; duration: 1000 }
     }
 }
