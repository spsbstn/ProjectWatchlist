import QtQuick 1.0
import "..///js/Global.js" as GlobalJS


Rectangle{

    width:120

Button {
    id:abortButton
    buttonHeight:35
    buttonWidth:35
    buttonNormal: "qrc:../..///img/abort.png"
    buttonActive: "qrc:../..///img/abort_Active.png"
    anchors.right:parent.right
    anchors.bottom:parent.bottom
    anchors.bottomMargin:20
    onReleased: {removeScreen.opacity=0
        clickProtection.enabled="false"}

             }
Button {
    id:confirmButton
    buttonHeight:35
    buttonWidth:35
    buttonNormal: "qrc:../..///img/confirm.png"
    buttonActive: "qrc:../..///img/confirm_Active.png"
    anchors.left:parent.left
    anchors.bottom:parent.bottom
    anchors.bottomMargin:20
    onPressed:controller.remove(GlobalJS.activeSeries)
    onReleased: {removeScreen.opacity=0
                 clickProtection.enabled="false"}

}
}
