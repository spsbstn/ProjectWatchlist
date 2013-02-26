import QtQuick 1.0
import Cursors 1.0

Rectangle {
           id:ddmain
           height:30
           width:150
            property variant items;
            property alias selectedItem: chosenItemText.text;
            property alias selectedIndex: listView.currentIndex;
            property string startValue;
            signal comboClicked;

    Rectangle {

            id:comboBox
anchors.fill: parent
            smooth:true;

            CursorShapeArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
              }

            Rectangle {
                id:chosenItem
                width:parent.width;
                height:comboBox.height;
                color: "lightgrey"
                Text {
                    anchors.left: parent.left;
                    anchors.leftMargin: 8;
                    anchors.verticalCenter: parent.verticalCenter
                    id:chosenItemText
                    text:startValue;
                    font.family: mainWindow.uiFont
                    font.pointSize: 20;
                }
                Image {
                height:30
                width:30
                anchors.bottom:parent.bottom
                anchors.bottomMargin: -1
                anchors.right:parent.right
                anchors.rightMargin: -1
                source:"qrc:../..///img/dropDown.png"}

                MouseArea {
                    anchors.fill: parent;
                    onClicked: {
                        comboBox.state = comboBox.state==="dropDown"?"":"dropDown"
                    }
                }
            }

            Rectangle {
                id:dropDown
                width:comboBox.width+1;
                height:0;
                clip:true;
                anchors.top: chosenItem.bottom;
                color: "white"

                ListView {
                    id:listView
                    height:500;
                    model: items
                    currentIndex: 0
                    delegate: Rectangle{

                        id:item
                        width:comboBox.width+1;
                        height: comboBox.height;

                        CursorShapeArea {

                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                          }

                        Text {

                            text: modelData
                            anchors.top: parent.top;
                            anchors.left: parent.left;
                            anchors.margins: 5;

                        }
                        MouseArea {

                            id:dropDownMouseArea
                            anchors.fill: parent;
                            hoverEnabled: true
                            onEntered: {item.color="#00aaff"}
                            onExited:  {item.color="white"}
                            onClicked: {
                                comboBox.state = ""
                                var prevSelection = chosenItemText.text
                                chosenItemText.text = modelData
                                if(chosenItemText.text != prevSelection){
                                    ddmain.comboClicked();
                                }

                                listView.currentIndex = index;
                            }     
                    }

                   }
                }
            }

            states: State {
                name: "dropDown";
                PropertyChanges { target: dropDown; height:40*(items.length-1)+8 }
            }

            transitions: Transition {
                NumberAnimation { target: dropDown; properties: "height"; easing.type: Easing.OutExpo; duration: 1000 }
            }
        }
    }
