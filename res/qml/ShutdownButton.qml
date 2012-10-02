import QtQuick 1.0
import Cursors 1.0

MouseArea {

  width:12
  height:12
  smooth:true
  onReleased: NumberAnimation { target: addButtonActive; property: "opacity"; to: 0; duration: 100;}
  onPressed: NumberAnimation { target: addButtonActive; property: "opacity"; to: 1; duration: 100;}

  CursorShapeArea {
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
    }

    Image {
        source:"qrc:../..///img/shutdown.png"
           }

    Image {

    id:addButtonActive
    opacity:0
    source:"qrc:../..///img/shutdown_Active.png"

}}
