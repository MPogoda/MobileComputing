import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2

ScrollView {
    id: page


    Item {
        id: content

        width: page.viewport.width
        height: page.viewport.height


        ColumnLayout {
            id: column

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: column.spacing

            GroupBox {
                title: qsTr( "Time")
                Layout.fillWidth: true
                ColumnLayout {
                    anchors.fill: parent
                    Slider {
                        id: timeLeft
                        Layout.fillWidth: true
                        value: 4
                        minimumValue: 0.5
                        maximumValue: 8
                        stepSize: 0.5
                        tickmarksEnabled: true
                        onValueChanged: bartender.setHours( timeLeft.value )
                    }
                    Text {
                        text: timeLeft.value + qsTr( " hours")
                        anchors.right: parent.right
                    }
                }
            }

            GroupBox {
                title: qsTr( "Drunk Resistance")
                Layout.fillWidth: true
                ColumnLayout {
                    anchors.fill: parent
                    Slider {
                        id: drunkResistance
                        Layout.fillWidth: true
                        value: 1
                        minimumValue: 0
                        maximumValue: 2
                        stepSize: 1
                        tickmarksEnabled: true
                        onValueChanged: bartender.setProfile( drunkResistance.value )
                    }
                    Text {
                        text: if (0 == drunkResistance.value) {
                                return qsTr( "Newbie" );
                            } else if (1 == drunkResistance.value) {
                                return qsTr( "College student" );
                            } else {
                                return qsTr( "Boris Eltsin" );
                            }
                        anchors.right: parent.right
                    }
                }
            }

            Text {
                id: helpText
            }

        }
    }

    function setHelpText( authorised, mainStarted) {
        console.log( "setting...(Authorised:" + authorised + ", mainstarted: " + mainStarted + ")")
        helpText.text =  qsTr( "" )

        if (authorised) {
            if (mainStarted) {
                helpText.text = qsTr( "Main started...")
            }
        } else {
            helpText.text =  qsTr( "Unauthorised..." );
        }

    }

    Component.onCompleted: setHelpText( false, false )
}
