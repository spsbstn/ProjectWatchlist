import QtQuick 1.0

Item {
    id: coverFlow


    property ListModel model
    property int itemCount: 3
    property int topMargin: 80

    signal currentIndexChanged(int index)


    Component.onCompleted: {
        pathView.currentIndex = 0; // load from settingsfile
    }

    PathView {
        id: pathView

        model: coverFlow.model
        delegate: CoverFlowDelegate {}
        path: coverFlowPath
        pathItemCount: coverFlow.itemCount

        anchors.fill: parent
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
        focus: true

        Keys.onRightPressed: {
            if (interactive) {
                incrementCurrentIndex()
            }
        }

        Keys.onLeftPressed: {
            if (interactive) {
                decrementCurrentIndex()
            }
        }

        onCurrentIndexChanged: {
            coverFlow.currentIndexChanged(pathView.currentIndex);
        }
    }

    Path {

        id: coverFlowPath

        // "Start zone"
        startX: -25
        startY: coverFlow.height / 2
        PathAttribute { name: "z"; value: 0 }
        PathAttribute { name: "angle"; value: 70 }
        PathAttribute { name: "iconScale"; value: 0.6 }

        // Just before middle
        PathLine { x: coverFlow.width * 0.35; y: coverFlow.height / 2;  }
        PathAttribute { name: "z"; value: 50 }
        PathAttribute { name: "angle"; value: 45 }
        PathAttribute { name: "iconScale"; value: 0.85 }
        PathPercent { value: 0.40 }

        // Middle
        PathLine { x: coverFlow.width * 0.5; y: coverFlow.height / 2;  }
        PathAttribute { name: "z"; value: 100 }
        PathAttribute { name: "angle"; value: 0 }
        PathAttribute { name: "iconScale"; value: 1.0 }

        // Just after middle
        PathLine { x: coverFlow.width * 0.65; y: coverFlow.height / 2; }
        PathAttribute { name: "z"; value: 50 }
        PathAttribute { name: "angle"; value: -45 }
        PathAttribute { name: "iconScale"; value: 0.85 }
        PathPercent { value: 0.60 }

        // Final stop
        PathLine { x: coverFlow.width + 25; y: coverFlow.height / 2; }
        PathAttribute { name: "z"; value: 0 }
        PathAttribute { name: "angle"; value: -70 }
        PathAttribute { name: "iconScale"; value: 0.6 }
        PathPercent { value: 1.0 }
    }
}
