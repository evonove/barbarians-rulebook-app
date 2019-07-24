import QtQuick 2.7
import QtQuick.Controls 2.2

import QtMultimedia 5.8

import System 1.0


ApplicationWindow {
    id: root
    visible: true
    width: 375
    height: 667
    title: qsTr("Barbarians Rulebook")
    flags: Qt.Window | Qt.MaximizeUsingFullscreenGeometryHint

    FontLoader {
        source: "qrc:/fonts/MaterialIcons-Regular.ttf"
    }

    // A top margin added to various components so that they're not covered
    // by the iPhone top notch
    property real safeTopMargin: 0
    property real safeBottomMargin: 0

    Component.onCompleted: {
        let margins = System.getSafeAreaMargins(root)
        root.safeTopMargin =  margins.top
        root.safeBottomMargin = margins.bottom
    }

    onActiveFocusControlChanged: console.debug("current focus", activeFocusControl)

    StackView {
        id: _stackView
        anchors.fill: parent
        focus: true

        Keys.forwardTo: [_stackView.currentItem]
        Keys.onPressed: {
            console.log("main", event);
            if (event.key === Qt.Key_Escape || event.key === Qt.Key_Back) {
                if (_stackView.depth > 1) {
                    _stackView.pop();
                    event.accepted = true;
                }
            }
        }

        initialItem: MainMenu {
            safeBottomMargin: root.safeBottomMargin
            safeTopMargin: root.safeTopMargin

            musicIsPlaying: _player.playbackState === Audio.PlayingState

            onRulebookClicked: _stackView.push(_rulebook)
            onGameSetupClicked: _stackView.push(_gameSetup)
            onArtworkClicked: _stackView.push(_artwork)
            onOstClicked: _stackView.push(_ost)
            onInfoClicked: _stackView.push(_info)

            onVolumeClicked: _player.playbackState === Audio.PlayingState ? _player.pause() : _player.play()
        }

        Component {
            id: _rulebook
            Rulebook {
                rulebookUrl: baseUrl
                safeBottomMargin: root.safeBottomMargin
                safeTopMargin: root.safeTopMargin
            }
        }

        Component {
            id: _gameSetup
            GameSetup {
                safeBottomMargin: root.safeBottomMargin
                safeTopMargin: root.safeTopMargin
            }
        }

        Component {
            id: _artwork
            Artwork {
                safeBottomMargin: root.safeBottomMargin
                safeTopMargin: root.safeTopMargin
            }
        }

        Component {
            id: _ost
            OriginalSoundTrack {
                safeBottomMargin: root.safeBottomMargin
                safeTopMargin: root.safeTopMargin

                player: _player
            }
        }

        Component {
            id: _info
            Credits {
                safeBottomMargin: root.safeBottomMargin
                safeTopMargin: root.safeTopMargin
            }
        }
    }

    Audio {
        id: _player;
        autoPlay: true

        playlist: Playlist {
            id: _playlist

            playbackMode: Playlist.Loop

            PlaylistItem { source: "/music/01_marcia_barbari.mp3"; }
            PlaylistItem { source: "/music/02_coro_barbari.mp3"; }

        }

        /* This model contains metadata about the playlist item.
         * This is a workaround because the Playlist and PlaylistItem items
         * APIs are limited, and it is hard to get additional info other
         * than the `source`.
         */
        property ListModel metadata: ListModel {
            ListElement { title: "The March of Barbarians"; duration: 368040 }
            ListElement { title: "Barbarians' Choir"; duration: 314880 }
        }

        onError: console.error(error, errorString)
    }

}
