import QtQuick 1.0

Rectangle {
    id: mainWindow
    width: 1366
    height: 768
    color: appBackground

    property int topBarSize: 144
    property int barSize: 120
    property int tileMargin: 6
    property int tileHeaderFontSize: mainWindow.height/50
    property int tileDateFontSize: 12
    property int appHeaderFontSize: 36
    property string appBackground: "#262626"
    property string tileBackground: "#00aaff"
    property string textColor: "white"
    property string uiFont: "Helvetica-Neue"


    // data to display
    ListModel {
             id: appModel
             ListElement { name: "Breaking Bad"; episode: "2"; season:"1"}
             ListElement { name: "IASIP"; episode: "3"; season:"4"}
             ListElement { name: "HIMYM"; episode: "5"; season:"2"}
             ListElement { name: "Chuck"; episode: "12"; season:"5"}
             ListElement { name: "Breaking Bad"; episode: "2"; season:"1"}
             ListElement { name: "IASIP"; episode: "3"; season:"4"}
             ListElement { name: "HIMYM"; episode: "5"; season:"2"}
             ListElement { name: "Chuck"; episode: "12"; season:"5"}

         }

        // Top bar
        Rectangle {
            id: topBar
            anchors.left: leftBar.right
            anchors.top: parent.top
            height: topBarSize
            color: appBackground
            Text {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                text: qsTr("Watchlist.")
                font.family: uiFont;
                font.pointSize: appHeaderFontSize;
                color: textColor
            }
        }

        // left bar
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

            Image {
                id:addButton
                anchors.bottom: leftBar.bottom
                anchors.bottomMargin: 40
                anchors.left: leftBar.left
                anchors.leftMargin: 40
                width: 35
                height: 35
                smooth:true

                source:"../../res/img/addIcon.png"



                MouseArea {

                width: 35
                height: 35
                anchors.fill: parent
                onReleased: NumberAnimation { target: addButtonActive; property: "opacity"; to: 0; duration: 10;  }
                onPressed:NumberAnimation { target: addButtonActive; property: "opacity"; to: 1; duration: 10;  }
                onClicked: NumberAnimation { target: addScreenBackground; property: "opacity"; to: 0.5; duration: 1000;  }
                }

            }

            Image {
            id:addButtonActive
            anchors.bottom: leftBar.bottom
            anchors.bottomMargin: 40
            anchors.left: leftBar.left
            anchors.leftMargin: 40
            opacity:0
            width:35
            height:35
            smooth:true
            source:"../../res/img/addIcon_Active.png"
            }
        }

        // Grid view
        GridView {
            id: grid
            anchors.left: leftBar.right
            anchors.top: topBar.bottom
            flow: GridView.TopToBottom
            width: parent.width - leftBar.width
            height: parent.height - topBar.height - bottomBar.height
            cellHeight: parseInt(grid.height / 2)
            cellWidth: parseInt(cellHeight * 1.1)
            clip: false
            focus: true
            model: appModel //dataSource
            delegate: FlipTile{}

            //how to display

            // Only show the scrollbars when the view is moving.
            states: State {
                when: grid.movingHorizontally
                PropertyChanges { target: horizontalScrollBar; opacity: 1 }
            }

            transitions: Transition {
                NumberAnimation { properties: "opacity"; duration: 400 }
            }
        }

        // bottom bar
        Rectangle {
            id: bottomBar
            anchors.top: grid.bottom
            anchors.left: leftBar.right
            width: parent.width - leftBar.width
            height: barSize
            color: appBackground
        }

        Scrollbar {
            id: horizontalScrollBar
            width: parent.width; height: 6
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            opacity: 0
            orientation: Qt.Horizontal
            position: grid.visibleArea.xPosition
            pageSize: grid.visibleArea.widthRatio
        }

      Item {
          id:addScreen

          Rectangle {
              id:addScreenBackground
              width: mainWindow.width;
              height: mainWindow.height;
              opacity: 0;
              color:'black'
              onOpacityChanged: NumberAnimation { target: addScreenInsert; property: "opacity"; to: 1; duration: 1000;}
          }
          Rectangle {
              id:addScreenInsert
              anchors.centerIn: addScreenBackground
              width: height*2
              height: parseInt(grid.height / 2)
              opacity: 0;
              color:'#00aaff'
              anchors.verticalCenterOffset: 7
              anchors.horizontalCenterOffset: 0


                  Text {
                      id: addInfo
                      anchors.left: parent.left
                      anchors.leftMargin: 20
                      anchors.top: parent.top
                      anchors.topMargin: addScreenInsert.width/18
                      color: "#ffffff"
                      text: qsTr("Name der neuen Serie:")
                      font.pixelSize: addScreenInsert.width/18
                      font.bold: false
                      font.family: "Helvetica Neue"
                  }


                  Rectangle {
                      id: addInputBg
                      anchors.bottom: addScreenInsert.bottom
                      anchors.bottomMargin: addScreenInsert.height/3
                      anchors.left: addScreenInsert.left
                      anchors.leftMargin: (addScreenInsert.width-width)/2
                      width: addScreenInsert.width-50
                      height: addScreenInsert.width/14
                      color: "#ffffff"



                  TextInput {
                      id: nameInput
                      anchors.left:parent.left+10
                      anchors.centerIn: parent
                      width: addInputBg.width-20
                      height: addInputBg.height-10
                      text: qsTr("")
                      font.family: "Helvetica Neue"
                      font.pixelSize: height-(height/5)
                  }
}

                  }
      }

    }
