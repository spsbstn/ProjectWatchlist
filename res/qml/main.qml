import QtQuick 1.1
import "..///js/Global.js" as GlobalJS
import Cursors 1.0
import WheelArea 1.0


Rectangle {

    id: mainWindow
    property int topBarSize: 50
    property int barSize: 120
    property int tileMargin: 6
    property int tileHeaderFontSize: (parseInt(grid.height / 3) - tileMargin)/10
    property int tileInfoFontSize: 16
    property int appHeaderFontSize: 36
    property string appBackground: "#EEEEEE"
    property string tileBackground: "#CCCCCC"
    property string textColor: "#484848"
    property string textColor2: "#00aaff"
    property string uiFont: frutigerLight.name
    property string colorScheme: controller.loadColorScheme();
    signal xmlDataRequired(string showName);
    onXmlDataRequired: updateInfo(showName);	
    focus:true
    width: 1366
    height: 768
    color: appBackground

    NumberAnimation {id: showClickProtection; target:clickProtection; property: "opacity"; to:0.5; duration: 800}
    NumberAnimation {id: removeClickProtection; target:clickProtection; property: "opacity"; to:0; duration: 800}
    NumberAnimation {id: showAddScreen; target:addScreen; property: "opacity"; to:1;   duration: 400}

    FontLoader {

        id: frutigerLight
        source: "qrc:../..///fonts/Frutiger Light.ttf"

    }

    //ctrl+t shortcut
    Keys.onPressed: { if ( (event.key === Qt.Key_T) && event.modifiers === Qt.ControlModifier) {

                         showAddScreen.start();
                         showClickProtection.start();
        }
    }

    function updateInfo(showName) {


        infoScreen.showName=showName;
        infoScreen.status=controller.getStatus(showName);
        infoScreen.airTime = controller.getAirtime(showName);
        infoScreen.network = controller.getNetwork(showName);
        infoScreen.genre = controller.getGenre(showName);
        infoScreen.started = controller.getStarted(showName);
        infoScreen.imageSource=controller.getImageUrl(showName);
        infoScreen.latestEpisode = controller.getLatestEpisode(showName);
        infoScreen.nextEpisode = controller.getNextEpisode(showName);
        infoScreen.mainOpacity=1;
        showClickProtection.start();

    }

    function htmlError() {

        topBar.htmlErrorIsVisible=true;
        grid.currentItem.loadingCircleVisible=false;

    }



    // DragArea to move window
    MouseArea {

        id: dragArea
        property variant clickPos: "1,1"
        anchors.fill: parent
        onPressed: clickPos = Qt.point(mouse.x, mouse.y)
        onPositionChanged: {

            var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)
            mainwindow.pos = Qt.point(mainwindow.pos.x+delta.x,
                              mainwindow.pos.y+delta.y)
        }
    }


    //Topbar
    TopBar {

        id: topBar
        anchors.left: leftBar.right
        anchors.top: parent.top
        height: topBarSize
        width: parent.width
    }

    //Leftbar
    Rectangle {

        id: leftBar
        x: 0
        y: 0
        anchors.left: parent.left
        anchors.top: parent.top
        width: barSize
        height: parent.height
        color: appBackground
        anchors.leftMargin: 0
        anchors.topMargin: 0
    }

    //GridView
    GridView {

        id: grid
        anchors.left: leftBar.right
        anchors.top: topBar.bottom
        flow: GridView.TopToBottom
        width: parent.width - leftBar.width
        height: parent.height - topBar.height - bottomBar.height
        cellHeight: parseInt(grid.height / 3)
        cellWidth: parseInt(cellHeight * 1.1)
        clip: false
        model: datalist //dataSource
        delegate: FlipTile{}

        states: State {

                when: grid.movingHorizontally
                PropertyChanges { target: horizontalScrollBar; opacity: 1 }

        }

        transitions: Transition {

            NumberAnimation { properties: "opacity"; duration: 400 }

        }
    }



    //Scrollbar
    Scrollbar {

        id: horizontalScrollBar
        width: parent.width; height: 6
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        opacity: 0
        orientation: Qt.Horizontal
        position: grid.visibleArea.xPosition
        pageSize: grid.visibleArea.widthRatio
        z:1
    }

    //Bottombar
    Rectangle {

        id: bottomBar
        anchors.top: grid.bottom
        anchors.left: leftBar.right
        width: parent.width - leftBar.width
        height: barSize/2
        color: appBackground
    }

    //addButton
    Button {

        id:addButton
        anchors.bottom: leftBar.bottom
        anchors.bottomMargin: 20
        anchors.left: leftBar.left
        anchors.leftMargin: 20
        buttonNormal:"qrc:../..///img/addIcon.png"
        buttonActive:"qrc:../..///img/addIcon_Active.png"
        buttonHeight: 35
        buttonWidth: 35

        ToolTip {

            toolTip: qsTr("Click or press Ctrl+T \n to add Show")
        }

        MouseArea {

            anchors.fill:parent
            onClicked: {

                showAddScreen.start();
                showClickProtection.start();
            }
        }
    }

    //ClickProtection
    Rectangle {

        id:clickProtection
        color:"#000000"
        opacity: 0;
        anchors.fill:mainWindow
        onOpacityChanged: controller.alphaBlendFrame(appBackground,clickProtection.opacity);

        //filter mouse events
        MouseArea {

            anchors.fill:parent;
            hoverEnabled:true;
            onEntered: {}
            onExited: {}

        }

        //filter CursorShapeEvents
        CursorShapeArea{

            anchors.fill:parent
            cursorShape: Qt.ArrowCursor
        }

        //filter ScrollEvents
        WheelArea {

            anchors.fill: parent
            onVerticalWheel: {}
            onHorizontalWheel: {}
        }
    }

    //RemoveScreen
    RemovePanel {

        id:removeScreen
        opacity: 0;
        height:bottomBar.height
        color:"transparent"
        anchors.left:bottomBar.left
        anchors.bottom: bottomBar.bottom
        anchors.leftMargin:(bottomBar.width-leftBar.width*2)/2

    }

    //AddScreen
    AddScreen {

        id:addScreen
        opacity: 0;
        z:0

    }

    //InfoScreen
    InfoScreen{

        id:infoScreen
        mainOpacity: 0

    }

    //SplashScreen
    SplashScreen{

        id:splashScreen
        imageSource: "qrc:///img/SplashScreen.png"
        anchors.fill: mainWindow
        onSplashScreenCompleted: controller.loadDB(); // load Database --> animationeffect
        z:1

    }

    //wrong show?
    Rectangle {

        id:wrongShowInfo
        anchors.centerIn: mainWindow
        height: parseInt(grid.height / 2)
        width: height*2
        opacity: 0
        color:tileBackground
        border.width: 5
        border.color: "black"

        Text {

            anchors.centerIn: parent
            horizontalAlignment: Text.AlignJustify
            color: textColor
            width:parent.width-60
            text: qsTr("If the wrong showdata is displayed, you propably didn't enter the exact showname. Go to www.tvrage.com and look for the exact name.\nEt voilà, it will work like a charm ;)")
            font.pixelSize: parent.width/20
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font.family: uiFont
        }

        Button {

            id:closeScreenButton
            anchors.top:parent.top
            anchors.topMargin: -11
            anchors.rightMargin: -11
            anchors.right:parent.right
            buttonHeight: 22
            buttonWidth: 22
            buttonNormal: "qrc:../..///img/closeScreenButton.png"
            onClicked: parent.opacity=0
        }
    }

    states: [

        State {
                when: colorScheme=="blackCyan"
                changes: [

                    PropertyChanges {target:mainWindow;appBackground:"#111111"},
                    PropertyChanges {target:mainWindow;tileBackground:"#00AAFF"},
                    PropertyChanges {target:mainWindow;textColor:"#000000"},
                    PropertyChanges{target:mainWindow;textColor2:"#00aaff"},
                    StateChangeScript { script:controller.changeColorScheme("#111111","blackCyan")}
                ]
        },

        State {
                when: colorScheme=="darkGreen"
                changes: [

                    PropertyChanges{target:mainWindow;appBackground:"#333333"},
                    PropertyChanges {target:mainWindow;tileBackground:"#30bf6e"},
                    PropertyChanges{target:mainWindow;textColor:"#000000"},
                    PropertyChanges{target:mainWindow;textColor2:"#00aaff"},
                    StateChangeScript { script:controller.changeColorScheme("#333333","darkGreen")}
                ]
        },

        State {
                 when: colorScheme=="darkOrange"
                 changes: [

                    PropertyChanges{target:mainWindow;appBackground:"#333333"},
                    PropertyChanges {target:mainWindow;tileBackground:"#ee771c"},
                    PropertyChanges{target:mainWindow;textColor:"#000000"},
                    PropertyChanges{target:mainWindow;textColor2:"#00aaff"},
                    StateChangeScript { script:controller.changeColorScheme("#333333","darkOrange")}
                 ]
        }
    ]
}
