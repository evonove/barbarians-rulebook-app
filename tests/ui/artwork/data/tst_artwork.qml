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
        var backButton = findChild(stack.currentItem, "_menuButton");
        backButton.clicked();
        compare(stack.currentItem.objectName, "page");
    }
}
