#include "mainview.h"
#include <QBoxLayout>

MainView::MainView()
    : grip1(new QSizeGrip(this)),
      grip2(new QSizeGrip(this)),
      grip3(new QSizeGrip(this)),
      grip4(new QSizeGrip(this)),
      mainLayout(new QBoxLayout(QBoxLayout::LeftToRight)),
      vLayout1(new QVBoxLayout()),
      vLayout2(new QVBoxLayout())
{
    // Puts the QSizeGrips in proper position
    vLayout1->addWidget(grip1, 0, Qt::AlignTop | Qt::AlignLeft);
    vLayout1->addWidget(grip4, 0, Qt::AlignBottom | Qt::AlignLeft);
    vLayout2->addWidget(grip2, 0, Qt::AlignTop | Qt::AlignRight);
    vLayout2->addWidget(grip3, 0, Qt::AlignBottom | Qt::AlignRight);

    mainLayout->addLayout(vLayout1);
    mainLayout->addLayout(vLayout2);
    setLayout(mainLayout);
}
