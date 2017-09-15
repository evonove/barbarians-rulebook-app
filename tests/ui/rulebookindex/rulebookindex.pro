TEMPLATE = app
TARGET = tst_rulebookindex
CONFIG += warn_on qmltestcase

SOURCES += \
    $$PWD/tst_rulebookindex.cpp

RESOURCES += \
    $$RULEBOOK_SOURCE_TREE/src/qml.qrc

OTHER_FILES += \
    $$PWD/data/*
