#include <QtTest/QtTest>

#include <QStandardPaths>

#include "utils.h"


class TestUtils: public QObject
{
    Q_OBJECT

private slots:
    void resourcesAreCopied();
};


/* Check that the file is copied from the Qt Resource System to
 * the QStandardPaths::AppDataLocation */
void TestUtils::resourcesAreCopied()
{
    QStandardPaths::setTestModeEnabled(true);
    auto dataLocation = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    auto fileInfo = QFileInfo(dataLocation + "/data/index.html");
    // ensure file doesn't exist
    QFile::remove(fileInfo.absoluteFilePath());
    Q_ASSERT(!fileInfo.exists());
    copyHtmlResourcesToDataLocation(":/data/");
    Q_ASSERT(fileInfo.exists());
}


QTEST_MAIN(TestUtils)
#include "tst_utils.moc"
