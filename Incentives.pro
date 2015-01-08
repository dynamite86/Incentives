QT       += qml quick
TEMPLATE  = app
DESTDIR   = $$PWD

SOURCES += main.cpp

DISTFILES += qml/main.qml \
             win32.rc

RC_FILE = win32.rc
