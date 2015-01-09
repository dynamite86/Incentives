#include "FlickerItem.h"

QSGNode *FlickerItem::updatePaintNode(QSGNode *oldNode, UpdatePaintNodeData *data)
{
    Q_UNUSED(oldNode);
    Q_UNUSED(data);

    if(pRunning){
        pFramesCount++;
        if(pFramesCount < pFramesPackageSize){
            if(!pVisible){
                setVisible(true);
                pVisible = true;
                qDebug() << QString(QTime::currentTime().toString("[hh:mm:ss:zzz] \'") + this->objectName() + "\' visible");
            }
        }else{
            pFramesCount = 0;
            if(pVisible){
                setVisible(false);
                pVisible = false;
                qDebug() << QString(QTime::currentTime().toString("[hh:mm:ss:zzz] \'") + this->objectName() + "\' invisible");
            }
        }
    }
    update();
    return NULL;
}

FlickerItem::FlickerItem()
{
    setFlag(ItemHasContents);
    pVisible           = false;
    pFramesCount       = 0;
    pFramesPackageSize = 0;
}

FlickerItem::~FlickerItem(){}

uint FlickerItem::framesPackageSize() const
{
    return pFramesPackageSize;
}

void FlickerItem::setFramesPackageSize(const uint &size)
{
    pFramesPackageSize = size;
}

void FlickerItem::start()
{
    pRunning = true;
    qDebug() << QString(QTime::currentTime().toString("!!! [hh:mm:ss:zzz] ") + "Flicker was started at intervals of %1 frames").arg(pFramesPackageSize);
}

void FlickerItem::stop()
{
    pRunning = false;
    qDebug() << QString(QTime::currentTime().toString("!!! [hh:mm:ss:zzz] ") + "Flicker was stopped");
    pFramesCount = 0;
    pVisible = true;
}

bool FlickerItem::isRunning() const
{
    return pRunning;
}

void FlickerItem::setRunning(bool resume)
{
    pRunning = resume;
}

QString FlickerItem::name() const
{
    return this->objectName();
}

void FlickerItem::setName(const QString &name)
{
    if(name != this->objectName()){
        this->setObjectName(name);
    }
}
