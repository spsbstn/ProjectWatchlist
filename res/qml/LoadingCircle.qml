import QtQuick 1.1

Item
{
    width: 40
    height: 40
    smooth: true
    property int radiusPoints: 4
    property string colorPoints: "#00aaff"
    property int spinningDuration:3000;

    Rectangle {
        width: radiusPoints
        smooth: true

        height: radiusPoints
        radius: 10
        color: colorPoints

        property real t;

        x: parent.width / 2 + parent.width / 3 * Math.sin(t * Math.PI * 2) - width / 2.;
        y: parent.height / 2 + parent.height / 3 * Math.cos(t * Math.PI * 2) - height / 2.;

    NumberAnimation on t { from: 0; to: 1; duration: spinningDuration; loops: Animation.Infinite }
    }
    Rectangle {
        width: radiusPoints
        smooth: true

        height: radiusPoints
        radius: 10
        color: colorPoints

        property real t

        x: parent.width / 2 + parent.width / 3 * Math.sin((t+0.1) * Math.PI * 2) - width / 2.;
        y: parent.height / 2 + parent.height / 3 * Math.cos((t+0.1) * Math.PI * 2) - height / 2.;

    NumberAnimation on t { from: 0; to: 1; duration: spinningDuration; loops: Animation.Infinite }
    }
    Rectangle {
        width: radiusPoints
        smooth: true

        height: radiusPoints
        radius: 10
        color: colorPoints

        property real t

        x: parent.width / 2 + parent.width / 3 * Math.sin((t+0.2) * Math.PI * 2) - width / 2.;
        y: parent.height / 2 + parent.height / 3 * Math.cos((t+0.2) * Math.PI * 2) - height / 2.;

    NumberAnimation on t { from: 0; to: 1; duration: spinningDuration; loops: Animation.Infinite }
    }
    Rectangle {
        width: radiusPoints
        smooth: true

        height: radiusPoints
        radius: 10
        color: colorPoints

        property real t

        x: parent.width / 2 + parent.width / 3 * Math.sin((t+0.3) * Math.PI * 2) - width / 2.;
        y: parent.height / 2 + parent.height / 3 * Math.cos((t+0.3) * Math.PI * 2) - height / 2.;

    NumberAnimation on t { from: 0; to: 1; duration: spinningDuration; loops: Animation.Infinite }
    }
    Rectangle {
        width: radiusPoints
        smooth: true

        height: radiusPoints
        radius: 10
        color: "black"

        property real t

        x: parent.width / 2 + parent.width / 3 * Math.sin((t+0.4) * Math.PI * 2) - width / 2.;
        y: parent.height / 2 + parent.height / 3 * Math.cos((t+0.4) * Math.PI * 2) - height / 2.;

    NumberAnimation on t { from: 0; to: 1; duration: spinningDuration; loops: Animation.Infinite }
    }
    Rectangle {
        width: radiusPoints
        smooth: true

        height: radiusPoints
        radius: 10
        color: colorPoints

        property real t

        x: parent.width / 2 + parent.width / 3 * Math.sin((t+0.5) * Math.PI * 2) - width / 2.;
        y: parent.height / 2 + parent.height / 3 * Math.cos((t+0.5) * Math.PI * 2) - height / 2.;

    NumberAnimation on t { from: 0; to: 1; duration: spinningDuration; loops: Animation.Infinite }
    }
    Rectangle {
        width: radiusPoints
        smooth: true

        height: radiusPoints
        radius: 10
        color: colorPoints

        property real t

        x: parent.width / 2 + parent.width / 3 * Math.sin((t+0.6) * Math.PI * 2) - width / 2.;
        y: parent.height / 2 + parent.height / 3 * Math.cos((t+0.6) * Math.PI * 2) - height / 2.;

    NumberAnimation on t { from: 0; to: 1; duration: spinningDuration; loops: Animation.Infinite }
    }
    Rectangle {
        width: radiusPoints
        smooth: true

        height: radiusPoints
        radius: 10
        color: colorPoints

        property real t

        x: parent.width / 2 + parent.width / 3 * Math.sin((t+0.7) * Math.PI * 2) - width / 2.;
        y: parent.height / 2 + parent.height / 3 * Math.cos((t+0.7) * Math.PI * 2) - height / 2.;

    NumberAnimation on t { from: 0; to: 1; duration: spinningDuration; loops: Animation.Infinite }
    }
    Rectangle {
        width: radiusPoints
        smooth: true

        height: radiusPoints
        radius: 10
        color: colorPoints

        property real t

        x: parent.width / 2 + parent.width / 3 * Math.sin((t+0.8) * Math.PI * 2) - width / 2.;
        y: parent.height / 2 + parent.height / 3 * Math.cos((t+0.8) * Math.PI * 2) - height / 2.;

   NumberAnimation on t { from: 0; to: 1; duration: spinningDuration; loops: Animation.Infinite }
    }
    Rectangle {
        width: radiusPoints
        smooth: true

        height: radiusPoints
        radius: 10
        color: colorPoints

        property real t

        x: parent.width / 2 + parent.width / 3 * Math.sin((t+0.9) * Math.PI * 2) - width / 2.;
        y: parent.height / 2 + parent.height / 3 * Math.cos((t+0.9) * Math.PI * 2) - height / 2.;

   NumberAnimation on t { from: 0; to: 1; duration: spinningDuration; loops: Animation.Infinite }
    }
}
