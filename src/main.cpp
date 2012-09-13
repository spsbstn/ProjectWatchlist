#include <QtGui/QApplication>
#include "mainwindow.h"

#include "testclass.h"

int main(int argc, char *argv[])
{

    // Test-Class for TvShow and TvShowData
    Testclass test;
    //

    QApplication a(argc, argv);
    MainWindow w;
    w.showMaximized();
    return a.exec();
}
