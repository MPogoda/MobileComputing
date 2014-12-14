import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2

import QtQuick.Dialogs 1.2

ScrollView {
    id: page

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
                            maximumValue: 100
                            enabled: false
                        }
                        Text {
                            text: drunkness.value + qsTr( "%" )
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
                            text: timeLeft.value + qsTr( " hours" )
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
                    onClicked: pint.setOrder( 1000 )
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
                                oldValue = value;
                            }
                        }
                    }
                }
            }

        }

    }


    function increaseDrunkness( value ) {
        if ((value + drunkness.value) >= 100) {
            drunkness.value = 100;
            stop();
        } else {
            drunkness.value += value;
        }
    }

    function decreaseTime( value ) {
        if (timeLeft.value > value) {
            timeLeft.value -= value;
        } else {
            timeLeft.value = 0;
            stop();
        }
    }

}
