import QtQuick 1.0

Item {

    id:addScreen
    property int offset:5
    property bool apiErrorVisible: false;
    anchors.fill:parent

    NumberAnimation {id: showErrorPanelAnimation; target:errorPanel; property: "height"; to:40;   duration: 400}
    NumberAnimation {id: hideErrorPanelAnimation; target:errorPanel; property: "height"; to:0;   duration: 400}

    function showErrorPanel() {

        showErrorPanelAnimation.start();
    }

    function submit() {

        //remove errorPanel
        hideErrorPanelAnimation.start();

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
            showErrorPanelAnimation.start(showInDatabaseTxt.visible=true);
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

        Rectangle {

            id:errorPanel
            color:"white"
            anchors.top:addScreenTile.bottom
            anchors.horizontalCenter:addScreenTile.horizontalCenter
            height: 0
            width:addScreenTile.width-60

            Text {

                id:apiErrorTxt
                visible:apiErrorVisible
                anchors.centerIn: parent
                text:qsTr("Connection Error: \nShow doesn't exist or Internet Connection is down.")
                color:"black"
                font.pixelSize: 16
                font.family: mainWindow.uiFont
        }

        Text {

            id:showInDatabaseTxt
            visible:false;
            anchors.centerIn: parent
            text:qsTr("Show is already in Database")
            color:"black"
            font.pixelSize: 16
            font.family: mainWindow.uiFont
        }
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
