#include "filedownloader.h"
#include <QStandardPaths>
#include "AppInfo.h"
#include <QFile>
#include <QDir>
#include <QSqlError>
#include <stdio.h>


FileDownloader::FileDownloader( QObject *parent) :QObject(parent)
{
    connect(&m_WebCtrl, SIGNAL (finished(QNetworkReply*)),
            this, SLOT (fileDownloaded(QNetworkReply*))
            );
}
void FileDownloader::fileDownload(){
    qDebug()<<"m_fileUrl"<<m_fileUrl;
    QNetworkRequest request(m_fileUrl);
    timerElapsed.start();
    reply= m_WebCtrl.get(request);
    QNetworkAccessManager* networkManager = new QNetworkAccessManager();


    request.setAttribute(QNetworkRequest::HttpPipeliningAllowedAttribute, true);
    request.setRawHeader("Range", "bytes=0-499");


    QVariant responseLength = request.header(QNetworkRequest::ContentLengthHeader);
    int fileSize = responseLength.toInt();
    qDebug()<<"File Size "<<fileSize;
    connect(reply, SIGNAL(error(QNetworkReply::NetworkError)),
            SLOT(onError(QNetworkReply::NetworkError)), Qt::QueuedConnection);
    connect(reply, SIGNAL(downloadProgress(qint64,qint64)),SLOT(downloadProgress(qint64,qint64)));

}

void FileDownloader::getHeaders(QNetworkReply * reply){
    if (reply->operation() == QNetworkAccessManager::HeadOperation){
        int content_length = reply->header(QNetworkRequest::ContentLengthHeader).toInt();
        qDebug()<<"getHeaders content_length "<<content_length;
    }
}


FileDownloader::~FileDownloader() { 
qDebug();
}

void FileDownloader::fileDownloaded(QNetworkReply* pReply) {
    qDebug()<<"m_fileUrl<<m_fileUrl;"+m_filePath;
    m_DownloadedData = pReply->readAll();
    m_filePath="C:/Users/cyilmaz/ArcGIS";
    downloadReply=pReply;
    QString directoryPathDatabase=m_filePath+"/Databases";

    if(!QDir(directoryPathDatabase).exists()){
        QDir().mkpath(directoryPathDatabase);
    }

    newdb= QString(QCryptographicHash::hash(("newdb"),QCryptographicHash::Md5).toHex());


    QFile file(directoryPathDatabase+"/uavtDb.zip");

    if(!file.open(QIODevice::ReadWrite))
    {
        qDebug() << " could not open uavtdatabase file for reading and writing";
    }else{
        file.write(m_DownloadedData);
        file.close();
    }


    pReply->deleteLater();

    emit downloaded();
}

void FileDownloader::processDbFile(){
    //m_DownloadedData = downloadReply->readAll();
    QString directoryPathDatabase=m_filePath+"/Databases/";

    if(!QDir(directoryPathDatabase).exists()){
        QDir().mkpath(directoryPathDatabase);
    }

    newdb= QString(QCryptographicHash::hash(("uavtDB"),QCryptographicHash::Md5).toHex());

    QFile file(directoryPathDatabase+"uavtDB.db");
    QFile fileIni(directoryPathDatabase+newdb+".ini");


    if(!file.open(QIODevice::ReadWrite))
    {
        qDebug() << " could not open uavtdatabase file for reading and writing";
    }else{

        // qDebug()<<info.absoluteFilePath()<<"newdb.db";
        file.close();
        //        qDebug() << file.rename("uavtDB","newdb");
    }
    file.rename(directoryPathDatabase+"/"+newdb+".db");

    if(!fileIni.open(QIODevice::ReadWrite))
    {
        qDebug() << " could not open uavtdatabase file for reading and writing";
    }else{

        fileIni.write("[General]\rName=uavtDB\rVersion=1.0\rDescription=newdb\rEstimatedSize=1000000\rDriver=QSQLITE");
        fileIni.close();
    }

    // fileIni.rename(directoryPathDatabase+"/taner.ini");
    // QFile fileZip(directoryPathDatabase+"uavtDb.zip");
    //   qDebug()<< "Open result"<< fileZip.open(QIODevice::ReadWrite);

    //qDebug()<<fileZip.remove();
    //    QDir *rmDir = new QDir(directoryPathDatabase);//+"uavtDb.zip"
    //    qDebug()<<rmDir->path();
    //    rmDir->remove("uavtDb.db");//"uavtDb.zip");

    downloadReply->deleteLater();
    emit fileProcessEnded();
}

//QByteArray FileDownloader::downloadedData() const {
void FileDownloader::downloadedData() const {
    // return m_DownloadedData;
    qDebug()<<"indi";
}

void FileDownloader::getUavtNumarataj(){

}


QString FileDownloader::convertImageToBase64String(QString path){
    QFile* file = new QFile(path);
    file->open(QIODevice::ReadOnly);
    QByteArray image = file->readAll();
    int originalSize = image.length();
    qDebug()<<"originalSize"<<originalSize;
    QString encoded = QString(image.toBase64());
    int encodedSize = encoded.size();
    qDebug()<<"encodedSize"<<encodedSize;
    return encoded;
}
