/***********************************************
Запись в файл из QML
Сперто из http://developer.nokia.com/community/wiki/Reading_and_writing_files_in_QML

Авторы:
 * Created: gnuton (29 Nov 2011)
 * Last edited: stupid_nokia (26 Dec 2012)
***********************************************/
#ifndef FILEIO_H
#define FILEIO_H

#include <QtCore>

class FileIO : public QObject
{
    Q_OBJECT

private:
    QString mSource;

public:
    Q_PROPERTY(QString source READ source WRITE setSource NOTIFY sourceChanged)

    explicit FileIO(QObject *parent = 0);
    ~FileIO();

    Q_INVOKABLE QString read();
    Q_INVOKABLE bool write(const QString& data);

    QString source() const;

public slots:
    void setSource(const QString &source);

signals:
    void sourceChanged(const QString& source);
    void error(const QString& msg);

};

#endif // FILEIO_H
