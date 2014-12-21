#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

//    virtualBartender::FuzzyBartender bartender;

    QQmlApplicationEngine engine;
//    engine.rootContext()->setContextProperty( "bartender", &bartender );
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
