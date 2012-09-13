QT       += core gui

TARGET = Watchlist
TEMPLATE = app


SOURCES += src/main.cpp\
        src/mainwindow.cpp \
    src/tvshow.cpp \
    src/tvshowdata.cpp \
    src/mainview.cpp

HEADERS  += src/mainwindow.h \
    src/tvshow.h \
    src/tvshowdata.h \
    src/mainview.h

FORMS    += src/mainwindow.ui

RESOURCES += \
    res/res.qrc
