TEMPLATE = app
TARGET = tst_rulebook
CONFIG += warn_on qmltestcase

SOURCES += \
    $$PWD/tst_rulebook.cpp

RESOURCES += \
    $$RULEBOOK_SOURCE_TREE/src/qml.qrc

OTHER_FILES += \
    $$PWD/data/*
