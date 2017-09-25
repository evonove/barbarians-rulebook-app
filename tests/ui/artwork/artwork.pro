TEMPLATE = app
TARGET = tst_artwork
CONFIG += warn_on qmltestcase

SOURCES += \
    $$PWD/tst_artwork.cpp

RESOURCES += \
    $$RULEBOOK_SOURCE_TREE/src/qml.qrc

OTHER_FILES += \
    $$PWD/data/*
