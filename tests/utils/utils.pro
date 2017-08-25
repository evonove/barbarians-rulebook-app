TARGET = tst_utils
QT += testlib
CONFIG += testcase

SOURCES += \
    $$PWD/tst_utils.cpp

INCLUDEPATH += \
    $$RULEBOOK_SOURCE_TREE/src/

RESOURCES += \
    $$PWD/utils.qrc
