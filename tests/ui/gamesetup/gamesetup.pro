TEMPLATE = app
TARGET = tst_gamesetup
CONFIG += warn_on qmltestcase

SOURCES += \
    $$PWD/tst_gamesetup.cpp

RESOURCES += \
    $$RULEBOOK_SOURCE_TREE/src/assets.qrc \
    $$RULEBOOK_SOURCE_TREE/src/qml.qrc

OTHER_FILES += \
    $$PWD/data/*
