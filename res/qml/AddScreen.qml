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
              text: qsTr("Name der neuen Serie:")
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
                onAccepted: controller.add(nameInput.text.toLowerCase(),addScreen.opacity=0)
                Keys.onEscapePressed: addScreen.opacity=0;
                       }

            }
            CloseScreenButton {
            anchors.top:parent.top
            anchors.topMargin: -15
            anchors.rightMargin: -17
            anchors.right:parent.right
            onClicked: addScreen.opacity=0}
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



