#ifndef TILE_H
#define TILE_H
#include <QtGui>
#include <QGraphicsWidget>


class tile : public QGraphicsWidget
{
    Q_OBJECT
    Q_PROPERTY(int yRotation READ rotation WRITE setRotation)

    /*
    * - line 10 is no part of the source http://labs.qt.nokia.com/2009/06/09/flippin-widgets-medium-rare-please/
    * - BUT: no Anmimation without "Q_PROPERTY(int yRotation READ rotation WRITE setRotation)"
    * - yRotation is NO Property of QGraphicsWidget
    * - yRotation is Property of QtGraphicsWidget http://doc.trolltech.com/solutions/4/qtanimationframework/qtgraphicswidget.html
    * - rotation around zAxis (?)
    * - widget doesn't flip
    */

public:
    tile(QGraphicsItem *parent = 0);
Q_SIGNALS:
    void flipRequest(); // private
protected:
    void resizeEvent(QGraphicsSceneResizeEvent *event);
private slots:
    void togglePage();
private:
    QStackedWidget *m_stack;
};
#endif // TILE_H
