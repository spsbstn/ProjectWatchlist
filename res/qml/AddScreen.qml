import QtQuick 1.0

Item {
    id:addScreen
        property int offset:5
        anchors.fill:parent

    Rectangle {
        id:addScreenTile
        anchors.centerIn: addScreen
        height: parseInt(grid.height / 3)
        width: height*2
        opacity: 1;
        color:'#00aaff'
            Text {
              anchors.left: parent.left
              anchors.leftMargin: 20
              anchors.top: parent.top
              anchors.topMargin: parent.width/18
              color: "#ffffff"
              text: qsTr(" + Neue Serie")
              font.pixelSize: parent.width/18
              font.family: uiFont
              font.weight: Font.Light
              transform: Rotation {origin.x: (width)/2
              origin.y: height/2
              axis.x: 0; axis.y: 1; axis.z: 0
              angle: 0.01 }
                  }

            Rectangle {
                 anchors.bottom: parent.bottom
                 anchors.bottomMargin: parent.height/2
                 anchors.left: parent.left
                 anchors.leftMargin: (parent.width-width)/2
                 width: parent.width-50
                 height: parent.width/14
                 color: "#ffffff"

            TextInput {
                id: nameInput
                anchors.left:parent.left
                anchors.leftMargin: 10;
                anchors.centerIn: parent
                width: parent.width-20
                height: parent.height-10
                focus:false
                onActiveFocusChanged:
                    if (activeFocus == true) {
                      selectAll();
                    }
                text: qsTr("Name")
                font.pixelSize: height-(height/5)
                onAccepted: if(nameInput.text != "Name" && nameInput.text != "" &&
                                    genreInput.text != "Genre" && genreInput.text != ""){
                                controller.add(nameInput.text.toLowerCase(),genreInput.text.toLocaleLowerCase(),addScreen.opacity=0)
                            }
                Keys.onEscapePressed: addScreen.opacity=0;
                Keys.onTabPressed: {if(text==""){text="Name"};
                                    focus=false;
                                    genreInput.focus=true;}
                MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                nameInput.focus=true;
                                genreInput.focus=false;
                            }
                       }
                       }

            }
            Rectangle {
                 anchors.bottom: parent.bottom
                 anchors.bottomMargin: parent.height/4
                 anchors.left: parent.left
                 anchors.leftMargin: (parent.width-width)/2
                 width: parent.width-50
                 height: parent.width/14
                 color: "#ffffff"

            TextInput {
                id: genreInput
                anchors.left:parent.left
                anchors.leftMargin: 10;
                anchors.centerIn: parent
                width: parent.width-20
                height: parent.height-10

                onActiveFocusChanged:
                    if (activeFocus == true) {
                      selectAll();
                    }
                text: qsTr("Genre")
                focus:false
                font.pixelSize: height-(height/5)
                onAccepted: if(nameInput.text != "Name" && nameInput.text != "" &&
                                    genreInput.text != "Genre" && genreInput.text != ""){
                                controller.add(nameInput.text.toLowerCase(),genreInput.text.toLocaleLowerCase(),addScreen.opacity=0)
                            }
                Keys.onEscapePressed: addScreen.opacity=0;
                Keys.onTabPressed: { if(text==""){text="Genre"};
                                    focus=false;
                                    nameInput.focus=true;}
                MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                nameInput.focus=false;
                                genreInput.focus=true;
                            }
                   }    }

            }
            CloseScreenButton {
            anchors.top:parent.top
            anchors.topMargin: -11
            anchors.rightMargin: -11
            anchors.right:parent.right
            onClicked: addScreen.opacity=0}
            PlusButtonDark {
                 id:addButton
                 anchors.bottom: addScreenTile.bottom
                 anchors.bottomMargin: 15
                 anchors.right: addScreenTile.right
                 anchors.rightMargin: 15
                 onClicked: if(nameInput.text != "Name" && nameInput.text != "" &&
                                    genreInput.text != "Genre" && genreInput.text != ""){
                                  nameInput.accepted();
                                }
                 }
    }
    states: [ State {
                        when: addScreen.opacity==0
                        StateChangeScript { script:nameInput.text="Name" }
                        StateChangeScript { script:genreInput.text="Genre" }
                        PropertyChanges   { target:mainWindow; focus:true; }

                    },
              State {
                        when: addScreen.opacity==1
                        PropertyChanges { target:nameInput; focus:true; restoreEntryValues: true }
                    }

             ]

    }



