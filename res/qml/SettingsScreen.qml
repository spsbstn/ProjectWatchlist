import QtQuick 1.1

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

        }

    else {
            settingsWindowBackground.visible=false;
            isHidden=true;

        }
    }

    anchors.top:grid.top
    anchors.topMargin: -16;
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
        text:"   General   |"
        font.weight: Font.Light
        color:tabColor
        font.family: mainWindow.uiFont}
        Text {
        id:tab2Label
        font.pointSize:tabFontSize
        font.weight: Font.Light
        text:"   Appearance   |"
        color:tabColor
        font.family: mainWindow.uiFont
        anchors.left:tab1Label.right}
        Text {
        id:tab3Label
        font.pointSize:tabFontSize
        font.weight: Font.Light
        text:"   Other   "
        color:tabColor
        font.family: mainWindow.uiFont
        anchors.left:tab2Label.right}
        }
    }
    }
}

