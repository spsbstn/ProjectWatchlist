import QtQuick 1.1
import "..///js/Global.js" as GlobalJS
import Cursors 1.0

Rectangle {

    property variant sources: ["kinox","vodly","hulu","tvmuse"]
    property string currentSource: ''
    property int index: 0
    // random number between 5 and 10 (animation)
    property int rand: Math.floor(Math.random() * (10 - 5 + 1)) + 5;

    ParallelAnimation {

        id:wobble

    NumberAnimation {

        target: selectArea; easing.overshoot: 1.1; properties: "scale"; from: 0.0; to: 1.0;
        easing.type: Easing.OutBack;easing.amplitude: 2.0; easing.period: 1.5; //duration:rand*100

    }

    NumberAnimation {

            target: selectArea; properties: "opacity"; from: 0.0; to: 1.0;
            easing.type: Easing.OutQuad; easing.amplitude: 2.0; easing.period: 1.5; // duration:rand*80
     }

}

    Keys.onRightPressed: {

        increaseIndex();
        currentSource = sources[index];
        GlobalJS.hoster = currentSource;
        wobble.start();
    }

    Keys.onLeftPressed: {

        decreaseIndex();
        currentSource = sources[index];
        GlobalJS.hoster = currentSource;
        wobble.start();
    }

    Keys.onEscapePressed: {

    selectHosterScreen.opacity = 0
    removeClickProtection.start()

    }

    Keys.onEnterPressed: {

    selectHosterScreen.opacity = 0
    removeClickProtection.start()

    }


    function getCurrentIndex(term) {

        var index;

        for (var i=0; i<sources.length; i++)
            if (sources[i]==term)
                return i;

        return null;

    }

    onOpacityChanged: {

        if (opacity == 1) {

            selectHosterScreen.focus = true
            index = getCurrentIndex(currentSource)
        }
    }

    function increaseIndex() {

        if(index==sources.length-1) {
            index = 0;
        }

        else {
            index += 1;
        }
    }

    function decreaseIndex() {

        if(index==0) {
            index = sources.length-1;
        }

        else {
            index -= 1;
        }
    }

    id: selectHosterScreen
    opacity: 0
    anchors.centerIn: parent
    height: 0.6 * parent.height
    width: 0.6 * parent.width
    color: mainWindow.tileBackground




    Rectangle {
         id:selectArea
         width: parent.width/3.5
         height: parent.width/3.5
         color: "white"
         anchors.centerIn: parent
         border.color: "white"
         border.width: 1
         radius: width*0.5
         Text {
             id:selectedHoster
              anchors.centerIn: parent
              color: mainWindow.tileBackground
              text: currentSource
              height:50
              font {
                  family: mainWindow.uiFont
                  capitalization: Font.AllUppercase
                  pointSize: 40
              }
         }
    }

    Item {

        id: headline
        anchors.bottom: selectArea.top
        anchors.bottomMargin: parent.height/10
        width: parent.width
            Text {
                 color: "white"
                 text: "Stream with"
                 anchors.centerIn: parent
                 font {
                     family: mainWindow.uiFont
                     capitalization: Font.AllUppercase
                     pointSize: 25
                 }
            }
    }

    Button {

        id: buttonLeft
        buttonHeight: 18
        buttonWidth: 18
        buttonNormal: "../..///img/"+mainWindow.colorScheme+"/leftButton.png"
        buttonActive: "../..///img/"+mainWindow.colorScheme+"/leftButton_Active.png"
        anchors.right:selectArea.left
        anchors.rightMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        onClicked: {
            decreaseIndex();
            currentSource = sources[index];
            //GlobalJS.hoster = currentSource;
            wobble.start();
        }
    }

    Button {

        id: buttonRight
        buttonHeight: 18
        buttonWidth: 18
        buttonNormal: "../..///img/"+mainWindow.colorScheme+"/rightButton.png"
        buttonActive: "../..///img/"+mainWindow.colorScheme+"/rightButton_Active.png"
        anchors.left:selectArea.right
        anchors.leftMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        onClicked: {
            increaseIndex();
            currentSource = sources[index];
            //GlobalJS.hoster = currentSource;
            wobble.start();

        }
    }

    Rectangle {

        id:doneButton
        color: "white"
        width: 200
        height: 40
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.right:parent.right
        anchors.rightMargin: 20

        Text {

            id: done
            anchors.centerIn: parent
            color: mainWindow.tileBackground
            text: "Done"
            smooth: true
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font {
                family: mainWindow.uiFont
                capitalization: Font.AllUppercase
                pointSize: 20
            }
        }

        MouseArea {
            hoverEnabled: true
            anchors.fill: parent
            onEntered: {
                doneButton.color="white";
            }
            onClicked: {
                GlobalJS.hoster = currentSource;
                settingscontroller.changeHoster(GlobalJS.hoster);
                selectHosterScreen.opacity = 0
                removeClickProtection.start()
            }
        }

        CursorShapeArea {

            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
        }
    }
}
