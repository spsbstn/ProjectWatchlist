SOURCES += src/main.cpp \
    src/tvshowdata.cpp \
    src/tvshow.cpp \
    src/controller.cpp \
    src/database.cpp

include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

RESOURCES += \
    res/res.qrc

HEADERS += \
    src/tvshowdata.h \
    src/tvshow.h \
    src/controller.h \
    src/database.h

OTHER_FILES += \
    qml/Watchlist/main.qml \
    res/qml/Scrollbar.qml \
    res/qml/main.qml \
    res/qml/FlipTile.qml \
    res/qml/AddScreen.qml \
    res/qml/SplashScreen.qml \
    res/qml/PlusButtonLight.qml \
    res/qml/PlusButtonDark.qml \
    res/qml/MinusButtonDark .qml \
    res/qml/MinusButtonDark .qml \
    res/qml/MinusButtonDark.qml
 QT           += sql
