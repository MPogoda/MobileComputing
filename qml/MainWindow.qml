import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2

import QtQuick.Dialogs 1.2

ScrollView {
    id: page

    signal started
    signal stopped

    Item {
        id: content

        width: page.viewport.width
        height: page.viewport.height

        RowLayout {
            id: mainRows

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: mainRows.spacing
            Layout.fillHeight: true

            ColumnLayout {
                anchors.fill: parent
                Layout.fillWidth: true
                Layout.fillHeight: true

                GroupBox {
                    title: qsTr( "Overall drunkness" )
                    Layout.fillWidth: true;
                    ColumnLayout {
                        anchors.fill: parent
                        Slider {
                            id: drunkness
                            Layout.fillWidth: true;
                            value: 0
                            minimumValue: 0
                            enabled: false
                        }
                        Text {
                            text: Math.round(10000 * (drunkness.value / drunkness.maximumValue))/100 + qsTr( "%" )
                            anchors.right: parent.right
                        }
                    }
                }
                GroupBox {
                    title: qsTr( "Time left" )
                    Layout.fillWidth: true;
                    ColumnLayout {
                        anchors.fill: parent
                        Slider {
                            id: timeLeft
                            Layout.fillWidth: true;
                            value: 0
                            enabled: false
                        }
                        Text {
                            function getText( value ) {
                                if (value < 0 ) {
                                    value = 0
                                }

                                var hours = Math.floor( value );
                                var minutes = Math.floor( 60 * (value - hours) )
                                console.log( minutes)
                                return hours + qsTr( " hour(s)") + ((minutes >1) ? ", " + minutes + qsTr( " minutes") : "")

                            }

                            text: getText( timeLeft.value)
                            anchors.right: parent.right
                        }
                    }
                }
                GroupBox {
                    title: qsTr( "Company size" )
                    Layout.fillWidth: true;
                    ColumnLayout {
                        anchors.fill: parent
                        Slider {
                            id: companySize
                            Layout.fillWidth: true;
                            value: 0
                            minimumValue: 0
                            maximumValue: 16
                            stepSize: 1
                            onValueChanged: bartender.setGroupSize( companySize.value )
                        }
                        Text {
                            text: companySize.value + qsTr( " guys")
                            anchors.right: parent.right
                        }
                    }
                }

                Button {
                    Layout.fillWidth: true
                    anchors.bottom: parent.bottom
                    text: qsTr( "Drink some" )
                    enabled: pint.value == 0
                    onClicked: order()
                }
            }
            GroupBox {
                Layout.fillHeight: true
                Layout.fillWidth: true;
                title: qsTr( "Pint" )

                ColumnLayout {
                    anchors.fill: parent
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Slider {
                        id: pint
                        Layout.fillWidth: true;
                        Layout.fillHeight: true
                        orientation: Qt.Vertical
                        onValueChanged: drink( value )
                        enabled: isEnabled()

                        function isEnabled() {
                            if ((drunkness.value < drunkness.maximumValue) && (timeLeft.value > 0)) {
                                return true;
                            }

                            console.log( "Stopping..." )
                            page.stopped()
                            return false;
                        }

                        property int oldValue;

                        function setValue( value ) {
                            if ((value <= pint.maximumValue) && (value >= minimumValue)) {
                                pint.oldValue = value
                                pint.value = value
                            }
                        }

                        function setOrder( total ) {
                            pint.maximumValue = total
                            pint.setValue( total )
                        }

                        function drink( value ) {
                            if (value > pint.oldValue) {
                                pint.value = oldValue;
                            } else {
                                var diff = oldValue - value
                                if (diff >= 10 || value === 0) {
                                    bartender.sip( oldValue - value)
                                    timeLeft.value = bartender.hours()
                                    drunkness.value += (oldValue - value)

                                    console.log( drunkness.value )
                                    console.log( drunkness.maximumValue)

                                    oldValue = value;
                                }
                            }
                        }
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        Item {
                            Layout.fillWidth: true
                        }
                        Text {
                            anchors.horizontalCenter: pint.anchors.horizontalCenter
                            text: Math.round( pint.value )+ qsTr(" ml")
                        }
                        Item {
                            Layout.fillWidth: true
                        }
                    }

                }
            }

        }

    }

    function order() {
        page.started()

        var orderValue = bartender.order()
        if (0 === orderValue) {
            console.log( "Stopping...")
            page.stopped()
        } else {
            pint.setOrder( bartender.order() )
        }

    }

    function reconfigure() {
        console.log( "Reconfiguring main window...")
        drunkness.maximumValue = bartender.maximumDrunkness();
        drunkness.value = 0
        timeLeft.maximumValue = bartender.hours();
        timeLeft.value = timeLeft.maximumValue
    }

    Component.onCompleted: reconfigure()
}
