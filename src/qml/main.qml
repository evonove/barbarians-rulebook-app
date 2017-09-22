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
    }

    Audio {
        id: _player;
        autoPlay: true

        playlist: Playlist {
            id: _playlist
            PlaylistItem { source: "qrc:/music/song1.mp3"; }
            PlaylistItem { source: "qrc:/music/song2.mp3"; }
            PlaylistItem { source: "qrc:/music/song3.mp3"; }
        }
    }
}
