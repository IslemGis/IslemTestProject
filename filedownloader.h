#ifndef FILEDOWNLOADER_H
#define FILEDOWNLOADER_H

#include <QObject>
#include <QByteArray>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QSqlQuery>
#include <sqlite3.h>
#include <QMessageBox>
#include <QElapsedTimer>
class FileDownloader : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QUrl fileUrl READ fileUrl WRITE setFileUrl)
    Q_PROPERTY(QString filePath READ filePath WRITE setFilePath)

public:
    explicit FileDownloader(QObject *parent = 0);
    virtual ~FileDownloader();
    //  QByteArray downloadedData() const;
    void downloadedData() const;
    QString newdb;
    QUrl fileUrl(){
        return  m_fileUrl;
    }

    void setFileUrl(QUrl &_fileUrl){
        m_fileUrl=_fileUrl;
    }

    QString filePath(){
        return  m_filePath;
    }

    void setFilePath(QString &_filePath){
        m_filePath=_filePath;
    }

    static int callback(void *unused, int count, char **data, char **columns)
    {
        int idx;
        qDebug()<<"fddfdfdffdfd";
        //        printf("There are %d column(s)\n", count);

        //        for (idx = 0; idx < count; idx++) {
        //            printf("The data in column \"%s\" is: %s\n", columns[idx], data[idx]);
        //        }

        //        printf("\n");

        return 0;
    }
    Q_INVOKABLE QString convertImageToBase64String(QString path);

signals:
    void downloaded();
    void downloadedError();
    void downloadProgressUpdated(int bytesReceived,int totalBytes,float downloadSpeed,int totalDuration);
    void fileProcessEnded();
    void byte64ImageResult(QString base64Result);
public slots:
    void fileDownloaded(QNetworkReply* pReply);
    void fileDownload();
    void getUavtNumarataj();
    // void openDb(QString homepath);
    void onError(QNetworkReply::NetworkError networkError)
    {
        //reply->disconnect(); // Disconnect all signals
        qDebug()<<"gegege"+networkError;
        if (networkError == QNetworkReply::ContentNotFoundError)
        {
            qDebug()<<"gegegeddd"+networkError;

            // Messagebox starts an event loop which
            // causes this slot to be called again
            //           QMessageBox m;
            //           m.exec();
        }
        emit downloadedError();
    }
    void downloadProgress(qint64 bytesWr,qint64 totalBytes){

        quint64 timerDifference=timerElapsed.elapsed()-prevTimer;
        quint64 bytesDifference=bytesWr-prevTotalBytes;

        prevTimer=timerElapsed.elapsed();
        prevTotalBytes=bytesWr;
        float downloadSpeed=((float)(bytesDifference/timerDifference));
        qDebug()<<"downloadProgress bytes Rec. "<<bytesWr/1024 <<"kb \ntotal bytes "<<totalBytes/1000<<" kb dSpeed"<<downloadSpeed;
        qDebug()<<"timer "<<timerElapsed.elapsed()<<" sn - difference"<<timerDifference;
        emit downloadProgressUpdated((int)bytesWr,(int)totalBytes,downloadSpeed,(int)timerElapsed.elapsed() );
    }
    void getHeaders(QNetworkReply * reply);
    void processDbFile();
private:
    QNetworkAccessManager m_WebCtrl;
    QByteArray m_DownloadedData;
    QUrl m_fileUrl;
    QString m_filePath;
    QNetworkReply* reply;
    QNetworkReply* downloadReply;
    QElapsedTimer timerElapsed;
    quint64 prevTimer=0;
    quint64 prevTotalBytes=0;


};

#endif // FILEDOWNLOADER_H
