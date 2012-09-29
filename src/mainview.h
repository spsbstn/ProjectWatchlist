#ifndef MAINVIEW_H
#define MAINVIEW_H

#include <QDeclarativeView>
#include <QSizeGrip>
#include <QMouseEvent>


class MainView : public QDeclarativeView
{
public:
    MainView();
    QSizeGrip grip;

    void mousePressEvent(QMouseEvent *event);
    void mouseMoveEvent(QMouseEvent *event);

private:
    QPoint offset;
    bool validCursorPos(QMouseEvent *event);
};

#endif // MAINVIEW_H
