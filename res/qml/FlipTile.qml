import QtQuick 1.0

 Flipable {
     id: flipable
     width: parseInt(grid.height / 2) - tileMargin
     height: width - tileMargin
     smooth:true

property bool flipped: false

front: Rectangle {
         width: parent.width - tileMargin
         height: parent.height - tileMargin
         color: mainWindow.tileBackground

        Text {
             id: titleText
             anchors.centerIn: parent
             color: mainWindow.textColor
             text: title
             font.family: "Helvetica Neue"
             font.weight:Font.Light
             width:parent.width
             horizontalAlignment: Text.AlignHCenter
             wrapMode: Text.WordWrap
             font {capitalization: Font.AllUppercase;
                   pointSize: mainWindow.tileHeaderFontSize}
         }

         MouseArea {
             anchors.fill:parent
             onClicked: flipable.flipped = !flipable.flipped
         }

//#####################InsertCustomButtons#####################//
         MinusButtonDark {

              anchors.bottom: parent.bottom
              anchors.left:parent.left
              anchors.leftMargin: 5
              smooth:true
              onClicked: controller.remove(titleText.text);
         }

//#############################################################//
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
             horizontalAlignment: Text.AlignHCenter
             color: mainWindow.textColor
             font.weight: Font.Light
             text: "Folge: " + episode
             width: parent.width;
             //wrapMode: Text.WordWrap;
             font { family: mainWindow.uiFont; pointSize: mainWindow.tileInfoFontSize }
         }
           RightButton{
           id: episodeIncrease
           anchors.right:parent.right
           anchors.rightMargin: parent.width/6
           anchors.verticalCenter: parent.verticalCenter
           onClicked: controller.setEpisode(titleText.text, +1);}
           LeftButton {
           id: episodeDecrease
           anchors.left:parent.left
           anchors.leftMargin: parent.width/6
           anchors.verticalCenter: parent.verticalCenter
           onClicked: controller.setEpisode(titleText.text, -1);}
           states: State{
               PropertyChanges { target: episodeDecrease; opacity: 0 }
               when: episode === 1
           }
}
        Rectangle {
            width: parent.width;
            anchors.top: parent.top
            anchors.topMargin: tileMargin +100
            color:mainWindow.tileBackground
            height:22
            Text {
             id: seasonTxt
             horizontalAlignment: Text.AlignHCenter
             verticalAlignment: Text.AlignVCenter
             width:parent.width
             color: mainWindow.textColor
             text: "Staffel: " + season
             font.weight: Font.Light

             wrapMode: Text.WordWrap;
             font { family: mainWindow.uiFont; pointSize: mainWindow.tileInfoFontSize }

             RightButton{
             id: seasonIncrease
             anchors.right:parent.right
             anchors.rightMargin: parent.width/6
             anchors.verticalCenter: parent.verticalCenter
             onClicked: controller.setSeason(titleText.text, +1);}
             LeftButton {
             id: seasonDecrease
             anchors.left:parent.left
             anchors.leftMargin: parent.width/6
             anchors.verticalCenter: parent.verticalCenter
             onClicked: controller.setSeason(titleText.text, -1);}
             states: State{
                 PropertyChanges{ target: seasonDecrease; opacity: 0 }
                 when: season === 1
             }

         }}


     }

     transform: Rotation {
         id: rotation
         origin.x: (flipable.width-tileMargin)/2
         origin.y: flipable.height/2
         axis.x: 0; axis.y: 1; axis.z: 0
         angle: 0    // the default angle
     }

     states: State {
             name: "back"
             PropertyChanges { target: rotation; angle: 180 }
             when: flipable.flipped
          }

     transitions: Transition {
         NumberAnimation { target: rotation; property: "angle"; duration: 1000 }
     }


 }
