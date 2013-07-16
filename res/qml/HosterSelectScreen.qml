import QtQuick 1.1
import "..///js/Global.js" as GlobalJS
import Cursors 1.0

Rectangle {

    onOpacityChanged: {

                          selectHoster(GlobalJS.hoster)
                          selectHosterScreen.focus = true
                      }

    function resetAll() {

        kinoxSelected.opacity = 0
        vodlySelected.opacity = 0
        huluSelected.opacity = 0
        tvmuseSelected.opacity = 0
    }

    function selectHoster(hoster) {

        if (hoster == "kinox") {

            kinoxSelected.opacity = 1
        }
        if (hoster == "tvmuse") {

            tvmuseSelected.opacity = 1
        }

        if (hoster == "hulu") {

            huluSelected.opacity = 1
        }

        if (hoster == "vodly") {

            vodlySelected.opacity = 1
        }
    }

    Keys.onEscapePressed: {

        selectHosterScreen.opacity = 0
        removeClickProtection.start()
    }

    id: selectHosterScreen
    opacity: 0
    anchors.centerIn: parent
    height: 0.6 * parent.height
    width: 0.6 * parent.width
    color: mainWindow.tileBackground

    Item {
        id: headline
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        width: 400
        height: 140

        Image {

            height: 80
            width: 400
            anchors.centerIn: parent
            source: "qrc:../..///img/selectHoster.png"
        }
    }

    Rectangle {

        id: kinoxto
        color: "transparent"
        height: 67
        width: 267
        anchors.top: headline.bottom
        anchors.topMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 80

        Button {

            buttonHeight: 67
            buttonWidth: 200
            buttonNormal: "qrc:../..///img/kinox.png"
            anchors.left: parent.left
            onClicked: {

                resetAll()
                kinoxSelected.opacity = 1
                GlobalJS.hoster = "kinox"
            }
        }

        Image {

            id: kinoxSelected
            height: 67
            width: 67
            opacity: 0
            anchors.right: parent.right
            source: "qrc:../..///img/arrow_left.png"
        }
    }

    Rectangle {

        id: vodlyto
        color: "transparent"
        height: 67
        width: 267
        anchors.top: headline.bottom
        anchors.topMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 80

        Button {

            buttonHeight: 67
            buttonWidth: 200
            buttonNormal: "qrc:../..///img/vodly.png"
            anchors.right: parent.right
            onClicked: {

                resetAll()
                vodlySelected.opacity = 1
                GlobalJS.hoster = "vodly"
            }
        }
        Image {

            id: vodlySelected
            height: 67
            width: 67
            opacity: 0
            anchors.left: parent.left
            source: "qrc:../..///img/arrow_left.png"
        }
    }

    Rectangle {

        id: hulu
        color: "transparent"
        height: 67
        width: 267
        anchors.top: kinoxto.bottom
        anchors.left: kinoxto.left
        anchors.topMargin: 20

        Button {

            buttonHeight: 67
            buttonWidth: 200
            buttonNormal: "qrc:../..///img/hulu.png"
            anchors.left: parent.left
            onClicked: {

                resetAll()
                huluSelected.opacity = 1
                GlobalJS.hoster = "hulu"
            }
        }
        Image {

            id: huluSelected
            height: 67
            width: 67
            opacity: 0
            anchors.right: parent.right
            source: "qrc:../..///img/arrow_left.png"
        }
    }

    Rectangle {

        id: tvmuse
        color: "transparent"
        height: 67
        width: 267
        anchors.top: vodlyto.bottom
        anchors.right: vodlyto.right
        anchors.topMargin: 20

        Button {

            buttonHeight: 67
            buttonWidth: 200
            buttonNormal: "qrc:../..///img/tvmuse.png"
            anchors.right: parent.right
            onClicked: {

                resetAll()
                tvmuseSelected.opacity = 1
                GlobalJS.hoster = "tvmuse"
            }
        }

        Image {

            id: tvmuseSelected
            height: 67
            width: 67
            opacity: 0
            anchors.left: parent.left
            source: "qrc:../..///img/arrow_left.png"
        }
    }

    Rectangle {

        id:doneButton
        color: "white"
        width: 200
        height: 40
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.right:parent.right
        anchors.rightMargin: 20

        Text {

            id: done
            anchors.centerIn: parent
            color: mainWindow.tileBackground
            text: "Done."
            smooth: true
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            font {
                family: mainWindow.uiFont
                capitalization: Font.AllUppercase
                pointSize: 20
            }
        }

        MouseArea {
            hoverEnabled: true
            anchors.fill: parent
            onEntered: {
                doneButton.color="white";
            }
            onClicked: {

                selectHosterScreen.opacity = 0
                removeClickProtection.start()
            }
        }

        CursorShapeArea {

            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
        }
    }
}
