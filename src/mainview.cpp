#include "mainview.h"

MainView::MainView()
    : grip(new QSizeGrip(this))
{
}

void MainView::mousePressEvent(QMouseEvent *event)
{
    if (event->button() == Qt::LeftButton) {
        offset = event->globalPos() - frameGeometry().topLeft();
        event->accept();
    }
}

void MainView::mouseMoveEvent(QMouseEvent *event)
{
    if (event->buttons() & Qt::LeftButton) {
        move(event->globalPos() - offset);
        event->accept();
    }
}
