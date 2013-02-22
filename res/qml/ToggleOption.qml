// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import Cursors 1.0

Item {

    property string description;
    property bool enabled: false;
    signal optionEnabled
    signal optionDisabled

    function toggle() {

        if(enabled) {

            enabled=false;
            optionDisabled();
            toggleButton.source="../..///img/toggleOff.png";

        }

        else {

            enabled=true;
            optionEnabled();
            toggleButton.source="../..///img/toggleOn.png";
        }

    }

    width: parent.width / 2
    height: 50

    Text {

        anchors.left:parent.left
        anchors.leftMargin: 10
        text: description
        font.pointSize: 20
        color:"#222222"

    }

    Image {
    id:toggleButton
    anchors.right: parent.right
    source: "qrc:../..///img/toggleOff.png"

    MouseArea {
    anchors.fill:parent
    onClicked: toggle();}

    CursorShapeArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
      }

    }
}
