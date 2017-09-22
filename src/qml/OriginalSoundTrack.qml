import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3

import QtMultimedia 5.8


Page {
    id: root

    // Material Icons needed by this page
    readonly property string apps: "\uE5C3"
    readonly property string skipPrevious: "\uE045"
    readonly property string skipNext: "\uE044"
    readonly property string pause: "\uE034"
    readonly property string playArrow: "\uE037"

    /* The audio player used to reproduce music */
    property Audio player: null

    background: Image {
        anchors.fill: root
        asynchronous: true
        cache: true
        source: "qrc:/assets/ost-background.jpg"
        fillMode: Image.PreserveAspectCrop

        horizontalAlignment: Image.AlignHCenter
        verticalAlignment: Image.AlignTop
    }

    header: ToolBar {
       leftPadding: 16

        RowLayout {
            anchors.fill: parent
            spacing: 0

            Label {
                text: qsTr("Soundtrack")
                elide: Text.ElideRight

                font.weight: Font.Medium
                font.pixelSize: 20
            }

            Item {
                Layout.fillWidth: true
            }

            ToolButton {
                objectName: "_backButton"
                text: root.apps
                onClicked: root.StackView.view.pop()

                font.family: "Material Icons"
                font.pixelSize: 24
            }
        }
    }


    /* The list of currently available tracks */
    ListView {
        anchors.fill: parent

        model: root.player.playlist
        delegate: ItemDelegate {
            // an item is `playing` when it is the current item and the player is
            // in PlayingState
            readonly property bool playing: model.source === root.player.playlist.currentItemSource &&
                                            root.player.playbackState === Audio.PlayingState

            width: parent.width
            highlighted: model.source === root.player.playlist.currentItemSource

            // Getting the title from the special metadata property. See `main.qml` for more details.
            text: root.player.metadata.get(index).title

            Material.theme: Material.Dark

            onClicked: {
                if (playing) {
                    // When this item is playing we just pause it
                    root.player.pause()
                } else {
                    // otherwise we clicked on another item so we change the index
                    // and call play on the player just to be sure
                    root.player.playlist.currentIndex = index;
                    root.player.play();
                }
            }

            ToolButton {
                anchors.right: parent.right
                text: playing ? root.pause : root.playArrow

                font.family: "Material Icons"
                font.pixelSize: 24

                onClicked: parent.clicked()
            }
        }
    }

    footer: ToolBar {
        leftPadding: 16

        RowLayout {
            anchors.fill: parent

            /* The label shows the title of the current selected track on the playlist
             * Title is found in the special metadata property in the player instance.
             * See `main.qml` for more details.
             */
            Label {
                text: root.player.metadata.get(root.player.playlist.currentIndex).title
                elide: Text.ElideRight
            }

            Item { Layout.fillWidth: true }

            ToolButton {
                text: root.skipPrevious

                font.family: "Material Icons"
                font.pixelSize: 24

                onClicked: root.player.playlist.previous()
            }
            ToolButton {
                text: root.player.playbackState === Audio.PlayingState ? root.pause : root.playArrow

                font.family: "Material Icons"
                font.pixelSize: 24

                onClicked: root.player.playbackState === Audio.PlayingState ? root.player.pause() : root.player.play()
            }
            ToolButton {
                text: root.skipNext

                font.family: "Material Icons"
                font.pixelSize: 24

                onClicked: root.player.playlist.next()
            }
        }
    }
}
