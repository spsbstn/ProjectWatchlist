import QtQuick 1.0

Item {

    id:addScreen
    property int offset:5
    property bool apiErrorVisible: false;
    anchors.fill:parent

    function submit() {

        //Check if show is in Database
        var showIsInDB = (controller.find(nameInput.text.toLowerCase()) !== -1);

        if(nameInput.text != "Name" && nameInput.text != "" && !showIsInDB) {

                    controller.add(nameInput.text.toLowerCase());
                    nameInput.enabled=false;
                    nameInput.color="grey";
                    addCircle.visible=true;
                    showInDatabaseTxt.visible=false;
                    apiErrorVisible=false;

           }
        else if(showIsInDB) //display showInDatabaseTxt and activate input
        {
            apiErrorVisible=false;
            showInDatabaseTxt.visible=true;
            nameInput.enabled=false;
            activateInput();
        }

    }

    function activateInput() {
        nameInput.enabled=true;
        nameInput.color="black";
        addCircle.visible=false;
        nameInput.focus=true;}

    // returns User Input for series name
    function getTxt(){
        return nameInput.text;
    }

    Rectangle {

        id:addScreenTile
        anchors.centerIn: addScreen
        height: parseInt(grid.height / 4.5)
        width: height*3
        opacity: 1;
        color:mainWindow.tileBackground

        Text {
              id:newShowTxt
              anchors.left: parent.left
              anchors.leftMargin: 20
              anchors.top: parent.top
              anchors.topMargin: parent.width/30
              color: "#ffffff"
              text: qsTr(" + New TvShow")
              font.pixelSize: parent.width/15
              font.family: uiFont

                  }


        Text {
            x: 95
            y: 0
            id:apiErrorTxt
            visible:apiErrorVisible

            text:qsTr("Connection Error: Show doesnt exist or Internet Connection is down.")
            color:"red"
            font.pixelSize: 16
            font.family: mainWindow.uiFont
        }

        Text {
            x: 95
            y: 0
            id:showInDatabaseTxt
            visible:false;

            text:qsTr("Show is already in Database")
            color:"red"
            font.pixelSize: 16
            font.family: mainWindow.uiFont
        }



            Rectangle {

                 anchors.bottom: parent.bottom
                 anchors.bottomMargin: parent.height/3
                 anchors.left: parent.left
                 anchors.leftMargin: (parent.width-width)/2
                 width: parent.width-50
                 height: parent.width/11
                 color: "#ffffff"

            LoadingCircle
            {
                id:addCircle
                anchors.right: parent.right
                anchors.bottom:parent.bottom
                circleDiameter: parent.height
                radiusPoints: 3
                visible: false;
                colorPoints: mainWindow.tileBackground
            }

            TextInput {

                id: nameInput
                anchors.left:parent.left
                anchors.leftMargin: 10;
                anchors.centerIn: parent
                width: parent.width-20
                height: parent.height-10
                focus:false
                onActiveFocusChanged: if (activeFocus == true) selectAll()
                text: qsTr("Name")
                font.pixelSize: height-(height/5)
                onAccepted: submit();
                Keys.onEscapePressed: {addScreen.opacity=0;removeClickProtection.start();}

                MouseArea {

                    anchors.fill: parent
                    onClicked: {nameInput.focus=true;
                            }
                        }
                   }
              }


            Button {

                id:closeButton
                anchors.top:parent.top
                anchors.topMargin: -11
                anchors.rightMargin: -11
                anchors.right:parent.right
                buttonHeight:22
                buttonWidth: 22
                buttonNormal: "qrc:../..///img/closeScreenButton.png"
                onClicked: {addScreen.opacity=0;removeClickProtection.start();}

            }

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
                 onClicked:submit();

             }

            states: [ State {

                        when: addScreen.opacity==0
                        StateChangeScript { script:nameInput.text="Name" }
                        PropertyChanges { target:mainWindow; focus:true; }

                    },

                       State {

                        when: addScreen.opacity==1
                        PropertyChanges { target:nameInput; focus:true; restoreEntryValues: true }
                    }

             ]
    }

}
