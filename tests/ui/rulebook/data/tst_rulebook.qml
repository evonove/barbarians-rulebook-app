import QtQuick 2.7
import QtQuick.Controls 2.2
import QtTest 1.1

import "qrc:/qml"

TestCase {
    id: testCase
    width: 400; height: 400
    visible: true
    name: "RuleBook"

    StackView {
        id: stack
        initialItem: Page { objectName: "page" }
    }

    Component {
        id: rulebook

        Rulebook { objectName: "rulebook" }
    }


    // Verifies that the back button pops the rulebook page from the stack
    function test_back_button_pops_from_stack_view() {
        stack.push(rulebook);
        compare(stack.currentItem.objectName, "rulebook");
        // get the back button and click on it
        var backButton = findChild(stack.currentItem, "_backButton");
        backButton.clicked();
        compare(stack.currentItem.objectName, "page");
    }
}
