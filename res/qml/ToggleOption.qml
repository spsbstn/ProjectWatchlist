// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import Cursors 1.0

Item {

    property string description;
    property string name;
    property bool enabled: false;
    signal optionEnabled
    signal optionDisabled

    function setEnabled(status)
    {
        if(status) {

            enabled=true;
            optionEnabled();
            toggleButton.source="../..///img/toggleOn.png";

        }

        else {

            enabled=false;
            optionDisabled();
            toggleButton.source="../..///img/toggleOff.png";

        }

    }
    function toggle() {

        if(enabled) {

            setEnabled(false);

        }

        else {

            setEnabled(true);
        }

    }

    width: parent.width*0.9
    height: 50

    Text {

        anchors.left:parent.left
        anchors.leftMargin: 10
        text: name
        font.pointSize: 20
        color:"#666666"

    }

    Text {

        anchors.left:parent.left
        anchors.leftMargin: 12
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        text: description
        font.pointSize: 12
        color:"#999999"

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
