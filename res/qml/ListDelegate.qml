// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Item {

    anchors.horizontalCenter: parent.horizontalCenter
    width:seriesName.width + nextEpisodeColumn.width + 40

    Text {
        id: seriesName
        color: mainWindow.textColor
        text: "  "+title
        smooth:true
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        font {
                family:mainWindow.uiFont
                capitalization: Font.AllUppercase;
                pointSize: mainWindow.tileHeaderFontSize;
        }

        Rectangle{

            height:parent.height+10
            width:parent.width+20
            anchors.centerIn: parent
            z:-1
            color:if(index%2==0) {mainWindow.tileBackground} else {"white"}
        }
    }

    Text {

        id: nextEpisodeColumn
        color: mainWindow.textColor
        text: if(!nextEpisode==""){nextEpisode} else {"Show or Season ended."}
        smooth:true
        anchors.left:seriesName.right
        anchors.leftMargin: 30
        anchors.bottom: seriesName.bottom
        horizontalAlignment: Text.AlignHCenter
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        font {

            family:mainWindow.uiFont
            capitalization: Font.AllUppercase;
            pointSize: mainWindow.tileHeaderFontSize;
        }

        Rectangle{

            height:parent.height+10
            width:parent.width+20
            anchors.centerIn: parent
            z:-1
            color:if(index%2==0) {mainWindow.tileBackground} else {"white"}
        }
    }
}

