#ifndef MAINVIEW_H
#define MAINVIEW_H

#include <QDeclarativeView>
#include <QSizeGrip>
#include <QMouseEvent>
#include "NcFramelessHelper.h"


class MainView : public QDeclarativeView
{
public:
    MainView();
    QSizeGrip* grip;
  //  QSizeGrip* grip2;
};

#endif // MAINVIEW_H
