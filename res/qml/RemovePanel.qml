import QtQuick 1.0
import "..///js/Global.js" as GlobalJS


Rectangle{

    width:120

Button {
    id:abortButton
    buttonHeight:35
    buttonWidth:35
    buttonNormal: "../..///img/"+mainWindow.colorScheme+"/abort.png"
    buttonActive: "../..///img/"+mainWindow.colorScheme+"/abort_Active.png"
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
    buttonNormal: "../..///img/"+mainWindow.colorScheme+"/confirm.png"
    buttonActive: "../..///img/"+mainWindow.colorScheme+"/confirm_Active.png"
    anchors.left:parent.left
    anchors.bottom:parent.bottom
    anchors.bottomMargin:20
    onPressed:controller.remove(GlobalJS.activeSeries)
    onReleased: {removeScreen.opacity=0
                 clickProtection.enabled="false"}

}
}
