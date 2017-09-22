TARGET = barbarians
QT += qml quick webview

CONFIG += c++11

SOURCES += \
    $$PWD/main.cpp

HEADERS += \
    $$PWD/utils.h

RESOURCES += \
    $$PWD/assets.qrc \
    $$PWD/music.qrc \
    $$PWD/qml.qrc \
    $$PWD/pages.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

pagesFolder.source = pages
DEPLOYMENTFOLDERS += pagesFolder

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target


OTHER_FILES += \
    $$PWD/qml/*.qml \
    $$PWD/qml/components/*.qml


android {
    QT += androidextras

    OTHER_FILES += \
        $$PWD/android/res/drawable/* \
        $$PWD/android/res/values/* \
        $$PWD/android/AndroidManifest.xml \
        $$PWD/android/build.gradle

    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
}

ios {
    OTHER_FILES += $$PWD/ios/*

    # Add a custom plist
    QMAKE_INFO_PLIST = $$PWD/ios/Info.plist

    # application icons
    ios_icon.files = $$files($$PWD/ios/AppIcon*.png)
    QMAKE_BUNDLE_DATA += ios_icon

    # launch images
    launchimages.files = $$files($$PWD/ios/LaunchImage*.png)
    QMAKE_BUNDLE_DATA += launchimages

    # itunes artwork
    itunes_images.files = $$files($$PWD/ios/iTunesArtwork*.png)
    QMAKE_BUNDLE_DATA += itunes_images
}
