import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1

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

//        Layout.minimumWidth: 360
//        Layout.minimumHeight: 360

        Tab {
            title: "Parameters"
            ParametersDialog {
//                enabled: enabler.checked
            }
        }
        Tab {
            title: "Main"
            MainWindow {
//                enabled: enabler.checked
            }
        }

    }
}
