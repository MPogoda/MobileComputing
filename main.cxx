#include <QApplication>
#include "mainwindow.h"
#include <memory>

int main(int argc, char *argv[])
{
    QApplication a( argc, argv );
    std::unique_ptr< virtualBartender::MainWindow > w{ new virtualBartender::MainWindow{} };

    w->show();
    return a.exec();
}

//#include <QApplication>
//#include <QQmlApplicationEngine>

//int main(int argc, char *argv[])
//{
//    QApplication app(argc, argv);

//    QQmlApplicationEngine engine;
//    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

//    return app.exec();
//}
