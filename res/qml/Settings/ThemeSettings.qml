import QtQuick 1.1
import "../"

Item {

    anchors.fill:parent;

    ListModel {
    id: themes

    }
    ListModel {
        id: galleryModel

        ListElement { url: "qrc:///img/orange.png" }
        ListElement { url: "qrc:///img/darkcyan.png" }
        ListElement { url: "qrc:///img/redandwhite.png" }
        ListElement { url: "qrc:///img/green.png" }
    }

    // The CoverFlow element itself, which shows the images (and their
    // reflections) on a PathView from the model.
    CoverFlow {
        anchors {
            fill: parent
        }

        // Provide the model (which provides the pahts to the images)
        // to the CoverFlow component.
        model: galleryModel
        onCurrentIndexChanged: console.log("Current index: " + index)
    }

}
