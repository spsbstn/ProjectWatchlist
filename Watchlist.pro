SOURCES += src/main.cpp \
    src/tvshowdata.cpp \
    src/tvshow.cpp \
    src/controller.cpp \
    src/database.cpp \
    src/cursorshapearea.cpp \
    libs/NcFramelessHelper.cpp \
    src/xmlpictureloader.cpp \
    src/quickinfo.cpp \
    src/logger.cpp \
    src/uicontroller.cpp

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
    src/xmlpictureloader.h \
    src/quickinfo.h \
    src/wheelarea.h \
    src/logger.h \
    src/uicontroller.h


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
    res/fonts/Helvetica Neue UltraLight.ttf \
    res/qml/LoadingCircle.qml \
    res/js/WatchNow.js \
    res/js/CheckForNewEpisodes.js

TARGET = Watchlist
VERSION = 2.1.1
TEMPLATE = app

DEFINES += APP_VERSION=\\\"$$VERSION\\\"

QT += sql
QT += xml
QT += declarative
QT += network

# Fervor autoupdater
!include("libs/fervor/Fervor.pri") {
    error("Unable to include Fervor autoupdater.")
}

#Mac Icons
ICON = res/icons/icns/icon.icns
#Windows Icons
RC_FILE = icons.rc
