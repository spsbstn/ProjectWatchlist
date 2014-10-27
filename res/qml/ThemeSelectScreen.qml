import QtQuick 1.1
import "..///js/Global.js" as GlobalJS
import Cursors 1.0

Rectangle {

    property variant themes: ["blackCyan","darkGreen","darkOrange","mint"]
    property int index: 0
    property string currentTheme: mainWindow.colorScheme
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
    function applyTheme() {

        currentTheme = themes[index]
        mainWindow.colorScheme = currentTheme
        mainWindow.colorizeModeIcon();
        uicontroller.alphaBlendFrame(mainWindow.appBackground,0.5);
        wobble.start();


    }


    Keys.onRightPressed: {

        increaseIndex();
        applyTheme();

    }

    Keys.onLeftPressed: {

        decreaseIndex();
        applyTheme();

    }

    Keys.onEscapePressed: {

    selectThemeScreen.opacity = 0;
    mainWindow.focus = true;
    removeClickProtection.start();

    }

    Keys.onReturnPressed: {

    selectThemeScreen.opacity = 0;
    mainWindow.focus = true;
    removeClickProtection.start();

    }


    function getCurrentIndex(term) {

        for (var i=0; i<themes.length; i++)
            if (themes[i]==term)
                return i;

        return null;

    }

    onOpacityChanged: {

        if (opacity == 1) {

            selectThemeScreen.focus = true
            index = getCurrentIndex(currentTheme)


        }
    }

    function increaseIndex() {

        if(index==themes.length-1) {
            index = 0;
        }

        else {
            index += 1;
        }
    }

    function decreaseIndex() {

        if(index==0) {
            index = themes.length-1;
        }

        else {
            index -= 1;
        }
    }


    id: selectThemeScreen
    opacity: 0
    anchors.centerIn: parent
    height: 0.6 * parent.height
    width: 0.6 * parent.width
    color: mainWindow.tileBackground

    Rectangle {
         id:selectArea
         width: parent.width/3.5
         height: parent.width/3.5
         color: mainWindow.appBackground
         anchors.centerIn: parent
         border.color: mainWindow.appBackground
         border.width: 1
         radius: width*0.5
         Text {
             id:selectedHoster
              anchors.centerIn: parent
              color: mainWindow.tileBackground
              text: currentTheme
              height:50
              font {
                  family: mainWindow.uiFont
                  capitalization: Font.AllUppercase
                  pointSize: 30
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
            applyTheme();

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
            applyTheme();
        }
    }

    Rectangle {

        id:doneButton
        color: mainWindow.textColor3
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
            onClicked: {
                selectThemeScreen.opacity = 0;
                removeClickProtection.start();
                mainWindow.focus = true;
            }
        }

        CursorShapeArea {

            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
        }
    }
}
