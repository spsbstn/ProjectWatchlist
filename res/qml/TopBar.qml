import QtQuick 1.1

Item {

    Rectangle{
    id:versionInfo
    height:parent.height
    width:160
    Text {

        anchors.centerIn: parent
        text:"Watchlist v.0.5"
        color:"#dddddd"
        font.pixelSize: 16
        font.family: "Helvetica-Neue"
        font.weight: Font.Light
    }
    }
    Rectangle{
    id:topControles}

    Rectangle {
    id:border
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 15
    height:1
    color:'#dddddd'
    width:parent.width*0.8
    }
}
