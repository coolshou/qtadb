#
#Copyright 2010-20XX by Jakub Motyczko
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#
#   @author Jakub Motyczko
# -------------------------------------------------
QT += network core widgets
#QT += declarative
QT += quick
TARGET = QtADB

TEMPLATE = app
SOURCES += main.cpp \
    ./dialogs/mainwindow.cpp \
    ./dialogs/dialogkopiuj.cpp \
    ./classes/phone.cpp \
    ./classes/computer.cpp \
    ./threads/screenshotthread.cpp \
    ./dialogs/connectWifi.cpp \
    ./dialogs/aboutdialog.cpp \
    ./dialogs/appdialog.cpp \
    ./classes/application.cpp \
    ./classes/updateapp.cpp \
    ./dialogs/appinfo.cpp \
    widgets/filewidget.cpp \
    widgets/appwidget.cpp \
    widgets/recoverywidget.cpp \
    widgets/fastbootwidget.cpp \
    widgets/screenshotwidget.cpp \
    widgets/phoneinfowidget.cpp \
    widgets/settingswidget.cpp \
    widgets/shellwidget.cpp \
    widgets/messagewidget.cpp \
    widgets/contactwidget.cpp \
    classes/models/apptablemodel.cpp \
    classes/models/filetablemodel.cpp \
    classes/models/backuptablemodel.cpp \
    classes/animation.cpp \
    classes/models/messagemodel.cpp \
    classes/models/messagethreadmodel.cpp \
    classes/models/contactmodel.cpp \
    dialogs/logcatdialog.cpp \
    classes/models/logcatmodel.cpp \
    classes/ecwin7.cpp \
    classes/mytableview.cpp \
    dialogs/registerdialog.cpp
HEADERS += ./dialogs/mainwindow.h \
    ./dialogs/dialogkopiuj.h \
    ./classes/phone.h \
    ./classes/computer.h \
    ./threads/screenshotthread.h \
    ./dialogs/connectWifi.h \
    ./dialogs/aboutdialog.h \
    ./dialogs/appdialog.h \
    ./classes/application.h \
    ./classes/updateapp.h \
    ./dialogs/appinfo.h \
    widgets/filewidget.h \
    widgets/appwidget.h \
    widgets/recoverywidget.h \
    widgets/fastbootwidget.h \
    widgets/screenshotwidget.h \
    widgets/phoneinfowidget.h \
    widgets/settingswidget.h \
    widgets/shellwidget.h \
    widgets/messagewidget.h \
    widgets/contactwidget.h \
    classes/models/apptablemodel.h \
    classes/models/filetablemodel.h \
    classes/models/backuptablemodel.h \
    classes/animation.h \
    classes/models/messagemodel.h \
    classes/models/messagethreadmodel.h \
    classes/models/contactmodel.h \
    dialogs/logcatdialog.h \
    classes/models/logcatmodel.h \
    classes/ecwin7.h \
    classes/mytableview.h \
    dialogs/registerdialog.h
FORMS += ./dialogs/mainwindow.ui \
    ./dialogs/dialogkopiuj.ui \
    ./dialogs/connectWifi.ui \
    ./dialogs/aboutdialog.ui \
    ./dialogs/appdialog.ui \
    ./dialogs/appinfo.ui \
    widgets/filewidget.ui \
    widgets/appwidget.ui \
    widgets/recoverywidget.ui \
    widgets/fastbootwidget.ui \
    widgets/screenshotwidget.ui \
    widgets/phoneinfowidget.ui \
    widgets/settingswidget.ui \
    widgets/shellwidget.ui \
    widgets/messagewidget.ui \
    widgets/contactwidget.ui \
    dialogs/logcatdialog.ui \
    dialogs/registerdialog.ui

LANGUAGES = en pl el es it nl cs de hu sv ja ar ru pt sr zh_CN zh_TW

# parameters: var, prepend, append
defineReplace(prependAll) {
 for(a,$$1):result += $$2$${a}$$3
 return($$result)
}

#TRANSLATIONS = $$prependAll(LANGUAGES, $$PWD/languages/qtadb_, .ts)
TRANSLATIONS = $$prependAll(LANGUAGES, languages/qtadb_, .ts)

