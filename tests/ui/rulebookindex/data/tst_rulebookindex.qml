import QtQuick 2.7
import QtQuick.Controls 2.2
import QtTest 1.1

import "qrc:/qml"

TestCase {
    id: testCase
    width: 400; height: 400
    visible: true
    name: "RuleBookIndex"

    SignalSpy {
        id: spy
        signalName: "itemClicked"
    }

    StackView {
        id: stack
        initialItem: Page { objectName: "page" }
    }

    Component {
        id: rulebookindex

        RulebookIndex { objectName: "index" }
    }

    // Verifies that the back button pops the rulebook index page from the stack
    function test_back_button_pops_rulebook_index() {
        stack.push(rulebookindex);
        compare(stack.currentItem.objectName, "index");
        // get the back button and click on it
        var backButton = findChild(stack.currentItem, "_backButton");
        backButton.clicked();
        compare(stack.currentItem.objectName, "page");
    }

    // Verifies that click on an item of the index emits signal and pops the
    // the rulebook index page from the stack
    function test_item_delegate_emit_signal() {
        stack.push(rulebookindex);
        compare(stack.currentItem.objectName, "index");
        spy.target = stack.currentItem;
        // get the index list
        var indexList = findChild(stack.currentItem, "_indexList");
        // set the goal of game item as current
        indexList.currentIndex = 1;
        // check signal is emitted when clicking on an item
        compare(spy.count, 0);
        indexList.currentItem.clicked();
        compare(spy.count, 1);
        compare(spy.signalArguments[0][0], "#goal_of_game");
        // check rulebook index page is popped
        compare(stack.currentItem.objectName, "page");
        // cleaning
        spy.clear();
    }
}
