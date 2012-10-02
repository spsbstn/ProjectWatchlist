import QtQuick 1.0
import Cursors 1.0

MouseArea {

  width:35
  height:35
  smooth:true
  hoverEnabled:true
  onExited: NumberAnimation { target: addButtonActive; property: "opacity"; to: 0; duration: 100;}
  onEntered: NumberAnimation { target: addButtonActive; property: "opacity"; to: 1; duration: 100;}
  CursorShapeArea {
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
    }

    Image {
        source:"qrc:../..///img/addIcon.png"
           }

    Image {

    id:addButtonActive
    opacity:0
    source:"qrc:../..///img/addIcon_Active.png"

}}
