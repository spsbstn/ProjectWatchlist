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
        color:"#00aaff"
            Text {
              anchors.left: parent.left
              anchors.leftMargin: 20
              anchors.top: parent.top
              anchors.topMargin: parent.width/30
              color: "#ffffff"
              text: qsTr(" + New TvShow")
              font.pixelSize: parent.width/10
              font.family: uiFont
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
                                    controller.add(nameInput.text.toLowerCase(),genreInput.text.toLocaleLowerCase(),addScreen.opacity=0,removeClickProtection.start())
                            }
                Keys.onEscapePressed: {addScreen.opacity=0;
                    removeClickProtection.start();}
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
                                removeClickProtection.start();
                                controller.add(nameInput.text.toLowerCase(),genreInput.text.toLocaleLowerCase(),addScreen.opacity=0,removeClickProtection.start())
                            }
                Keys.onEscapePressed: {addScreen.opacity=0;
                    removeClickProtection.start();}
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
            Button {
            id:closeScreen
            anchors.top:parent.top
            anchors.topMargin: -11
            anchors.rightMargin: -11
            anchors.right:parent.right
            buttonHeight:22
            buttonWidth: 22
            buttonNormal: "qrc:../..///img/closeScreenButton.png"
            onClicked: {addScreen.opacity=0
                removeClickProtection.start();}}
            Button {
                 id:addButton
                 buttonHeight:16
                 buttonWidth:16
                 buttonNormal: "qrc:../..///img/addIcon_Dark.png"
                 buttonActive: "qrc:../..///img/addIcon_Active_Dark.png"
                 anchors.bottom: addScreenTile.bottom
                 anchors.bottomMargin: 15
                 anchors.right: addScreenTile.right
                 anchors.rightMargin: 15
                 onClicked: if(nameInput.text != "Name" && nameInput.text != "" &&
                                    genreInput.text != "Genre" && genreInput.text != ""){
                                  nameInput.accepted();
                                removeClickProtection.start();
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



