import QtQuick 1.1

Item {
    id:settingsWindowBackground
    property int trianglePosition;
    property bool isHidden: true;
    property int animationTime: 600;
    property int marginLeft: (parent.width-width)/2
    function toggle() {

        if(isHidden){

            showSettings.start();
            isHidden=false;

        }

    else {
            hideSettings.start();
            isHidden=true;

        }
    }

    SequentialAnimation {
        id:showSettings
        PropertyAnimation{target:triangle;
        properties: "height"
        to:16}

        PropertyAnimation {
        target: settingsWindowBackground
        duration: animationTime
        properties: "height"
        to:grid.height*0.6
        }

    }

    SequentialAnimation {
        id:hideSettings
        PropertyAnimation{
        target: settingsWindowBackground
        duration: animationTime
        properties: "height"
        to:0
    }
        PropertyAnimation{target:triangle;
        properties: "height"
        to:0}
}

    anchors.top:grid.top
    anchors.topMargin: -16;
    width: grid.width*0.8
    anchors.left: parent.left
    anchors.leftMargin:marginLeft

    Image {

        id:triangle
        anchors.top: parent.top
        x:trianglePosition - marginLeft
        source:"qrc:///img/triangle.png"
        clip:true
        height:0
        fillMode: Image.Tile

    }

    Rectangle {
        color:"#00aaff"
        height:parent.height-16
        width:parent.width
        anchors.top:parent.top
        anchors.topMargin: 16
    }

}

