import QtQuick 2.4
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2

Item {
    property alias timeLeft: timeLeft
    property alias drunkResistance: drunkResistance

    ColumnLayout {
        anchors.centerIn: parent

        SpinBox {
            id: timeLeft
            value: 4
            minimumValue: 0.5
            maximumValue: 8
            stepSize: 0.5
            decimals: 1
            suffix: qsTr(" hours")
        }

        Text {
            anchors.right: timeLeft.left
            anchors.verticalCenter: timeLeft.verticalCenter
            anchors.rightMargin: 5
            text: "Time: "
        }

        Slider {
            id: drunkResistance
            minimumValue: 0
            maximumValue: 2
            value: 1
            tickmarksEnabled: true
            stepSize: 1
         }

        Text {
            anchors.right: drunkResistance.left
            anchors.verticalCenter: drunkResistance.verticalCenter
            anchors.rightMargin: 5
            text: "Drunk Resistance: "
        }
    }
}

