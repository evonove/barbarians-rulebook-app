import QtQuick 2.7
import QtQuick.Controls 2.2

import QtMultimedia 5.8


ApplicationWindow {
    visible: true
    width: 360
    height: 640
    title: qsTr("Barbarians Rulebook")

    FontLoader {
        source: "qrc:/fonts/MaterialIcons-Regular.ttf"
    }

    StackView {
        id: _stackView
        anchors.fill: parent

        initialItem: MainMenu {
            musicIsPlaying: _player.playbackState === Audio.PlayingState

            onRulebookClicked: _stackView.push(_rulebook)
            onGameSetupClicked: _stackView.push(_gameSetup)
            onOstClicked: _stackView.push(_ost)

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
            id: _ost
            OriginalSoundTrack { player: _player }
        }
    }

    Audio {
        id: _player;
        autoPlay: true

        playlist: Playlist {
            id: _playlist

            playbackMode: Playlist.Loop

            PlaylistItem { source: "qrc:/music/song1.mp3"; }
            PlaylistItem { source: "qrc:/music/song2.mp3"; }
            PlaylistItem { source: "qrc:/music/song3.mp3"; }
        }

        /* This model contains metadata about the playlist item.
         * This is a workaround because the Playlist and PlaylistItem items
         * APIs are limited, and it is hard to get additional info other
         * than the `source`.
         */
        property ListModel metadata: ListModel {
            ListElement { title: "Song 1" }
            ListElement { title: "Song 2" }
            ListElement { title: "Song 3" }
        }

        onError: console.error(error, errorString)
    }

}