TRANSLATIONS_FILES =

qtPrepareTool(LRELEASE, lrelease)
for(tsfile, TRANSLATIONS) {
 #qmfile = $$shadowed($$tsfile)
 qmfile = $$relative_path($$tsfile)
 qmfile ~= s,.ts$,.qm,
 qmdir = $$dirname(qmfile)
 !exists($$qmdir) {
    mkpath($$qmdir)|error("Aborting.")
 }
 command = $$LRELEASE -removeidentical $$tsfile -qm $$qmfile
 system($$command)|error("Failed to run: $$command")
 TRANSLATIONS_FILES += $$qmfile
}

## automate the process for creating TS files
#wd = $$replace(PWD, /, $$QMAKE_DIR_SEP)
#
#qtPrepareTool(LUPDATE, lupdate)
#LUPDATE += -locations relative -no-ui-lines
#TSFILES = $$files($$PWD/languages/qtadb_''''.ts) $$PWD/languages/qtadb_untranslated.ts
#for(file, TSFILES) {
# lang = $$replace(file, .''''_([^/]*).ts, 1)
# v = ts-$${lang}.commands
# $$v = cd $$wd && $$LUPDATE $$SOURCES $$APP_FILES -ts $$file
# QMAKE_EXTRA_TARGETS += ts-$$lang
#}
#ts-all.commands = cd $$PWD && $$LUPDATE $$SOURCES $$APP_FILES -ts $$TSFILES
#QMAKE_EXTRA_TARGETS += ts-all

#
#qtPrepareTool(LCONVERT, lconvert)
#LCONVERT += -locations none
#isEqual(QMAKE_DIR_SEP, /) {
# commit-ts.commands =  cd $$wd;  git add -N languages/*''.ts &&  for f in `git diff-files —name-only languages/*''.ts`; do  $$LCONVERT -i f -o f;  done;  git add languages/*_.ts && git commit
#} else {
# commit-ts.commands =  cd $$wd &&  git add -N languages/*''.ts &&  for /f usebackq %%f in (`git diff-files —name-only — languages/*''.ts`) do  $$LCONVERT -i %f -o%f $$escape_expand(nt)  cd $$wd && git add languages/*_.ts && git commit
#}
#QMAKE_EXTRA_TARGETS += commit-ts

#TRANSLATIONS = \
#	languages/qtadb_ar.ts \
#	languages/qtadb_de.ts \
#	languages/qtadb_en.ts \
#	languages/qtadb_hu.ts \
#	languages/qtadb_ja.ts \
#	languages/qtadb_pl.ts \
#	languages/qtadb_ru.ts \
#	languages/qtadb_sv.ts \
#	languages/qtadb_cs.ts \
#	languages/qtadb_el.ts \
#	languages/qtadb_es.ts \
#	languages/qtadb_it.ts \
#	languages/qtadb_nl.ts \
#	languages/qtadb_pt.ts \
#	languages/qtadb_sr.ts \
#	languages/qtadb_zh.ts \
#	languages/qtadb_zh_TW.ts

RC_FILE = ikonka.rc
RESOURCES += zasoby.qrc
OTHER_FILES += otherFiles/changes.txt \
    otherFiles/todo.txt \
    otherFiles/busybox

OTHER_FILES += \
    qml/messageView.qml \
    qml/messages/ThreadList.qml \
    qml/messages/MessageList.qml \
    qml/messages/delegates/MessageDelegate.qml \
    qml/messages/delegates/ThreadDelegate.qml \
    qml/messages/delegates/ScrollBar.qml \
    qml/messages/delegates/Button.qml \
    qml/messages/delegates/SendMessage.qml \
    qml/messages/NewMessage.qml \
    qml/messages/delegates/ContactDelegate.qml \
    qml/messages/ContactList.qml \
    qml/messages/delegates/ThreadContextMenu.qml

win32 {
LIBS += libole32
}

mac {
QMAKE_INFO_PLIST = QtADB.plist
ICON = images/android.icns
BUSYBOX.files = otherFiles/busybox
BUSYBOX.path = Contents/Resources
QMAKE_BUNDLE_DATA += BUSYBOX
}

#tutaj i w ecwin7.h
