#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtWebView>

#include <QQmlContext>
#include <QFileInfo>

#include "utils.h"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QtWebView::initialize();

    QQmlApplicationEngine engine;

    // copy resource related to the web view to a local directory
    // this is needed because WebView doesn't support loading from qrc
    auto destination = copyHtmlResourcesToDataLocation(":/pages/");
    auto baseUrl = QUrl::fromLocalFile(QFileInfo(destination + "/pages/rulebook.html").absoluteFilePath());

    // if wanted, set the QML webview URL
    auto* context = engine.rootContext();
    context->setContextProperty(QStringLiteral("baseUrl"), baseUrl);

    engine.load(QUrl(QLatin1String("qrc:/qml/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
