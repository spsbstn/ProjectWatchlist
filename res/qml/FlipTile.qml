import QtQuick 1.0

 Flipable {
     id: flipable
     width: parseInt(grid.height / 2) - tileMargin
     height: width - tileMargin

property bool flipped: false //current state

//front
front: Rectangle {

         width: parent.width - tileMargin
         height: parent.height - tileMargin
         color: mainWindow.tileBackground
         smooth:true

      //add Listener
         MouseArea {
             anchors.fill: parent
             onClicked: {
                 grid.currentIndex = index
             }
         }
    //maybe needed for later
         states: [
             State {
                 name: "selected"
                 when: delegate.GridView.isCurrentItem
             }
         ]
 //set text
         Text {
             id: titleText
             anchors.top: parent.top
             anchors.topMargin: tileMargin
             anchors.left: parent.left
             anchors.leftMargin: tileMargin
             anchors.right: parent.right
             anchors.rightMargin: tileMargin

             color: mainWindow.textColor
             text: name; //load from data
             width: parent.width;
             wrapMode: Text.WordWrap
             font { bold: true; family: mainWindow.uiFont; pointSize: mainWindow.tileHeaderFontSize }
         }
}
//back
     back: Rectangle {

         width: parent.width - tileMargin
         height: parent.height - tileMargin
         color: mainWindow.tileBackground
         smooth:true

         MouseArea {
             anchors.fill: parent
             onClicked: {
                 grid.currentIndex = index
             }
         }

         states: [
             State {
                 name: "selected"
                 when: delegate.GridView.isCurrentItem
             }
         ]

         Text {
             id: dateText
             anchors.left: parent.left
             anchors.leftMargin: tileMargin
             anchors.bottom: parent.bottom
             anchors.bottomMargin: tileMargin
             anchors.right: parent.right
             anchors.rightMargin: tileMargin

             color: mainWindow.textColor
             text: "Folge " + episode + " Staffel " + season
             width: parent.width;
             wrapMode: Text.WordWrap;
             font { family: mainWindow.uiFont; pointSize: mainWindow.tileDateFontSize }
         }
}

     // rotation
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

     MouseArea {
         anchors.fill: parent
         onClicked: flipable.flipped = !flipable.flipped
     }
 }
