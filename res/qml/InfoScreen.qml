import QtQuick 1.1
import "..///js/WatchNow.js" as WatchNowLink

Rectangle {

    //tvShow properties
    property double mainOpacity:0
    property string imageSource;
    property string showName;
    property string totalSeasons;
    property string started;
    property string status;
    property string genre;
    property string airDay;
    property string airTime;
    property string network;

    FontLoader {
             id: helveticaNeueUltraLight
             source: "qrc:../..///fonts/Helvetica Neue UltraLight.ttf"
    }

    id:mainInfoWindow
    anchors.centerIn: parent;
    opacity: mainOpacity
    color:"#00aaff"
    width:parent.width-100
    height:parent.height-100



        Item {

            id:topBar
            anchors.top: parent.top
            width:parent.width;
            height:parent.height*0.2

            Text {
                text:showName
                font.family: helveticaNeueUltraLight.name
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
            anchors.left:parent.left
            width:parent.width/2;
            height:parent.height*0.7

            LoadingCircle{
            id:imageLoadingCircle
            anchors.centerIn: parent
            visible:true;}

               Image {
                    property double imageRatio: sourceSize.width/sourceSize.height
                    property double frameRatio: imageArea.width/imageArea.height
                    id:image
                    smooth:true
                    visible: false;
                    anchors.centerIn: parent
                    source:imageSource
                    cache: false
                    width: imageRatio > frameRatio ? imageArea.width*0.8 : sourceSize.width/(sourceSize.height/height)
                    height:imageRatio > frameRatio ? sourceSize.height/(sourceSize.width/width) : imageArea.height*0.8
                    transform: Rotation { origin.x: height/2; origin.y: width/2; angle: 5}
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
                    anchors.centerIn: image
                    height:image.height+10
                    width:image.width+10
                    transform: Rotation { origin.x: height/2; origin.y: width/2; angle: 5}

                }

            }

        Item {

            id:infoArea
            anchors.top: topBar.bottom
            anchors.left:imageArea.right
            width:parent.width/2;
            height:parent.height*(4/5)*(2/3)

            Item {

                id:row1
                height:45
                width:parent.width
                anchors.top:parent.top

                Text {

                    id:totalSeasonsLabel
                    text:"Total Seasons."
                    horizontalAlignment: Text.AlignRight
                    font.family: helveticaNeueUltraLight.name
                    font.pointSize: 30
                    font.capitalization: Font.AllLowercase
                    color: 'black'
                    height:45
                    width:parent.width/2

                     }
                Text {

                    id:totalSeasonsText
                    text:totalSeasons
                    horizontalAlignment: Text.AlignLeft
                    font.family: helveticaNeueUltraLight.name
                    font.pointSize: 30
                    color: 'white'
                    height:45
                    width:parent.width/2
                    anchors.right:parent.right

                     }
                }

            Item {

                id:row2
                height:45
                width:parent.width
                anchors.top:row1.bottom

                Text {

                    id:startedLabel
                    text:"Started."
                    horizontalAlignment: Text.AlignRight
                    font.family: helveticaNeueUltraLight.name
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
                    font.family: helveticaNeueUltraLight.name
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
                width:parent.width
                anchors.top:row2.bottom

                Text {

                    id:statusLabel
                    text:"Status."
                    horizontalAlignment: Text.AlignRight
                    font.family: helveticaNeueUltraLight.name
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
                    font.family: helveticaNeueUltraLight.name
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
                width:parent.width
                anchors.top:row3.bottom

                Text {

                    id:genreLabel
                    text:"Genre."
                    horizontalAlignment: Text.AlignRight
                    font.family: helveticaNeueUltraLight.name
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
                    font.family: helveticaNeueUltraLight.name
                    font.pointSize: 30
                    color: 'white'
                    height:45
                    width:parent.width/2
                    anchors.right:parent.right

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
                        font.family: helveticaNeueUltraLight.name
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
            width:parent.width/2;
            height:parent.height*(4/5)*(1/3)

            Text {

                id:airDayText
                text:"Every " + airDay
                font.family: helveticaNeueUltraLight.name
                font.pointSize: 30
                color: 'white'
                anchors.bottom:timeAndNetwork.top
                anchors.left:timeAndNetwork.left
                anchors.leftMargin: -40
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
                text:airTime+" on "+network
                font.family: helveticaNeueUltraLight.name
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


}


