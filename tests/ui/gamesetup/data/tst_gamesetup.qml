import QtQuick 2.7
import QtQuick.Controls 2.2
import QtTest 1.1

import "qrc:/qml"

TestCase {
    id: testCase
    width: 400; height: 400
    visible: true
    name: "GameSetup"
    when: windowShown

    SignalSpy {
        id: spy
        signalName: "loaded"
    }

    StackView {
        id: stack
        anchors.fill: parent
        initialItem: Page { objectName: "page" }
    }

    Component {
        id: gameSetup

        GameSetup { objectName: "gameSetup" }
    }


    // Verifies that the back button pops the gamesetup page from the stack
    function test_back_button_pops_from_stack_view() {
        stack.push(gameSetup);
        compare(stack.currentItem.objectName, "gameSetup");
        // get the back button and click on it
        var backButton = findChild(stack.currentItem, "_backButton");
        backButton.clicked();
        compare(stack.currentItem.objectName, "page");
    }

    // Verify that clicking on step button changes current step
    function test_step_clicked_moves_current_step() {
        stack.push(gameSetup);
        // here we wait for the asynchronous loader to finish
        // otherwise we won't find the child "_five"
        var loader = findChild(stack.currentItem, "_mapLoader");
        spy.target = loader
        spy.wait(2000);
        var stepFive = findChild(stack.currentItem, "_five");
        stepFive.clicked();
        compare(stack.currentItem.currentIndex, 5);
        stack.pop();
    }

    // Verify prev button moves back
    function test_prev_button_moves_backward() {
        stack.push(gameSetup);
        // here we wait for the asynchronous loader to finish
        // otherwise we won't find the child "_five"
        var loader = findChild(stack.currentItem, "_mapLoader");
        spy.target = loader
        spy.wait(2000);
        var stepFive = findChild(stack.currentItem, "_five");
        stepFive.clicked();
        compare(stack.currentItem.currentIndex, 5);
        // press prev button to go to page 4
        var prevButton = findChild(stack.currentItem, "_prevButton");
        prevButton.clicked();
        compare(stack.currentItem.currentIndex, 4);
        // clean up
        spy.clear()
        stack.pop();
    }

    // Verify next button moves forward
    function test_next_button_moves_forward() {
        stack.push(gameSetup);
        // here we wait for the asynchronous loader to finish
        // otherwise we won't find the child "_five"
        var loader = findChild(stack.currentItem, "_mapLoader");
        spy.target = loader
        spy.wait(2000);
        var stepFive = findChild(stack.currentItem, "_five");
        stepFive.clicked();
        compare(stack.currentItem.currentIndex, 5);
        // press next button to go to page 6
        var nextButton = findChild(stack.currentItem, "_nextButton");
        nextButton.clicked();
        compare(stack.currentItem.currentIndex, 6);
        // clean up
        spy.clear()
        stack.pop();
    }
}
