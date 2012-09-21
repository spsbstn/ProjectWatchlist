import QtQuick 1.0

Item {
    id:addScreen 
    Rectangle {
        id:addBackground
        opacity: 0.5;
        width: mainWindow.width;
        height: mainWindow.height;
        color:'black'
               }

    Rectangle {
        id:addScreenTile
        anchors.centerIn: addBackground
        height: parseInt(grid.height / 2)
        width: height*2
        opacity: 1;
        color:'#00aaff'


            Text {
              anchors.left: parent.left
              anchors.leftMargin: 20
              anchors.top: parent.top
              anchors.topMargin: parent.width/18
              color: "#ffffff"
              text: qsTr("Name der neuen Serie:")
              font.pixelSize: parent.width/18
              font.family: uiFont
                  }

            Rectangle {
                 anchors.bottom: parent.bottom
                 anchors.bottomMargin: parent.height/3
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
                text: qsTr("")
                focus:false
                font.pixelSize: height-(height/5)
                validator: RegExpValidator { regExp: /^(?!\s*$).+/ }
                onAccepted: controller.add(nameInput.text,addScreen.opacity=0)
                Keys.onEscapePressed: addScreen.opacity=0;
                       }
            }
            PlusButtonDark {
                 id:addButton
                 anchors.bottom: addScreenTile.bottom
                 anchors.bottomMargin: 10
                 anchors.right: addScreenTile.right
                 anchors.rightMargin: 10
                 onClicked: if(nameInput.text.match(/^(?!\s*$).+/)){
                                nameInput.accepted();
                                }
                 }
    }
    states: [ State {
                        when: addScreen.opacity==0
                        StateChangeScript { script:nameInput.text="" }
                    },
              State {
                        when: addScreen.opacity==1
                        PropertyChanges { target:nameInput; focus:true; restoreEntryValues: true }
                    }

             ]

    }



