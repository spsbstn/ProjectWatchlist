import QtQuick 1.0
import Cursors 1.0

MouseArea {

  width:15
  height:15
  smooth:true
  hoverEnabled:true
  onExited: NumberAnimation { target: addButtonActive; property: "opacity"; to: 0; duration: 100;}
  onEntered: NumberAnimation { target: addButtonActive; property: "opacity"; to: 1; duration: 100;}

  CursorShapeArea {
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
    }

    Image {
        source:"qrc:../..///img/removeIcon_Dark.png"
           }

    Image {

    id:addButtonActive
    opacity:0
    source:"qrc:../..///img/removeIcon_Dark_Active.png"

}}
