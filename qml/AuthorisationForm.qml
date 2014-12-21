import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2

ScrollView {
    id: page

    signal authLogin
    signal authLogout
    Item {
        id: content
        width: page.viewport.width
        height: page.viewport.height

        property bool authenticated

        ColumnLayout {
            anchors.fill: parent
            TextField {
                Layout.fillWidth: true
                id: user
                placeholderText: qsTr( "Username" )
            }

            TextField {
                Layout.fillWidth: true
                echoMode: TextInput.PasswordEchoOnEdit
                id: pswd
                placeholderText: qsTr( "Password")
            }
            Button {
                text: qsTr( "Login" )
                visible: !content.authenticated
                enabled: (!timer.running) && (user.text.length > 0) && (pswd.text.length > 0)
                onClicked: { busy.visible = true; busy.running = true; timer.start() }
            }

            Button {
                text: qsTr( "Logout" )
                visible: content.authenticated
                id: logout
                onClicked: { user.text = ""; pswd.text = ""; busy.visible = true; busy.running = true; timer.start() }
            }
            BusyIndicator {
                id: busy
                visible: false
            }
            Timer {
                id: timer
                function login() {
                    busy.visible = false
                    if ((user.text == "Mum") && (pswd.text == "yourmum")) {
                        messageDialog.show( qsTr( "Authentication succeed!") )
                        content.authenticated = true
                        page.authLogin()
                    } else {
                        messageDialog.show( qsTr("Authentication failed!") );
                        content.authenticated = false
                        page.authLogout()
                    }
                }
                onTriggered: login()
            }
        }


        MessageDialog {
            id: messageDialog
            title: "Authentication"
            function show( caption ) {
                messageDialog.text = caption
                messageDialog.open()
            }
       }
    }
}
