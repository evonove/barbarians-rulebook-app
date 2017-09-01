#ifndef UTILS_H
#define UTILS_H

#include <QDir>
#include <QDirIterator>
#include <QString>
#include <QStandardPaths>

#include <QDebug>

/**
 * @brief copyHtmlResources
 * @param fromPath: it's the path in the resources from which items should be copied
 * @return Absolute path to the local directory that contains the resources copied
 *
 * This method copies resources from a path in the Qt Resource System to the
 * local QStandardPaths::AppDataLocation.
 */
QString copyHtmlResourcesToDataLocation(const QString& fromPath)
{
    qDebug() << "Copy html resources";
#ifdef Q_OS_IOS
    QDir destDir(QStandardPaths::writableLocation(QStandardPaths::TempLocation));
#else
    QDir destDir(QStandardPaths::writableLocation(QStandardPaths::AppDataLocation));
#endif

    QDirIterator it(fromPath, QDirIterator::Subdirectories);
    while (it.hasNext()) {
        QString currentResource;
        currentResource = it.next();

        qDebug() << "current resource" << currentResource;
        // we copy only files
        if (QFileInfo(currentResource).isFile()) {
            QFileInfo file = QFileInfo(destDir.absolutePath() + currentResource.right(currentResource.size()-1));

            // create full path if necessary
            if (!file.dir().mkpath(".")) {
                qDebug() << "Could not create directory" << file.dir().absolutePath();
            }

            // remove previous file to make sure we have the latest version
            QFile::remove(file.absoluteFilePath());
            if (!QFile::copy(currentResource, file.absoluteFilePath())) {
                qDebug() << "Could not copy file" << file.absoluteFilePath();
            }

            qDebug() << "Resource" << currentResource << "copied to" << file.absoluteFilePath();
        }
    }

    return destDir.absolutePath();
}

#endif // UTILS_H
