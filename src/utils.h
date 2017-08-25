#ifndef UTILS_H
#define UTILS_H

#include <QDir>
#include <QDirIterator>
#include <QString>
#include <QStandardPaths>

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
    QDir destDir(QStandardPaths::writableLocation(QStandardPaths::AppDataLocation));

    QDirIterator it(fromPath, QDirIterator::Subdirectories);
    while (it.hasNext()) {
        QString currentResource;
        currentResource = it.next();

        // we copy only files
        if (QFileInfo(currentResource).isFile()) {
            QFileInfo file = QFileInfo(destDir.absolutePath() + currentResource.right(currentResource.size()-1));

            // create full path if necessary
            file.dir().mkpath(".");

            // remove previous file to make sure we have the latest version
            QFile::remove(file.absoluteFilePath());
            QFile::copy(currentResource, file.absoluteFilePath());
        }
    }

    return destDir.absolutePath();
}

#endif // UTILS_H
