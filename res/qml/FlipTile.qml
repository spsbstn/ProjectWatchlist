import QtQuick 1.0
import "..///js/Global.js" as GlobalJS
import "..///js/WatchNow.js" as WatchNowLink


 Flipable {

    id: flipable
    width: parseInt(grid.height / 3) - tileMargin
    height: width - tileMargin

    property bool flipped: false
    property bool loadingCircleVisible: false
    property string currentEp;
    // random number between 5 and 10 (animation)
    property int rand: Math.floor(Math.random() * (10 - 5 + 1)) + 5;

    //addAnimation
    GridView.onAdd:

        checkForNewEpisodes();

        ParallelAnimation {

        NumberAnimation {

            target: flipable; easing.overshoot: 1.1; properties: "scale"; from: 0.0; to: 1.0;
            easing.type: Easing.OutBack;easing.amplitude: 2.0; easing.period: 1.5; duration:rand*100

        }

        NumberAnimation {

                target: flipable; properties: "opacity"; from: 0.0; to: 1.0;
                easing.type: Easing.OutQuad; easing.amplitude: 2.0; easing.period: 1.5; duration:rand*80
         }

    }

    //removeAnimation
    GridView.onRemove:

         SequentialAnimation {

            PropertyAction { target: flipable; property: "GridView.delayRemove"; value: true }

            ParallelAnimation {

                NumberAnimation {

                    target: flipable; properties: "scale"; from: 1.0; to: 0.0;
                    easing.type: Easing.OutQuad; easing.amplitude: 2.0; easing.period: 1.5; duration:700
                }

                NumberAnimation {

                    target: flipable; properties: "opacity"; from: 1.0; to: 0.0;
                    easing.type: Easing.OutQuad; easing.amplitude: 2.0; easing.period: 1.5; duration:500
                }
            }

            PropertyAction { target: flipable; property: "GridView.delayRemove"; value: false }
    }

    //check if new Episodes are available
    function checkForNewEpisodes () {


        if(controller.getLatestEpisode(seriesName.text).substr(0,2)*1>season*1) {

            newEpisodes.visible=true;

        }

        else {

            if(controller.getLatestEpisode(seriesName.text).substr(3,2)*1>episode*1) {

                newEpisodes.visible=true;

            }

            else {

                newEpisodes.visible=false;

            }

        }

    }

//front
front: Rectangle {

    width: parent.width - tileMargin
    height: parent.height - tileMargin
    color:mainWindow.tileBackground

    Text {

        id: seriesName
        anchors.centerIn: parent
        color: mainWindow.textColor
        text: title
        smooth:true
        width:parent.width
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        font {
            family:mainWindow.uiFont
            capitalization: Font.AllUppercase;
            pointSize: mainWindow.tileHeaderFontSize
        }
    }

    Image {

        id: newEpisodes
        height: 35
        width: 35
        visible:false
        source: "qrc:///img/new.png"
        anchors.right:parent.right
        anchors.rightMargin: 5
        anchors.bottom:parent.bottom
        anchors.bottomMargin: 5

    }

    //MouseArea to flip tile
    MouseArea {
        anchors.fill:parent
        onClicked: flipable.flipped = !flipable.flipped
    }
}

//back
back: Rectangle {

    width: parent.width - tileMargin
    height: parent.height - tileMargin
    color: mainWindow.tileBackground

    //MouseArea to flip tile
    MouseArea {

        anchors.fill:parent
        onClicked: flipable.flipped = !flipable.flipped
    }

    Rectangle {

        id: seasonTxt
        width: parent.width;
        anchors.top: parent.top
        anchors.topMargin: tileMargin + 50
        color:"transparent"
        height:22

        Text {

            id:text2
            anchors.centerIn: parent
            color: mainWindow.textColor
            text: qsTr("Season: ") + season
            wrapMode: Text.WordWrap;
            font {
                family: mainWindow.uiFont
                pointSize: 25
            }
        }

        Button{

            id: seasonIncrease
            buttonHeight: 18
            buttonWidth: 18
            buttonNormal: "../..///img/"+mainWindow.colorScheme+"/rightButton.png"
            buttonActive: "../..///img/"+mainWindow.colorScheme+"/rightButton_Active.png"
            anchors.right:parent.right
            anchors.rightMargin: (seasonTxt.width-text2.width-(2*width))/2
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {
                controller.setSeason(seriesName.text, +1);
                // set Episode to 1
                controller.setEpisode(seriesName.text,(-episode+1));
                checkForNewEpisodes ();
            }
        }

        Button {

            id: seasonDecrease
            buttonHeight: 18
            buttonWidth: 18
            buttonNormal: "../..///img/"+mainWindow.colorScheme+"/leftButton.png"
            buttonActive: "../..///img/"+mainWindow.colorScheme+"/leftButton_Active.png"
            anchors.left:parent.left
            anchors.leftMargin: (seasonTxt.width-text2.width-(2*width))/2
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {
                controller.setSeason(seriesName.text, -1);
                // set Episode to 1
                controller.setEpisode(seriesName.text,(-episode+1));
                checkForNewEpisodes ();
            }
        }

        states: [
            State{

                PropertyChanges{ target: seasonDecrease; opacity: 0 }
                when: season === 1
            },

            State{

                PropertyChanges{ target: seasonIncrease; opacity: 0 }
                when: season === 99
            }
        ]
    }

    Rectangle {

        id: episodeTxt
        width:parent.width
        height:22
        color:"transparent"
        anchors.top: parent.top
        anchors.topMargin: tileMargin+100

        Text {

            id:text1
            anchors.centerIn: parent
            color: mainWindow.textColor
            text: qsTr("Episode: ") + episode
            wrapMode: Text.WordWrap;
            font {
                family: mainWindow.uiFont
                pointSize: 25
            }
        }

        Button {

            id: episodeIncrease
            buttonHeight: 18
            buttonWidth: 18
            buttonNormal: "../..///img/"+mainWindow.colorScheme+"/rightButton.png"
            buttonActive: "../..///img/"+mainWindow.colorScheme+"/rightButton_Active.png"
            anchors.right:parent.right
            anchors.rightMargin: (episodeTxt.width-text1.width-(2*width))/2
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {controller.setEpisode(seriesName.text, +1);
                        checkForNewEpisodes();}

        }

        Button {

            id: episodeDecrease
            buttonHeight: 18
            buttonWidth: 18
            buttonNormal: "../..///img/"+mainWindow.colorScheme+"/leftButton.png"
            buttonActive: "../..///img/"+mainWindow.colorScheme+"/leftButton_Active.png"
            anchors.left:parent.left
            anchors.leftMargin: (episodeTxt.width-text1.width-(2*width))/2
            anchors.verticalCenter: parent.verticalCenter
            onClicked: {controller.setEpisode(seriesName.text, -1);
                        checkForNewEpisodes ();}
        }

        states: [
            State {
                PropertyChanges { target: episodeDecrease; opacity: 0 }
                when: episode === 1
            },

            State{
               PropertyChanges { target: episodeIncrease; opacity: 0 }
               when: episode === 99
            }
        ]
    }

    Button {

        id:removeButton
        buttonHeight:15
        buttonWidth:15
        buttonNormal: "../..///img/"+mainWindow.colorScheme+"/removeIcon.png"
        buttonActive:"../..///img/"+mainWindow.colorScheme+"/removeIcon_Active.png"
        anchors.top: parent.top
        anchors.right:parent.right
        anchors.topMargin: 10
        anchors.rightMargin: 8
        onPressed: {

            GlobalJS.activeSeries = seriesName.text;
            showClickProtection.start();

        }

        onReleased:

            NumberAnimation
        {
            target:removeScreen; property:"opacity"; to:1; duration: 400

            onCompleted: { removeScreen.loadingFinshed=true }
        }
    }

Button {

    id:infoButton
    buttonHeight:16
    buttonWidth:16
    buttonNormal: "../..///img/"+mainWindow.colorScheme+"/info.png"
    buttonActive: "../..///img/"+mainWindow.colorScheme+"/info_Active.png"
    anchors.bottom: parent.bottom
    anchors.right:parent.right
    anchors.bottomMargin: 10
    anchors.rightMargin: 8
    hoverEnabled: true
    onPressed: {

        loadingCircleVisible=true;
        topBar.htmlErrorIsVisible=false;
        grid.currentIndex = index;
    }

    onReleased:xmlDataRequired(title);
}

Button {

    id:watchNowButton
    buttonHeight:16
    buttonWidth:16
    buttonNormal: "../..///img/"+mainWindow.colorScheme+"/watchnow.png"
    buttonActive: "../..///img/"+mainWindow.colorScheme+"/watchnow_Active.png"
    anchors.bottom: parent.bottom
    anchors.right:infoButton.left
    anchors.bottomMargin: 10
    anchors.rightMargin: 5
    hoverEnabled: true
    onPressed: {

        Qt.openUrlExternally(WatchNowLink.getLink(title));

    }
}

LoadingCircle {

    id:loadingCircel
    circleDiameter:20
    radiusPoints: 2
    visible: loadingCircleVisible;
    anchors.left:parent.left
    anchors.leftMargin: 10
    anchors.bottom:parent.bottom
    anchors.bottomMargin: 8
}
 }

transform: Rotation {

    id: rotation
    origin.x: (flipable.width-tileMargin)/2
    origin.y: flipable.height/2
    axis.x: 0; axis.y: 1; axis.z: 0
    angle: 0.01    // the default angle
}

states: [
    State {

        name: "back"
        PropertyChanges { target: rotation; angle: 179.99 }
        when: flipable.flipped

            }
        ]

transitions: Transition {
         NumberAnimation { target: rotation; property: "angle"; duration: 1000 }
     }
 }
