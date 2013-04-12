import QtQuick 1.1
import Cursors 1.0
import "Settings"


Item {
    id:settingsWindowBackground
    property int trianglePosition;
    property bool isHidden: true;
    property int animationTime: 600;
    property int marginLeft: (parent.width-width)/2
    property string tabColor: "#d9d9d9";
    property int tabFontSize: 30
    function toggle() {

        if(isHidden){

            settingsWindowBackground.visible=true;
            isHidden=false;
            showClickProtection.start();

        }

    else {
            settingsWindowBackground.visible=false;
            isHidden=true;
            removeClickProtection.start();

        }
    }

    function switchToTab(i) {

        switch(i)
        {
        case 1:
            resetTabColors();
            tab1Label.color=mainWindow.tileBackground;
            resetTabContents();
            content1.visible=true;
            break;
        case 2:
            resetTabColors();
            tab2Label.color=mainWindow.tileBackground;
            resetTabContents();
            content2.visible=true;
            break;
        case 3:
            resetTabColors();
            tab3Label.color=mainWindow.tileBackground;
            resetTabContents();
            content3.visible=true;
            break;
        default:
            break;
        }
    }

    function resetTabColors() {

        tab1Label.color=tabColor;
        tab2Label.color=tabColor;
        tab3Label.color=tabColor;

    }

    function resetTabContents() {

        content1.visible=false;
        content2.visible=false;
        content3.visible=false;

    }

    anchors.top:grid.top
    anchors.topMargin: -20;
    width: grid.width*0.8
    height:grid.height*0.6
    anchors.left: parent.left
    anchors.leftMargin:marginLeft
    visible:false

    Image {

        id:triangle
        anchors.top: parent.top
        x:trianglePosition - marginLeft
        source:"qrc:///img/triangle.png"
        clip:true
        fillMode: Image.Tile

    }

    Button {

        id: settingsToggle
        buttonHeight:12
        buttonWidth: 12
        buttonNormal: "../..///img/"+colorScheme+"/settings.png"
        anchors.bottom: triangle.top
        anchors.left: triangle.left
        anchors.leftMargin: 2
        onClicked:toggle();

}

    Rectangle {

        color:"white"
        height:parent.height-16
        width:parent.width
        anchors.top:parent.top
        anchors.topMargin: 16
Item {

    id:settingsContent
    anchors.fill: parent
        Item {
        id:tabs
        anchors.top:parent.top
        anchors.topMargin: 20
        height:parent.height*0.1
        width:tab1Label.width+tab2Label.width+tab3Label.width
        anchors.horizontalCenter: parent.horizontalCenter

        Text {

            id:tab1Label
            font.pointSize:tabFontSize
            text:"   General   "
            font.weight: Font.Light
            color:mainWindow.tileBackground
            font.family: mainWindow.uiFont

            CursorShapeArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
              }

            MouseArea {
            anchors.fill: parent
            onClicked: switchToTab(1);}
        }

        Text {
        anchors.left:tab1Label.right
        id:seperator1
        text :"|"
        font.pointSize:tabFontSize
        font.weight: Font.Light
        color:tabColor
        font.family: mainWindow.uiFont
        }

        Text {

            id:tab2Label
            font.pointSize:tabFontSize
            font.weight: Font.Light
            text:"   Hoster   "
            color:tabColor
            font.family: mainWindow.uiFont
            anchors.left:seperator1.right

            CursorShapeArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
              }

            MouseArea {
            anchors.fill: parent
            onClicked: switchToTab(2);}
        }

        Text {
        anchors.left:tab2Label.right
        id:seperator2
        text :"|"
        font.pointSize:tabFontSize
        font.weight: Font.Light
        color:tabColor
        font.family: mainWindow.uiFont
        }


        Text {

            id:tab3Label
            font.pointSize:tabFontSize
            font.weight: Font.Light
            text:"   Themes   "
            color:tabColor
            font.family: mainWindow.uiFont
            anchors.left:seperator2.right

            CursorShapeArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
              }

            MouseArea {
            anchors.fill: parent
            onClicked: switchToTab(3);}

        }

        }

        Item {

        id:contentArea
        height:parent.height-tabs.height-20 //top Margin of tabs
        width:parent.width
        anchors.bottom: parent.bottom

        Item {
        id:content1
        visible:true
        anchors.fill:parent
        }
        Item {
        id:content2
        visible: false
        anchors.fill:parent
        }
        Item {
        id:content3
        visible: false
        anchors.fill:parent
        ThemeSettings{

        }}}
}

    }

}
