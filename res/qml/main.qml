import QtQuick 1.1
import "..///js/Global.js" as GlobalJS
import Cursors 1.0
import WheelArea 1.0


Rectangle {
    id: mainWindow
    focus:true
    width: 1366
    height: 768
    color: appBackground
    signal xmlDataRequired(string showName);

    FontLoader {

        id: frutigerLight
        source: "qrc:../..///fonts/Frutiger Light.ttf"
                }


    function updateInfo() {


        infoScreen.showName=controller.getName();
        infoScreen.status=controller.getStatus();
        infoScreen.airTime = controller.getAirtime;
        infoScreen.network = controller.getNetwork();
        infoScreen.genre = controller.getGenre();
        infoScreen.started = controller.getStarted();
        infoScreen.imageSource=controller.getImageUrl();
        infoScreen.latestEpisode = controller.getLatestEpisode();
        infoScreen.nextEpisode = controller.getNextEpisode();
        infoScreen.mainOpacity=1;
        grid.currentItem.loadingCircleVisible=false;
        showClickProtection.start();

    }

    function htmlError() {

        topBar.htmlErrorIsVisible=true;
        grid.currentItem.loadingCircleVisible=false;

    }

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
    property string colorScheme: controller.loadColorScheme()

    NumberAnimation {id: showClickProtection; target:clickProtection; property: "opacity"; to:0.5; duration: 800}
    NumberAnimation {id: removeClickProtection; target:clickProtection; property: "opacity"; to:0; duration: 800}
    NumberAnimation {id: showAddScreen; target:addScreen;       property: "opacity"; to:1;   duration: 400}
    Keys.onPressed: { if ( (event.key === Qt.Key_T) && event.modifiers === Qt.ControlModifier) {
                         showAddScreen.start();
                         showClickProtection.start();}
              }


// DragArea
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

//AddButton


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
                     toolTip: "Click or press Ctrl+T \n to add Show"
                 }

                 MouseArea {
                 anchors.fill:parent
                 onClicked:
                            {showAddScreen.start()
                     showClickProtection.start();}

             }
    }

        Rectangle{

              id:clickProtection
              color:"#000000"
              opacity: 0;
              anchors.fill:mainWindow
              onOpacityChanged: controller.alphaBlendFrame(appBackground,clickProtection.opacity)

        MouseArea {
            anchors.fill:parent;
            hoverEnabled:true;
            onEntered: {}
            onExited: {}

        }
        CursorShapeArea{
        anchors.fill:parent
        cursorShape: Qt.ArrowCursor

        }
        WheelArea {
            anchors.fill: parent
            onVerticalWheel: {}
            onHorizontalWheel: {}
          }}

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


    InfoScreen{
    id:infoScreen
    mainOpacity: 0
    }


    SplashScreen{
    id:splashScreen
    imageSource: "qrc:///img/SplashScreen.png"
    anchors.fill: mainWindow
    onSplashScreenCompleted: controller.loadDB();
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
          transform: Rotation {origin.x: (width)/2
          origin.y: height/2
          axis.x: 0; axis.y: 1; axis.z: 0
          angle: 0.01 }
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

        states: [ State {
                when: colorScheme=="blackCyan"
                changes:

                    [PropertyChanges {target:mainWindow;appBackground:"#111111"},
                    PropertyChanges {target:mainWindow;tileBackground:"#00AAFF"},
                    PropertyChanges {target:mainWindow;textColor:"#000000"},
                    PropertyChanges{target:mainWindow;textColor2:"#00aaff"},
                    StateChangeScript { script:controller.changeColorScheme("#111111","blackCyan")}]

                        },
                  State {
                when: colorScheme=="darkGreen"
                changes:
                    [PropertyChanges{target:mainWindow;appBackground:"#333333"},
                    PropertyChanges {target:mainWindow;tileBackground:"#30bf6e"},
                    PropertyChanges{target:mainWindow;textColor:"#000000"},
                    PropertyChanges{target:mainWindow;textColor2:"#00aaff"},
                    StateChangeScript { script:controller.changeColorScheme("#333333","darkGreen")}]
                        },
                   State {
                 when: colorScheme=="darkOrange"
                 changes:
                    [PropertyChanges{target:mainWindow;appBackground:"#333333"},
                    PropertyChanges {target:mainWindow;tileBackground:"#ee771c"},
                    PropertyChanges{target:mainWindow;textColor:"#000000"},
                    PropertyChanges{target:mainWindow;textColor2:"#00aaff"},
                    StateChangeScript { script:controller.changeColorScheme("#333333","darkOrange")}]
                        }

                 ]

}
