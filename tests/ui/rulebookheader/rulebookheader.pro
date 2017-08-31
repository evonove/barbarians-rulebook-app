TEMPLATE = app
TARGET = tst_rulebookheader
CONFIG += warn_on qmltestcase

SOURCES += \
    $$PWD/tst_rulebookheader.cpp

RESOURCES += \
    $$RULEBOOK_SOURCE_TREE/src/qml.qrc

OTHER_FILES += \
    $$PWD/data/*
