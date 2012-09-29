#include "mainview.h"

MainView::MainView()
    : grip(new QSizeGrip(this))
{
}

void MainView::mouseDoubleClickEvent(QMouseEvent *event)
{
    if ((event->button() == Qt::LeftButton) && validCursorPos(event)) {
        offset = event->globalPos() - frameGeometry().topLeft();
        event->accept();
    }
}

void MainView::mouseMoveEvent(QMouseEvent *event)
{
    if ((event->buttons() & Qt::LeftButton) && validCursorPos(event)) {
        move(event->globalPos() - offset);
        event->accept();
    }
}


// restrict drag-area
bool MainView::validCursorPos(QMouseEvent *event)
{
    return event->pos().y() - frameGeometry().topLeft().y() <= 100;
}

