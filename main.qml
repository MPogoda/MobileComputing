import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2

import "qml/UI.js" as UI
import "qml"

ApplicationWindow {
    title: qsTr("Hello World")
    visible: true


    toolBar: ToolBar {
        RowLayout {
            anchors.fill: parent
            anchors.margins: spacing
            Label {
                text: UI.label
            }
            Item { Layout.fillWidth: true }
        }
    }

    menuBar: MenuBar {
        Menu {
            title: qsTr("&File")
            MenuItem {
                text: qsTr( "A&uthorisation" )
                shortcut: StandardKey.Preferences
                onTriggered: tabView.currentIndex = 2
            }

            MenuItem {
                text: qsTr("E&xit")
                shortcut: StandardKey.Quit
                onTriggered: Qt.quit();
            }
        }
    }


    TabView {
        id: tabView

        anchors.fill: parent
        anchors.margins: UI.margin
        tabPosition: UI.tabPosition
        Layout.fillWidth: true;
        Layout.fillHeight: true


        property bool authorised
        property bool mainStarted

        Tab {
            title: "Parameters"
            ParametersDialog {
                enabled: (tabView.authorised) && (!tabView.mainStarted)
                onVisibleChanged: setHelpText( tabView.authorised, tabView.mainStarted );
            }
        }
        Tab {
            title: "Main"
            MainWindow {
                onStarted: tabView.setMainStarted( true )
                onStopped: tabView.setMainStarted( false )
                onVisibleChanged: reconfigure()
            }
        }

        Tab {
            title: qsTr( "Auth" )
            AuthorisationForm {
                onAuthLogin: { tabView.authorised = true }
                onAuthLogout: { tabView.authorised = false }
            }
        }

        function setMainStarted( value ) {
            tabView.mainStarted = value
            if (value === false) {
                messageDialog.show( qsTr( "Enough is enough!" ))
            }
        }
    }


    MessageDialog {
        id: messageDialog
        title: "May I have your attention please"
        function show( caption ) {
            messageDialog.text = caption
            messageDialog.open()
        }
    }
}
