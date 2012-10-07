import QtQuick 1.1

Rectangle {

    property double mainOpacity:0

    id:mainInfoWindow
    width: mainWindow.width-100
    height: mainWindow.height-100
    anchors.centerIn: parent
    color:"#00aaff"
    opacity:mainOpacity

    Button {

        id:closeScreen
        anchors.top:parent.top
        anchors.topMargin: -11
        anchors.rightMargin: -11
        anchors.right:parent.right
        buttonHeight:22
        buttonWidth: 22
        buttonNormal: "qrc:../..///img/closeScreenButton.png"
        onClicked: mainOpacity=0
    }

    XmlListModel {
        id: xmlModel
        source: "http://services.tvrage.com/feeds/full_search.php?show=Breaking+Bad"
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
        XmlRole { name: "genres"; query: "genres/genre/string()"}
        XmlRole { name: "network"; query: "network/string()" }
        XmlRole { name: "airtime"; query: "airtime/string()" }
        XmlRole { name: "airday"; query: "airday/string()" }


    }

    ListView {
        width: 200; height: 200
        model: xmlModel
        delegate: Rectangle{
            color:"#00aaff"
            anchors.fill:parent
        Text {id:nameInfo
            text:name}
        Text {id:linkInfo
            anchors.top:nameInfo.bottom
            text:link}
        Text {id:countryInfo
            anchors.top:linkInfo.bottom
            text:country}
        Text {
            id:startedInfo
            anchors.top:countryInfo.bottom
            text:"Started: "+ started}
        Text {id:seasonsInfo
            anchors.top:startedInfo.bottom
            text:"Total Seasons: "+seasons}
        Text {
            id:statusInfo
            anchors.top:seasonsInfo.bottom
            text:"Status: "+ status}
        Text {
            id:runtimeInfo
            anchors.top:statusInfo.bottom
            text:"Runtime: "+ runtime +" min"}
        Text {
            id:genresInfo
            anchors.top:runtimeInfo.bottom
            text:"Genre: " + genres}
        Text {id:timeInfo
            anchors.top:genresInfo.bottom
            text:"Every " + airday +" " + airtime + " on " +network}

        Image {
            id:image
            anchors.top:timeInfo.bottom
            source: "http://images.tvrage.com/shows/19/18164.jpg"
            width: 300
            height: 300}
    }
    }
}
