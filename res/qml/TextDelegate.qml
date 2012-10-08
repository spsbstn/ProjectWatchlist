// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Item{
    property int parsedShowId: showid;
id:xmlDelegate
     anchors.fill:parent
     Text {id:nameInfo
           anchors.top:parent.top
           anchors.topMargin: 150
           font.family: "Helvetica-Neue"
           anchors.horizontalCenter: parent.horizontalCenter
           font {
                 capitalization: Font.AllUppercase;
                 pointSize: 50;
                 weight:Font.Light
                  }
           color:'white'
           text:name
     }

Text {id:countryInfo
 anchors.topMargin: 20
 font.family: "Helvetica-Neue"
 anchors.horizontalCenter: parent.horizontalCenter
 font {
       capitalization: Font.AllUppercase;
       pointSize: 20;
       weight:Font.Light
        }
 color:'white'
 anchors.top:nameInfo.bottom
 text:country}
Text {
 id:startedInfo
 anchors.topMargin: 20
 font.family: "Helvetica-Neue"
 anchors.horizontalCenter: parent.horizontalCenter
 font {
       capitalization: Font.AllUppercase;
       pointSize: 20;
       weight:Font.Light
        }
 color:'white'
 anchors.top:countryInfo.bottom
 text:"Started: "+ started}
Text {id:seasonsInfo
 anchors.top:startedInfo.bottom
 anchors.topMargin: 20
 font.family: "Helvetica-Neue"
 anchors.horizontalCenter: parent.horizontalCenter
 font {
       capitalization: Font.AllUppercase;
       pointSize: 20;
       weight:Font.Light
        }
 color:'white'
 text:"Total Seasons: "+seasons}
Text {
 id:statusInfo
 anchors.top:seasonsInfo.bottom
 anchors.topMargin: 20
 font.family: "Helvetica-Neue"
 anchors.horizontalCenter: parent.horizontalCenter
 font {
       capitalization: Font.AllUppercase;
       pointSize: 20;
       weight:Font.Light
        }
 color:'white'
 text:"Status: "+ status}
Text {
 id:runtimeInfo
 anchors.top:statusInfo.bottom
 anchors.topMargin: 20
 font.family: "Helvetica-Neue"
 anchors.horizontalCenter: parent.horizontalCenter
 font {
       capitalization: Font.AllUppercase;
       pointSize: 20;
       weight:Font.Light
        }
 color:'white'
 text:"Runtime: "+ runtime +" min"}
Text {
 id:genresInfo
 anchors.top:runtimeInfo.bottom
 anchors.topMargin: 20
 font.family: "Helvetica-Neue"
 anchors.horizontalCenter: parent.horizontalCenter
 font {
       capitalization: Font.AllUppercase;
       pointSize: 20;
       weight:Font.Light
        }
 color:'white'
 text:"Genre: " + genres}
Text {id:timeInfo
 anchors.top:genresInfo.bottom
 anchors.topMargin: 20
 font.family: "Helvetica-Neue"
 anchors.horizontalCenter: parent.horizontalCenter
 font {
       capitalization: Font.AllUppercase;
       pointSize: 20;
       weight:Font.Light
        }
 color:'white'
 text:"Every " + airday +" " + airtime + " on " +network}

}

