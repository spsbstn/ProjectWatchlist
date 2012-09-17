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
                text: qsTr("Watchlist")
                font.family: uiFont;
                font.pointSize: appHeaderFontSize;
                color: textColor
            }
        }

        // left bar
        Rectangle {
            id: leftBar
            anchors.left: parent.left
            anchors.top: parent.top
            width: barSize
            height: parent.height
            color: appBackground
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
            delegate: FlipTile{} //how to display

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

    }
