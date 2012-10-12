SOURCES += src/main.cpp \
    src/tvshowdata.cpp \
    src/tvshow.cpp \
    src/controller.cpp \
    src/database.cpp \
    src/cursorshapearea.cpp \
    libs/NcFramelessHelper.cpp \
    src/xmlhelper.cpp

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
    libs/NcFramelessHelper.h \
    src/xmlhelper.h


OTHER_FILES += \
    qml/Watchlist/main.qml \
    res/qml/Scrollbar.qml \
    res/qml/main.qml \
    res/qml/FlipTile.qml \
    res/qml/AddScreen.qml \
    res/qml/SplashScreen.qml \
    res/qml/MinusButtonDark .qml \
    res/qml/MinusButtonDark .qml \
    icons.rc \
    res/js/Global.js \
    res/qml/RemoveScreen.qml \
    res/qml/TopBar.qml \
    res/qml/RemovePanel.qml \
    res/qml/ToolTip.qml \
    imdb.js \
    res/qml/Button.qml \
    res/qml/InfoScreen.qml \
    res/fonts/Helvetica Neue UltraLight.ttf

QT += sql
QT += declarative

#Mac Icons
ICON = res/icons/icns/icon.icns
#Windows Icons
RC_FILE = icons.rc
