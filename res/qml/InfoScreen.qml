import QtQuick 1.1
import "..///js/WatchNow.js" as WatchNowLink
import Cursors 1.0

Rectangle {

    //tvShow properties
    property double mainOpacity:0
    property string imageSource;
    property string showName;
    property string started;
    property string status;
    property string genre;
    property string airTime;
    property string network;
    property string latestEpisode;
    property string nextEpisode;

    id:mainInfoWindow
    anchors.top:parent.top
    anchors.topMargin: mainWindow.topBarSize
    anchors.horizontalCenter: parent.horizontalCenter
    opacity: mainOpacity
    color:"#00aaff"
    width:parent.width -90
    height:parent.height -100

    //check if there is a next Episode
    onOpacityChanged:if(nextEpisode==""){nextEpisodeText.text=""} else {nextEpisodeText.text="next Episode."}

        Item {

            id:topBar
            anchors.top: parent.top
            width:parent.width;
            height:parent.height*0.2

            Text {
                text:showName+"."
                font.family: mainWindow.uiFont
                font.pointSize: 60
                font.capitalization: Font.AllLowercase
                color: 'black'
                anchors.left:parent.left
                anchors.leftMargin: 60
                anchors.verticalCenter: parent.verticalCenter

            }

            }

        Item {

            id:imageArea
            anchors.top: topBar.bottom
            anchors.left:mainInfoWindow.left
            width:parent.width-infoArea.width-40
            height:parent.height*0.7


            LoadingCircle{
            id:imageLoadingCircle
            anchors.centerIn: parent
            visible:true;}

               Image {
                    id:image
                    smooth:true
                    visible: false;
                    fillMode: Image.PreserveAspectFit
                    anchors.centerIn: imageArea
                    anchors.fill: parent
                    anchors.margins: 20
                    source:imageSource
                    cache: false
                    onStatusChanged: if (image.status == Image.Ready)
                     {image.visible=true;
                      imageFrame.visible=true;
                      imageLoadingCircle.visible=false;}
                    z:1
                }

                Rectangle {
                    id:imageFrame
                    visible:false
                    color:"white"
                    smooth:true
                    height:image.paintedHeight+10
                    width:image.paintedWidth+10
                    anchors.centerIn: image
                }

            }

        Item {

            id:infoArea
            anchors.top: topBar.bottom
            anchors.right:parent.right
            width:parent.width/2;
            height:parent.height*(4/5)*(5/6)


            Item {

                id:row2
                height:45
                width:parent.width/2
                anchors.top:parent.top

                Text {

                    id:startedLabel
                    text:"Started."
                    horizontalAlignment: Text.AlignRight
                    font.family: mainWindow.uiFont
                    font.pointSize: 30
                    font.capitalization: Font.AllLowercase
                    color: 'black'
                    height:45
                    width:parent.width/2

                     }
                Text {

                    id:startedText
                    text:started
                    horizontalAlignment: Text.AlignLeft
                    font.family: mainWindow.uiFont
                    font.pointSize: 30
                    color: 'white'
                    height:45
                    width:parent.width/2
                    anchors.right:parent.right

                     }
                   }
            Item {

                id:row3
                height:45
                width:parent.width/2
                anchors.top:row2.bottom

                Text {

                    id:statusLabel
                    text:"Status."
                    horizontalAlignment: Text.AlignRight
                    font.family: mainWindow.uiFont
                    font.pointSize: 30
                    font.capitalization: Font.AllLowercase
                    color: 'black'
                    height:45
                    width:parent.width/2

                     }
                Text {

                    id:statusText
                    text:status
                    horizontalAlignment: Text.AlignLeft
                    font.family: mainWindow.uiFont
                    font.pointSize: 30
                    color: 'white'
                    height:45
                    width:parent.width/2
                    anchors.right:parent.right

                     }
                   }

            Item {

                id:row4
                height:45
                width:parent.width/2
                anchors.top:row3.bottom

                Text {

                    id:genreLabel
                    text:"Genre."
                    horizontalAlignment: Text.AlignRight
                    font.family: mainWindow.uiFont
                    font.pointSize: 30
                    font.capitalization: Font.AllLowercase
                    color: 'black'
                    height:45
                    width:parent.width/2

                       }
                Text {

                    id:genreText
                    text:genre
                    horizontalAlignment: Text.AlignLeft
                    font.family: mainWindow.uiFont
                    font.pointSize: 30
                    color: 'white'
                    height:paintedHeight
                    elide:Text.ElideRight
                    width:infoArea.width-genreLabel.width
                    anchors.left:genreLabel.right

                     }
                   }
            Item {

                id:row5
                height:45
                width:parent.width/2
                anchors.top:row4.bottom

                Text {

                    id:latestEpisodeText
                    text:"Latest Episode."
                    horizontalAlignment: Text.AlignRight
                    font.family: mainWindow.uiFont
                    font.pointSize: 30
                    font.capitalization: Font.AllLowercase
                    color: 'black'
                    height:45
                    width:parent.width/2

                       }
                Text {

                    id:latestEpisodeLabel
                    text:latestEpisode
                    horizontalAlignment: Text.AlignLeft
                    font.family: mainWindow.uiFont
                    font.pointSize: 30
                    color: 'white'
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    height:45
                    width:infoArea.width-latestEpisodeText.width-10
                    anchors.left:latestEpisodeText.right

                     }
                   }
            Item {

                id:row6
                height:45
                width:parent.width/2
                anchors.top:row5.bottom
                anchors.topMargin: row5.height

                Text {
                    id:nextEpisodeText
                    horizontalAlignment: Text.AlignRight
                    font.family: mainWindow.uiFont
                    font.pointSize: 30
                    font.capitalization: Font.AllLowercase
                    color: 'black'
                    height:45
                    width:parent.width/2

                       }
                Text {

                    id:nextEpisodeLabel
                    text:nextEpisode
                    horizontalAlignment: Text.AlignLeft
                    font.family: mainWindow.uiFont
                    font.pointSize: 30
                    color: 'white'
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    height:45
                    width:infoArea.width-nextEpisodeText.width-10
                    anchors.left:nextEpisodeText.right

                     }
                   }

            Item {

                id:watchNow
                width:parent.width
                height:80
                anchors.bottom: parent.bottom

                Item{

                    anchors.centerIn:parent
                    width:watchNowLabel.width+95
                    height:75

                    Text {

                        id:watchNowLabel
                        text:"watch now."
                        horizontalAlignment: Text.AlignCenter
                        font.family: mainWindow.uiFont
                        font.pointSize: 30
                        font.capitalization: Font.AllLowercase
                        color: 'black'
                        height:45

                         }

                    Button{

                        id: watchNowButton
                        buttonHeight: 75
                        buttonWidth: 75
                        anchors.left:watchNowLabel.right
                        anchors.bottom: watchNowLabel.bottom
                        anchors.leftMargin: 20
                        buttonNormal: "qrc:../..///img/watchnow.png"
                        buttonActive: "qrc:../..///img/watchnow_Active.png"
                        onClicked:Qt.openUrlExternally(WatchNowLink.getLink(showName));

                           }

                       }
                 }

            }

        Item {

            id:airTimeArea
            anchors.top: infoArea.bottom
            anchors.left:imageArea.right
            width:parent.width/3;
            height:parent.height*(4/5)*(1/6)

            Text {

                id:airDayText
                text:"Every " + airTime
                font.family: mainWindow.uiFont
                font.pointSize: 30
                color: 'white'
                anchors.bottom:timeAndNetwork.top
                anchors.left:timeAndNetwork.left
                anchors.leftMargin: -20
                z:3

                Rectangle {

                    color:"#828282"
                    z: -1
                    smooth:true
                    anchors.centerIn: parent
                    height:parent.height-5
                    width:parent.width+10


                }
            }

            Text {

                id:timeAndNetwork
                text:"on "+network
                font.family: mainWindow.uiFont
                font.pointSize: 30
                color: 'white'
                anchors.centerIn: parent
                z:4

                Rectangle {

                    color:"#828282"
                    z: -1
                    smooth:true
                    anchors.centerIn: parent
                    height:parent.height-5
                    width:parent.width+10

                }

            }
}
        Button {

            id:closeScreenButton
            anchors.top:parent.top
            anchors.topMargin: -11
            anchors.rightMargin: -11
            anchors.right:parent.right
            buttonHeight: 22
            buttonWidth: 22
            buttonNormal: "qrc:../..///img/closeScreenButton.png"
            onClicked:  {mainOpacity=0;
                imageSource="";
                image.visible=false;
                imageFrame.visible=false;
                imageLoadingCircle.visible=true;}

                }


        Text {

            id:wrongShow
            text:"Wrong show?"
            horizontalAlignment: Text.AlignLeft
            font.family: mainWindow.uiFont
            font.pointSize: 20
            color: 'white'
            height:45
            anchors.left:parent.left
            anchors.leftMargin: 20
            anchors.bottom: parent.bottom

            CursorShapeArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
              }
            MouseArea {

            anchors.fill: parent
            hoverEnabled:true
            onExited:  wrongShow.color="white"
            onEntered: wrongShow.color="#eeeeee"
            onClicked:wrongShowInfo.opacity=1;

             }
}

}


