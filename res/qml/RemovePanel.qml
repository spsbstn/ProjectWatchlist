import QtQuick 1.0
import "..///js/Global.js" as GlobalJS


Rectangle{

    width:120

AbortButton {
    anchors.right:parent.right
    anchors.bottom:parent.bottom
    anchors.bottomMargin:20
    onReleased: {removeScreen.opacity=0
        clickProtection.enabled="false"}

             }
ConfirmButton {
    anchors.left:parent.left
    anchors.bottom:parent.bottom
    anchors.bottomMargin:20
    onPressed:controller.remove(GlobalJS.activeSeries)
    onReleased: {removeScreen.opacity=0
                 clickProtection.enabled="false"}

}
}
