#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include "fileio.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    qmlRegisterType<FileIO, 1>("FileIO", 1, 0, "FileIO");
    FileIO fileIO;
    engine.rootContext()->setContextProperty("fileio", &fileIO);
    engine.load(QUrl(QStringLiteral("./qml/main.qml")));
    return app.exec();
}
