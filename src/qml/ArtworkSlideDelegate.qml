import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

import QtGraphicalEffects 1.0


Pane {
    id: root

    property url image
    property string title: ""
    property string category: ""
    property string description: ""

    padding: 0
    state: "IMAGE"

    Image {
        anchors.fill: parent
        source: root.image
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
        smooth: false
        cache: false

        BusyIndicator { anchors.centerIn: parent; running: parent.status !== Image.Ready }
    }

    Rectangle {
        id: _infoBackground
        anchors.fill: parent
        color: "black"
    }

    Item {
        id: _info
        width: parent.width; height: parent.height

        ScrollView {
            width: parent.width; height: parent.height

            contentWidth: parent.width
            contentHeight: _category.height + _title.height + _description.height + 76

            anchors.top: parent.top; anchors.topMargin: 32
            anchors.left: parent.left; anchors.leftMargin: 16

            Label {
                id: _category
                text: root.category

                font.pixelSize: 14
                font.weight: Font.Medium

                Material.foreground: Material.color(Material.Amber, Material.Shade500)
            }

            DropShadow {
                anchors.fill: _category
                source: _category
                horizontalOffset: 0; verticalOffset: 2
                radius: 3.0
                samples: 9
                color: "black"
                z: -1
            }

            Label {
                id: _title
                anchors.top: _category.bottom; anchors.topMargin: 4
                text: root.title

                font.pixelSize: 20
                font.weight: Font.Medium
            }

            DropShadow {
                anchors.fill: _title
                source: _title
                horizontalOffset: 0; verticalOffset: 2
                radius: 3.0
                samples: 9
                color: "black"
                z: -1
            }

            Label {
                id: _description
                anchors.top: _title.bottom; anchors.topMargin: 32
                width: parent.width - 32
                text: root.description
                textFormat: Text.RichText
                wrapMode: Text.Wrap

                font.pixelSize: 16
            }
        }
    }

    Button {
        anchors.bottom: parent.bottom; anchors.bottomMargin: 16
        anchors.right: parent.right; anchors.rightMargin: 16

        enabled: root.description !== ""
        visible: root.description !== ""

        text: root.state === "IMAGE" ? qsTr("Show Info") : qsTr("Hide Info")
        flat: true

        Material.foreground: Material.color(Material.Amber, Material.Shade500)

        onClicked: root.state === "IMAGE" ? root.state = "INFO" : root.state = "IMAGE"

        DropShadow {
            anchors.fill: parent.contentItem
            source: parent.contentItem
            horizontalOffset: 0; verticalOffset: 2
            radius: 3.0
            samples: 9
            color: "black"
            z: -1
        }
    }

    states: [
        State {
            name: "IMAGE"
            PropertyChanges { target: _info; y: root.height - 113 }
            PropertyChanges { target: _infoBackground; opacity: 0.0 }
            PropertyChanges { target: _description; opacity: 0.0 }
        },
        State {
            name: "INFO"
            PropertyChanges { target: _info; y: 0 }
            PropertyChanges { target: _infoBackground; opacity: 0.76 }
            PropertyChanges { target: _description; opacity: 1.0 }
        }
    ]

    transitions: [
        Transition {
            from: "IMAGE"
            to: "INFO"
            reversible: true

            PropertyAnimation { properties: "x,y"; easing.type: Easing.OutCubic }
            PropertyAnimation { properties: "opacity"; easing.type: Easing.OutCubic }
        }
    ]
}

