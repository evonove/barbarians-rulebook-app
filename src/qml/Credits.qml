import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3


Page {
    id: root

    // Material Icons needed by this page
    readonly property string menu: "\uE5D2"

    padding: 16


    header: ToolBar {
        RowLayout {
            anchors.fill: parent
            spacing: 0

            Label {
                text: qsTr("Info")
                elide: Text.ElideRight

                font.weight: Font.Medium
                font.pixelSize: 20

                Layout.leftMargin: 16
            }

            Item {
                Layout.fillWidth: true
            }

            ToolButton {
                objectName: "_backButton"
                text: root.menu
                onClicked: root.StackView.view.pop()

                font.family: "Material Icons"
                font.pixelSize: 24
            }
        }
    }

    background: Image {
        anchors.fill: root
        asynchronous: true
        cache: true
        source: "qrc:/assets/info/background.jpg"
        fillMode: Image.PreserveAspectCrop

        horizontalAlignment: Image.AlignHCenter
        verticalAlignment: Image.AlignTop
    }

    ColumnLayout {
        id: _layout
        anchors.fill: parent

        // Late pledge section
        Column {
            Layout.fillWidth: true
            spacing: 16

            Label {
                width: parent.width
                text: qsTr("Are you interested in more Barbarians game's stuff?")
                horizontalAlignment: Text.AlignHCenter

                wrapMode: Text.Wrap
                font.pixelSize: 16
            }
            Button {
                text: qsTr("Late Pledge")
                anchors.horizontalCenter: parent.horizontalCenter
                font.weight: Font.DemiBold

                onClicked: Qt.openUrlExternally("https://app.crowdox.com/projects/tabulagames/barbarians-the-invasion")

                Material.foreground: Material.color(Material.Grey, Material.Shade900)
                Material.background: Material.color(Material.Amber, Material.Shade200)
            }
        }

        // newsletter link
        Column {
            Layout.fillWidth: true
            spacing: 16

            Label {
                width: parent.width
                text: qsTr("Are you interested in Barbarians?<br/>Subscribe to our newsletter")
                textFormat: Text.RichText

                horizontalAlignment: Text.AlignHCenter

                wrapMode: Text.Wrap
                font.pixelSize: 16
            }
            Button {
                text: qsTr("Newsletter")
                anchors.horizontalCenter: parent.horizontalCenter
                flat: true
                font.weight: Font.DemiBold
                onClicked: Qt.openUrlExternally("https://tabula.games/newsletter/")

                Material.foreground: Material.color(Material.Amber, Material.Shade200)
            }
        }

        Column {
            Layout.fillWidth: true
            spacing: 16

            Label {
                width: parent.width
                text: qsTr("Game produced by")
                horizontalAlignment: Text.AlignHCenter

                wrapMode: Text.Wrap
                font.pixelSize: 16
            }

            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                source: "/assets/info/tabula-logo.png"
                width: 200; height: 50
                fillMode: Image.PreserveAspectFit
                smooth: false

                MouseArea {
                    anchors.fill: parent
                    onClicked: Qt.openUrlExternally("https://tabula.games")
                }
            }

            Label {
                width: parent.width
                text: qsTr("App designed and Developed by")
                horizontalAlignment: Text.AlignHCenter

                wrapMode: Text.Wrap
                font.pixelSize: 16
            }

            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                source: "/assets/info/evonove-logo.png"
                width: 200; height: 50
                fillMode: Image.PreserveAspectFit
                smooth: false

                MouseArea {
                    anchors.fill: parent
                    onClicked: Qt.openUrlExternally("https://evonove.it")
                }
            }
        }
    }

}
