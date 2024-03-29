TARGET = barbarians
QT += qml quick gui-private webview multimedia

CONFIG += c++11

SOURCES += \
    $$PWD/main.cpp \
    $$PWD/system.cpp

HEADERS += \
    $$PWD/utils.h \
    $$PWD/system.h

RESOURCES += \
    $$PWD/artwork.qrc \
    $$PWD/assets.qrc \
    $$PWD/music.qrc \
    $$PWD/qml.qrc

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

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target


OTHER_FILES += \
    $$PWD/qml/*.qml \
    $$PWD/qml/components/*.qml

android {
    QT += androidextras
    # To upgrade the version change the following variable
    VERSION = 1.2.3

    OTHER_FILES += \
        $$PWD/android/src/it/evonove/qt5/* \
        $$PWD/android/AndroidManifest.xml \
        $$PWD/android/build.gradle \
        $$PWD/android/gradle/wrapper/gradle-wrapper.jar \
        $$PWD/android/gradle/wrapper/gradle-wrapper.properties \
        $$PWD/android/gradlew \
        $$PWD/android/gradlew.bat \
        $$PWD/android/res/values/* \
        $$PWD/android/res/values-v21/* \
        $$PWD/android/res/mipmap-hdpi/* \
        $$PWD/android/res/mipmap-mdpi/* \
        $$PWD/android/res/mipmap-xhdpi/* \
        $$PWD/android/res/mipmap-xxhdpi/* \
        $$PWD/android/res/mipmap-xxxhdpi/* \
        $$PWD/android/res/drawable/*

    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

    # This is needed to automate version code increment for 54bit builds
    # Reference: https://blog.qt.io/blog/2019/06/28/comply-upcoming-requirements-google-play/
    defineReplace(droidVersionCode) {
        segments = $$split(1, ".")
        for (segment, segments): vCode = "$$first(vCode)$$format_number($$segment, width=3 zeropad)"

        contains(ANDROID_TARGET_ARCH, arm64-v8a): \
            suffix = 1
        else:contains(ANDROID_TARGET_ARCH, armeabi-v7a): \
            suffix = 0
        # add more cases as needed

        return($$first(vCode)$$first(suffix))
    }

    ANDROID_VERSION_NAME = $$VERSION
    ANDROID_VERSION_CODE = $$droidVersionCode($$ANDROID_VERSION_NAME)
}

ios {
    # To upgrade the version change the following variable
    VERSION = 1.2.0

    QMAKE_TARGET_BUNDLE_PREFIX = it.evonove
    QMAKE_BUNDLE = barbarians

    OTHER_FILES += \
        $$PWD/ios/Images.xcassets/AppIcon.appiconset/* \
        $$PWD/ios/Images.xcassets/LaunchImage.launchimage/*

    # Add a custom plist
    QMAKE_INFO_PLIST = $$PWD/ios/Info.plist

    # App assets
    QMAKE_ASSET_CATALOGS = $$PWD/ios/Images.xcassets
    QMAKE_ASSET_CATALOGS_APP_ICON = "AppIcon"
    QMAKE_ASSET_CATALOGS_LAUNCH_IMAGE = "LaunchImage"
}
