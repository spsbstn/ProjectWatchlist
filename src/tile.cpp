#include "tile.h"

tile::tile(QGraphicsItem *parent)
    : QGraphicsWidget(parent)
{
    // widgetfront
    QWidget *front = new QWidget();
    QPushButton *toBackButton = new QPushButton("To Back");
    QObject::connect(toBackButton, SIGNAL(clicked()), this, SIGNAL(flipRequest()));
    toBackButton->setStyleSheet("background: pink");
    {
        QVBoxLayout *vbox = new QVBoxLayout(front);
        vbox->addWidget(toBackButton);
    }

    // widgetBack
    QWidget *back = new QWidget();
    QPushButton *toFrontButton = new QPushButton("To Front");
    QObject::connect(toFrontButton, SIGNAL(clicked()), this, SIGNAL(flipRequest()));
    toFrontButton->setStyleSheet("background: yellow");
    {
        QVBoxLayout *vbox = new QVBoxLayout(back);
        vbox->addWidget(toFrontButton);
    }

    // The stacked widget.
    m_stack = new QStackedWidget();
    m_stack->addWidget(front);
    m_stack->addWidget(back);

    QGraphicsProxyWidget *stackProxy = new QGraphicsProxyWidget();
    stackProxy->setWidget(m_stack);
    QGraphicsLinearLayout *vbox = new QGraphicsLinearLayout(this);
    vbox->addItem(stackProxy);

    // Animations
    QStateMachine *machine = new QStateMachine(this);
    QState *s0 = new QState(machine); // machine->rootState() is deprecated
    s0->assignProperty(this, "yRotation", 0);

    QState *s1 = new QState(machine);
    s1->assignProperty(this, "yRotation", 90);

    QAbstractTransition *t1 = s0->addTransition(this, SIGNAL(flipRequest()), s1);
    QPropertyAnimation *yRotationAnim = new QPropertyAnimation(this, "yRotation");
    yRotationAnim->setDuration(250);
    t1->addAnimation(yRotationAnim);

    QState *s2 = new QState(machine);
    QObject::connect(s2, SIGNAL(entered()), this, SLOT(togglePage()));
    s2->assignProperty(this, "yRotation", -90);
    s1->addTransition(s1, SIGNAL(finished()), s2);

    QAbstractTransition *t2 = s2->addTransition(s0);
    t2->addAnimation(yRotationAnim);

    machine->setInitialState(s0);
    machine->start();
}

void tile::togglePage()
{
    m_stack->setCurrentIndex(m_stack->currentIndex() ^ 1);
}

void tile::resizeEvent(QGraphicsSceneResizeEvent *event)
{
    QSizeF siz = event->newSize();
    QPointF pt = QPointF(siz.width() / 2, siz.height() / 2);
    setTransformOriginPoint(pt); // old version deprecated
}
