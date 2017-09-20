import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3


Page {
    id: root

    /* This property changes the icon shown
     * by the volume button at the bottom
     * of the page. */
    property bool musicIsPlaying: true

    /* These signals are emitted when the menu buttons are clicked
     * so that we can connect proper action outside of this page */
    signal gameSetupClicked()
    signal rulebookClicked()
    signal artworkClicked()
    signal ostClicked()
    signal volumeClicked()

    padding: 0

    font.weight: Font.DemiBold

    background: Image {
        anchors.fill: root
        source: "qrc:/assets/splash-logo-bg.jpg"
        fillMode: Image.PreserveAspectCrop

        horizontalAlignment: Image.AlignHCenter
        verticalAlignment: Image.AlignTop
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Item {
            Layout.alignment: Qt.AlignTop | Qt.AlignCenter
            Layout.preferredHeight: Math.floor(parent.height / 3)
            Layout.fillHeight: false
            Layout.fillWidth: true
        }

        ColumnLayout {
            spacing: 16

            Layout.alignment: Qt.AlignTop | Qt.AlignCenter
            Layout.fillHeight: true

            Button {
                id: _gameSetupButton
                objectName: "_gameSetupButton"
                text: qsTr("Game Setup")

                Layout.alignment: Qt.AlignCenter
                Layout.preferredWidth: 150

                Material.foreground: Material.color(Material.Grey, Material.Shade900)
                Material.background: Material.Amber
            }
            Button {
                id: _rulebookButton
                objectName: "_rulebookButton"
                text: qsTr("Rulebook")

                Layout.alignment: Qt.AlignCenter
                Layout.preferredWidth: 150

                Material.foreground: Material.color(Material.Grey, Material.Shade900)
                Material.background: Material.Amber
            }
            Button {
                id: _artworkButton
                objectName: "_artworkButton"
                text: qsTr("Artwork")

                Layout.alignment: Qt.AlignCenter
                Layout.preferredWidth: 150

                Material.foreground: Material.color(Material.Grey, Material.Shade900)
                Material.background: Material.Amber
            }
            Button {
                id: _ostButton
                objectName: "_ostButton"
                text: qsTr("OST")

                Layout.alignment: Qt.AlignCenter
                Layout.preferredWidth: 150

                Material.foreground: Material.color(Material.Grey, Material.Shade900)
                Material.background: Material.Amber
            }
        }
    }

    /* This is the mute/unmute button used to control
     * the OST player
     */
    RoundButton {
        id: _volumeButton
        objectName: "_volumeButton"

        readonly property string volumeOn: "\uE050"
        readonly property string volumeOff: "\uE04F"

        width: 56; height: 56

        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 16

        text: root.musicIsPlaying ? volumeOn : volumeOff

        font.family: "Material Icons"
        font.pixelSize: 24

        Material.foreground: Material.color(Material.Amber, Material.Shade200)
        Material.background: Material.color(Material.Brown, Material.Shade500)
    }

    Component.onCompleted: {
        _volumeButton.clicked.connect(root.volumeClicked);
        _gameSetupButton.clicked.connect(root.gameSetupClicked);
        _rulebookButton.clicked.connect(root.rulebookClicked);
        _artworkButton.clicked.connect(root.artworkClicked);
        _ostButton.clicked.connect(root.ostClicked);
    }
}
