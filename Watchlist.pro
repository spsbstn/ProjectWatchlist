SOURCES += src/main.cpp \
    src/tvshowdata.cpp \
    src/tvshow.cpp \
    src/testclass.cpp \
    src/controller.cpp

include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

RESOURCES += \
    res/res.qrc

HEADERS += \
    src/tvshowdata.h \
    src/tvshow.h \
    src/testclass.h \
    src/controller.h

OTHER_FILES += \
    qml/Watchlist/main.qml \
    res/qml/Scrollbar.qml \
    res/qml/main.qml \
    res/qml/FlipTile.qml
