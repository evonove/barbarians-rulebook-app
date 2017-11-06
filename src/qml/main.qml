import QtQuick 2.7
import QtQuick.Controls 2.2

import QtMultimedia 5.8


ApplicationWindow {
    visible: true
    width: 375
    height: 667
    title: qsTr("Barbarians Rulebook")

    FontLoader {
        source: "qrc:/fonts/MaterialIcons-Regular.ttf"
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
            Rulebook { rulebookUrl: baseUrl }
        }

        Component {
            id: _gameSetup
            GameSetup { }
        }

        Component {
            id: _artwork
            Artwork { }
        }

        Component {
            id: _ost
            OriginalSoundTrack { player: _player }
        }

        Component {
            id: _info
            Credits { }
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
