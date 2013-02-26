// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import Cursors 1.0

Item {
    id:mainDropDownItem
    property string description;
    property string name;
    property variant options
    property string startValue
    property string selectedItem:dropdown.selectedItem
    signal selectionChanged

    width: parent.width/1.5
    height: 50

    Text {
        id:nameLabel
        anchors.left:parent.left
        anchors.leftMargin: 10
        text: name
        font.pointSize: 20
        color:"#666666"

    }

    Text {
        id:descriptionLabel
        anchors.left:parent.left
        anchors.leftMargin: 12
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        text: description
        font.pointSize: 12
        color:"#999999"

    }

DropDown {
    id:dropdown
    items:options;
    anchors.right: mainDropDownItem.right
    anchors.verticalCenter: parent.verticalCenter
    startValue: mainDropDownItem.startValue
    onComboClicked: mainDropDownItem.selectionChanged();

}
}
