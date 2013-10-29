import QtQuick 1.1

Image {
    property int rot: 0;
    property bool spinning: true;
    id: circle;
    smooth: true
    source:"../..///img/"+mainWindow.colorScheme+"/syncIndicator.png";
    width: 12
    height: 12
    rotation: rot

    NumberAnimation on rot  { id:spinning; from: 0; to: 359; duration: 2000; loops: Animation.Infinite }

    states: [ State {

            name: "spinning"
            StateChangeScript{script: spinning.start();}
            when: circle.spinning

         },

        State {

                    name: "static"
                    StateChangeScript{script:spinning.stop();}
                    when: !circle.spinning
        }
    ]

}
