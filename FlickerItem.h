#ifndef FLICKERITEM_H
#define FLICKERITEM_H

#include <QtCore>
#include <QQuickItem>

class FlickerItem : public QQuickItem
{
    Q_OBJECT

private:
    QSGNode *updatePaintNode(QSGNode *oldNode, UpdatePaintNodeData *data);

private:
    uint pFramesCount;       //счетчик кадров
    uint pFramesPackageSize; //размер пакета кадров, в течении которого виден/скрыт стимул
    bool pRunning;

public:
    Q_PROPERTY(uint framesPackageSize READ framesPackageSize WRITE setFramesPackageSize)
    Q_PROPERTY(bool running READ isRunning WRITE setRunning)
    Q_PROPERTY(QString name READ name WRITE setName) // <- !!! для различения стимулов во время вывода в консоль !!!

    FlickerItem();
    ~FlickerItem();

public slots:
    uint framesPackageSize() const;
    void setFramesPackageSize(const uint &size);

    void start();
    void stop();

    bool isRunning() const;
    void setRunning(bool resume);

    QString name() const;
    void setName(const QString &name);

signals:
};

#endif // FLICKERITEM_H
