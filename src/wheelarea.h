#ifndef WHEELAREA_H
#define WHEELAREA_H

#include <QDeclarativeItem>
#include <QGraphicsSceneWheelEvent>

class WheelArea : public QDeclarativeItem
{
    Q_OBJECT

protected:
    void wheelEvent(QGraphicsSceneWheelEvent *event) {
        switch(event->orientation())
        {
            case Qt::Horizontal:
                emit horizontalWheel(event->delta());
                break;
            case Qt::Vertical:
                emit verticalWheel(event->delta());
                break;
            default:
                event->ignore();
                break;
        }
    }

signals:
    void verticalWheel(int delta);
    void horizontalWheel(int delta);
};

#endif // WHEELAREA_H
