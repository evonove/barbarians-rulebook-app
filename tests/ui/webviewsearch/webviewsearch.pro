TEMPLATE = app
TARGET = tst_webviewsearch
CONFIG += warn_on qmltestcase

SOURCES += \
    $$PWD/tst_webviewsearch.cpp

RESOURCES += \
    $$RULEBOOK_SOURCE_TREE/src/qml.qrc

OTHER_FILES += \
    $$PWD/data/*
