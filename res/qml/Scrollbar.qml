import QtQuick 1.0

Item {

    id: scrollBar
    property real position
    property real pageSize
    property variant orientation : Qt.Vertical

    Rectangle {

        id: background
        anchors.fill: parent
        radius: width/2 - 1
        color: mainWindow.appBackground
    }

    Rectangle {

        x: scrollBar.position * (scrollBar.width-2) + 1
        y: 1
        width: scrollBar.pageSize * (scrollBar.width-2)
        height: parent.height
        radius: height/2 - 1
        color: mainWindow.tileBackground
    }
}
