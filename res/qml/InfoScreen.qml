import QtQuick 1.1
import "..///js/Global.js" as GlobalJS

Rectangle {

    property double mainOpacity:0

    function reloadModel() {

        xmlModel.source=("http://services.tvrage.com/feeds/full_search.php?show="+GlobalJS.activeSeries)
        xmlModel.reload();

    }


    id:mainInfoWindow
    width: mainWindow.width-100
    height: mainWindow.height-100
    anchors.centerIn: parent
    color:"#00aaff"
    opacity:mainOpacity

    XmlListModel {
        id: xmlModel
        query: "/Results/show[1]"

        XmlRole { name: "name"; query: "name/string()" }
        XmlRole { name: "showid"; query: "showid/string()" }
        XmlRole { name: "link"; query: "link/string()" }
        XmlRole { name: "country"; query: "country/string()" }
        XmlRole { name: "started"; query: "started/string()" }
        XmlRole { name: "ended"; query: "ended/string()" }
        XmlRole { name: "seasons"; query: "seasons/string()" }
        XmlRole { name: "status"; query: "status/string()" }
        XmlRole { name: "runtime"; query: "runtime/string()" }
        XmlRole { name: "genres"; query: "genres/genre[1]/string()"}
        XmlRole { name: "network"; query: "network/string()" }
        XmlRole { name: "airtime"; query: "airtime/string()" }
        XmlRole { name: "airday"; query: "airday/string()";}
        onStatusChanged: {
                if (status == XmlListModel.Ready)
                    imageModel.parsedId = get(0).showid;
                    imageModel.reload();}

    }

   Item{

       id:leftSide
       width:(mainInfoWindow.width/3)*2
       height:mainInfoWindow.height
       anchors.left:parent.left
       anchors.top:parent.top

    ListView {
       id:infoText
       height:parent.height
       width:parent.width
       model: xmlModel
       delegate:TextDelegate{}

          }
   }

   XmlListModel {

       property string parsedId:"";

       id: imageModel
       source: ("http://services.tvrage.com/feeds/full_show_info.php?sid="+parsedId)
       query: "/Show"

       XmlRole { name:"hans"; query: "image/string()" }
   }





  Item {
            id:rightSide
            width:parent.width-leftSide.width
            height:parent.height
            anchors.top:parent.top
            anchors.left:leftSide.right

  ListView {
            height:400
            width:parent.width
            anchors.top:parent.top
            anchors.topMargin: (parent.height-height)/2
            model: imageModel
            delegate:

        Image {
            id:image
            anchors.centerIn: parent

            source:hans
            width: rightSide.width-20
            height: sourceSize.height*(width/sourceSize.width)
            }
        }
        }



    }


