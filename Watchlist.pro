SOURCES += src/main.cpp \
    src/tvshowdata.cpp \
    src/tvshow.cpp \
    src/controller.cpp \
    src/database.cpp \
    src/cursorshapearea.cpp \
    src/mainview.cpp \
    src/NcFramelessHelper.cpp

include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

RESOURCES += \
    res/res.qrc

HEADERS += \
    src/tvshowdata.h \
    src/tvshow.h \
    src/controller.h \
    src/database.h \
    src/cursorshapearea.h \
    src/mainview.h \
    src/NcFramelessHelper.h


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
    res/qml/MinusButtonDark.qml \
    res/qml/RightButton.qml \
    res/qml/LeftButton.qml \
    icons.rc \
    res/qml/CloseScreenButton.qml \
    res/qml/ShutdownButton.qml \
    res/js/Global.js \
    res/qml/RemoveScreen.qml \
    res/qml/ConfirmButton.qml \
    res/qml/AbortButton.qml

QT           += sql
QT += declarative

#Mac Icons
ICON = res/icons/icns/icon.icns
#Windows Icons
RC_FILE = icons.rc
