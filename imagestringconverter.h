#ifndef IMAGESTRINGCONVERTER_H
#define IMAGESTRINGCONVERTER_H

#include <QObject>
#include <QFile>
#include <QDebug>
#include <QByteArray>
#include <QStandardPaths>
#include <QDir>
#include <QString>

class ImageStringConverter : public QObject
{
    Q_OBJECT

public:
    ImageStringConverter(QObject *parent = 0):QObject(parent){}
    Q_INVOKABLE QString convertImageToBase64String(QString imagePath){
        QFile* file = new QFile(imagePath);
        file->open(QIODevice::ReadOnly);
        QByteArray image = file->readAll();
        int originalSize = image.length();
        qDebug()<<"originalSize"<<originalSize;
        QString encoded = QString(image.toBase64());
        int encodedSize = encoded.size();
        qDebug()<<"encodedSize"<<encodedSize;
        return encoded;
    }
};
#endif //IMAGESTRINGCONVERTER_H
