#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include "mainview.h"

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT
    
public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();
    MainView v;
    void init();
private slots:
    void on_actionAdd_triggered();

private:
    Ui::MainWindow *ui;

};

#endif // MAINWINDOW_H
