import QtQuick 2.7
import QtTest 1.1

import "qrc:/qml"

TestCase {
    id: testCase
    width: 400; height: 400
    visible: true
    name: "GameSetupMap"

    SignalSpy {
        id: spy
        target: gameSetupMap
    }

    GameSetupMap {
        id: gameSetupMap
        anchors.fill: parent
    }

    function test_buttons_emit_signal_data() {
        return [
            {tag: "step 1 button", arg: 1, signalName: "stepClicked", buttonName: "_one"},
            {tag: "step 2 button", arg: 2, signalName: "stepClicked", buttonName: "_two"},
            {tag: "step 3 button", arg: 3, signalName: "stepClicked", buttonName: "_three"},
            {tag: "step 4 button", arg: 4, signalName: "stepClicked", buttonName: "_four"},
            {tag: "step 5 button", arg: 5, signalName: "stepClicked", buttonName: "_five"},
            {tag: "step 6 button", arg: 6, signalName: "stepClicked", buttonName: "_six"},
            {tag: "step 7 button", arg: 7, signalName: "stepClicked", buttonName: "_seven"},
            {tag: "step 8 button", arg: 8, signalName: "stepClicked", buttonName: "_eight"},
            {tag: "step 9 button", arg: 9, signalName: "stepClicked", buttonName: "_nine"},
        ];
    }

    // Verifies that clicking on button the proper signal is emitted
    function test_buttons_emit_signal(data) {
        spy.signalName = data.signalName;
        // get the button
        var button = findChild(gameSetupMap, data.buttonName);
        compare(spy.count, 0);
        button.clicked();
        compare(spy.count, 1);
        compare(spy.signalArguments[0][0], data.arg);
        spy.clear();
    }
}
