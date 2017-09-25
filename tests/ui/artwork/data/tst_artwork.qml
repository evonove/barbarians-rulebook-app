import QtQuick 2.7
import QtQuick.Controls 2.2
import QtTest 1.1

import "qrc:/qml"


TestCase {
    id: testCase
    width: 400; height: 400
    visible: true
    name: "Artwork"
    when: windowShown

    StackView {
        id: stack
        anchors.fill: parent
        initialItem: Page { objectName: "page" }
    }

    Component {
        id: artwork

        Artwork { objectName: "artwork" }
    }


    // Verifies that the back button pops the gamesetup page from the stack
    function test_back_button_pops_from_stack_view() {
        stack.push(artwork);
        compare(stack.currentItem.objectName, "artwork");
        // get the back button and click on it
        var backButton = findChild(stack.currentItem, "_backButton");
        backButton.clicked();
        compare(stack.currentItem.objectName, "page");
    }

    // Verify next and prev buttons move forward and backward
    function test_next_and_prev_buttons_move_forward_and_backward() {
        stack.push(artwork);
        compare(stack.currentItem.currentStep, 0);
        // press next button
        var nextButton = findChild(stack.currentItem, "_nextButton");
        nextButton.clicked();
        compare(stack.currentItem.currentStep, 1);
        // press previous button
        var prevButton = findChild(stack.currentItem, "_prevButton");
        prevButton.clicked();
        compare(stack.currentItem.currentStep, 0);
        stack.pop();
    }
}
