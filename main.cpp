#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
//#include "FileIO.h"
#include "FlickerItem.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

//    FileIO fileIO;
//    qmlRegisterType<FileIO, 1>("FileIO", 1, 0, "FileIO");
//    engine.rootContext()->setContextProperty("FileIO", &fileIO);

    FlickerItem flickerItem;
    qmlRegisterType<FlickerItem, 1>("FlickerItem", 1, 0, "FlickerItem");
    engine.rootContext()->setContextProperty("FlickerItem", &flickerItem);

    engine.load(QUrl(QStringLiteral("./qml/main.qml")));
    return app.exec();
}
