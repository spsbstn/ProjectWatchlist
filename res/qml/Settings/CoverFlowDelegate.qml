import QtQuick 1.0

Item {

    id: delegateItem
    x: 0
    z: PathView.z
    width: dlgImg.width
    height: dlgImg.height
    scale: PathView.iconScale

    Column  {
        id: delegate
        y: coverFlow.topMargin
        spacing: 5

        Rectangle {
            id: delegateImage


            width: delegateItem.width
            height: delegateImage.width
            color: dlgImg.status == Image.Ready ? "white" : "transparent"


            Image {
                id: dlgImg
                anchors.centerIn: parent
                clip: true
                asynchronous: true             
                source: url
                smooth: true
            }
        }

    }

    MouseArea {
        anchors.fill: parent
        onClicked: console.log("clicked");
    }


    transform: Rotation {
        origin.x: delegateImage.width / 2
        origin.y: delegateImage.height / 2
        axis { x: 0; y: 1; z: 0 }
        angle:0

}

}
