import QtQuick 1.0

Rectangle {
    id: mainWindow
    width: 1366
    height: 768
    color: appBackground

    property int topBarSize: 144
    property int barSize: 120
    property int tileMargin: 6
    property int tileHeaderFontSize: 15
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
                x: 43
                y: 679
                width: 35
                height: 35
                smooth:true

                source:"../../res/img/addIcon.png"



                MouseArea {
                    x: 0
                    y: 0
                    width: 35
                    height: 35

                    anchors.bottomMargin: 0
                    anchors.leftMargin: 0
                    anchors.topMargin: 0
                    anchors.rightMargin: 0
                anchors.fill: parent
                onReleased: NumberAnimation { target: addButtonActive; property: "opacity"; to: 0; duration: 10;  }
                onPressed:NumberAnimation { target: addButtonActive; property: "opacity"; to: 1; duration: 10;  }
                onClicked: NumberAnimation { target: addScreenBackground; property: "opacity"; to: 0.5; duration: 1000;  }
                }

            }

            Image {
            id:addButtonActive
            x: 43
            y: 679
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
              x: 431
              y: 265
              width: height*2
              height: parseInt(grid.height / 2)
              anchors.centerIn: addScreenBackground
              opacity: 0;
              color:'#00aaff'
              anchors.verticalCenterOffset: 7
              anchors.horizontalCenterOffset: 0


                  Text {
                      id: addInfp
                      x: 37
                      y: 28
                      color: "#ffffff"
                      text: qsTr("Name der neuen Serie:")
                      font.pixelSize: 33
                      font.bold: false
                      font.family: "Helvetica Neue"
                  }

                  TextInput {
                      id: nameInput
                      x: 49
                      y: 125
                      width: 402
                      height: 38
                      text: qsTr("")
                      z: 1
                      font.family: "Helvetica Neue"
                      font.pixelSize: 30
                  }

                  Rectangle {
                      id: addInputBg
                      x: 37
                      y: 120
                      width: 430
                      height: 49
                      color: "#ffffff"
                      z: 0
                  }

                  }
      }

    }
