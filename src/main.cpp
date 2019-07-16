#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtWebView>

#include <QQmlContext>
#include <QFileInfo>

#ifdef Q_OS_ANDROID
#include <QtAndroid>
#endif

#include "system.h"
#include "utils.h"

static QObject *
system_manager_singletontype_provider(QQmlEngine *engine,
                                      QJSEngine *scriptEngine) {
  Q_UNUSED(scriptEngine)
  Q_UNUSED(engine)
  auto system = new System();

  return system;
}

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setApplicationName("Barbarians");
    QCoreApplication::setOrganizationName("Tabula Games");

    QGuiApplication app(argc, argv);

    QtWebView::initialize();

    QQmlApplicationEngine engine;

    qmlRegisterSingletonType<System>(
        "System", 1, 0, "System",
        system_manager_singletontype_provider);

    // copy resource related to the web view to a local directory
    // this is needed because WebView doesn't support loading from qrc
    auto destination = copyHtmlResourcesToDataLocation(":/pages/");
    auto baseUrl = QUrl::fromLocalFile(QFileInfo(destination + "/pages/rulebook.html").absoluteFilePath());

    // if wanted, set the QML webview URL
    auto* context = engine.rootContext();
    context->setContextProperty(QStringLiteral("baseUrl"), baseUrl);

    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

#ifdef Q_OS_ANDROID
    QtAndroid::hideSplashScreen();
#endif

    return app.exec();
}
