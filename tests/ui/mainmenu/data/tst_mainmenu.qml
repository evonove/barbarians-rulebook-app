import QtQuick 2.7
import QtTest 1.1

import "qrc:/qml"

TestCase {
    id: testCase
    width: 400; height: 400
    visible: true
    name: "MainMenu"

    SignalSpy {
        id: spy
        target: mainMenu
    }

    MainMenu {
        id: mainMenu
        anchors.fill: parent
    }

    function test_buttons_emit_signal_data() {
        return [
            {tag: "volume button", signalName: "volumeClicked", buttonName: "_volumeButton"},
            {tag: "game setup button", signalName: "gameSetupClicked", buttonName: "_gameSetupButton"},
            {tag: "rulebook button", signalName: "rulebookClicked", buttonName: "_rulebookButton"},
            {tag: "artwork button", signalName: "artworkClicked", buttonName: "_artworkButton"},
            {tag: "ost button", signalName: "ostClicked", buttonName: "_ostButton"},
        ];
    }

    // Verifies that clicking on button the proper signal is emitted
    function test_buttons_emit_signal(data) {
        spy.signalName = data.signalName;
        // get the button
        var button = findChild(mainMenu, data.buttonName);
        compare(spy.count, 0);
        button.clicked();
        compare(spy.count, 1);
        spy.clear();
    }

    // Verifies that volume button changes icon based on the musicIsPlaying property
    function test_volume_button_change_icon() {
        mainMenu.musicIsPlaying = true;
        // get the button
        var button = findChild(mainMenu, "_volumeButton");
        compare(button.text, button.volumeOn);
        // switch off the music
        mainMenu.musicIsPlaying = false;
        compare(button.text, button.volumeOff);
    }
}
