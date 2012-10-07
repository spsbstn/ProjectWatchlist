import QtQuick 1.0
import Cursors 1.0

MouseArea {

  property int buttonHeight;
  property int buttonWidth;
  property url buttonNormal;
  property url buttonActive:buttonNormal;


  width:buttonWidth;
  height:buttonHeight;
  smooth:true
  hoverEnabled:true
  onExited: NumberAnimation { target: buttonActiveState; property: "opacity"; to: 0; duration: 100;}
  onEntered: NumberAnimation { target: buttonActiveState; property: "opacity"; to: 1; duration: 100;}

  CursorShapeArea {
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
    }

    Image {

    source:buttonNormal
           }

    Image {

    id:buttonActiveState
    opacity:0
    source:buttonActive
          }
}
