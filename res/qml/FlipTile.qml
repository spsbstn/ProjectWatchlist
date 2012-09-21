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
             smooth:false
             font.family: "Helvetica Neue"
             font.weight: Font.Light
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
              anchors.bottomMargin: 5
              onClicked: controller.remove(titleText.text);
         }

//#############################################################//
}
//back
     back: Rectangle {

         width: parent.width - tileMargin
         height: parent.height - tileMargin
         color: mainWindow.tileBackground

        Text {

             id: episodeTxt
             anchors.bottom: parent.bottom
             anchors.bottomMargin: tileMargin + (parent.height/2+height+10)
             horizontalAlignment: Text.AlignHCenter
             color: mainWindow.textColor
             font.weight: Font.Light
             text: "Folge: " + episode
             width: parent.width;
             wrapMode: Text.WordWrap;
             font { family: mainWindow.uiFont; pointSize: mainWindow.tileInfoFontSize }
         }

        Text {
             id: seasonTxt
             anchors.bottom: parent.bottom
             anchors.bottomMargin: tileMargin + (parent.height/2)
             horizontalAlignment: Text.AlignHCenter
             color: mainWindow.textColor
             text: "Staffel: " + season
             font.weight: Font.Light
             width: parent.width;
             wrapMode: Text.WordWrap;
             font { family: mainWindow.uiFont; pointSize: mainWindow.tileInfoFontSize }
         }

        MouseArea {
            anchors.fill:parent
            onClicked: flipable.flipped = !flipable.flipped
        }

//#####################InsertCustomButtons#####################//

//#############################################################//

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
