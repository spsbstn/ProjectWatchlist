import QtQuick 2.0
42
import "internal"
43
44
Item {
45
    id: rootItem
46
    property variant source
47
    property real radius: 0.0
48
    property int samples: 0
49
    property real spread: 0.0
50
    property color color: "white"
51
    property bool fast: false
52
    property bool cached: false
53
    property bool transparentBorder: false
54
55
    Loader {
56
        anchors.fill: parent
57
        sourceComponent: rootItem.fast ? fastGlow : gaussianGlow
58
    }
59
60
    Component {
61
        id: gaussianGlow
62
        GaussianGlow {
63
            anchors.fill: parent
64
            source: sourceProxy.output
65
            radius: rootItem.radius
66
            maximumRadius: rootItem.samples * 0.5
67
            color: rootItem.color
68
            cached: rootItem.cached
69
            spread: rootItem.spread
70
            transparentBorder: rootItem.transparentBorder
71
        }
72
    }
73
74
    Component {
75
        id: fastGlow
76
        FastGlow {
77
            anchors.fill: parent
78
            source: sourceProxy.output
79
            blur: Math.pow(rootItem.radius / 64.0, 0.4)
80
            color: rootItem.color
81
            cached: rootItem.cached
82
            spread: rootItem.spread
83
            transparentBorder: rootItem.transparentBorder
84
        }
85
    }
86
87
    SourceProxy {
88
        id: sourceProxy
89
        input: rootItem.source
90
    }
91
    ShaderEffect {
92
        anchors.fill: parent
93
        property variant source: sourceProxy.output
94
    }
95
}
