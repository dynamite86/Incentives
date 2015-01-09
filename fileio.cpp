#include "FileIO.h"

QString FileIO::source() const
{
    return mSource;
}

void FileIO::setSource(const QString &source)
{
    mSource = source;
}

FileIO::FileIO(QObject *parent) : QObject(parent){}
FileIO::~FileIO(){}

QString FileIO::read()
{
    if(mSource.isEmpty()){
        emit error("source is empty");
        return QString();
    }

    QFile file(mSource);
    QString fileContent;
    if(file.open(QIODevice::ReadOnly)){
        QString line;
        QTextStream t(&file);
        do{
            line = t.readLine();
            fileContent += line;
         }while(!line.isNull());

        file.close();
    }else{
        emit error("Unable to open the file");
        return QString();
    }
    return fileContent;
}

bool FileIO::write(const QString& data)
{
    if(mSource.isEmpty()){
        return false;
    }

    QFile file(mSource);
    if(!file.open(QFile::WriteOnly | QFile::Append)){
        return false;
    }

    QTextStream out(&file);
    out << data << endl;

    file.close();

    return true;
}
