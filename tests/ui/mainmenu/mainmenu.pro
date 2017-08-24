TEMPLATE = app
TARGET = tst_mainmenu
CONFIG += warn_on qmltestcase

SOURCES += \
    $$PWD/tst_mainmenu.cpp

RESOURCES += \
    $$RULEBOOK_SOURCE_TREE/src/qml.qrc

OTHER_FILES += \
    $$PWD/data/*
