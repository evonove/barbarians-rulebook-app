import QtQuick 2.7
import QtTest 1.1

import "qrc:/qml"

TestCase {
    id: testCase
    width: 400; height: 400
    visible: true
    name: "RuleBookHeader"
    when: windowShown

    SignalSpy {
        id: spy
    }

    Component {
        id: headerComponent

        RulebookHeader {
            anchors.fill: parent
        }
    }

    function test_main_buttons_emit_signal_data() {
        return [
            {tag: "menu button", signalName: "menuButtonClicked", buttonName: "_menuButton"},
            {tag: "back button", signalName: "backButtonClicked", buttonName: "_backButton"},
        ];
    }

    function test_search_buttons_emit_signal_data() {
        return [
            {tag: "prev button", signalName: "prevButtonClicked", buttonName: "_prevButton"},
            {tag: "next button", signalName: "nextButtonClicked", buttonName: "_nextButton"},
        ];
    }

    // Verifies that clicking on buttons in the main toolbar
    // the proper signals are emitted
    function test_main_buttons_emit_signal(data) {
        var header = headerComponent.createObject(testCase);
        spy.target = header;
        spy.signalName = data.signalName;
        // get the button
        var button = findChild(header, data.buttonName);
        compare(spy.count, 0);
        button.clicked();
        compare(spy.count, 1);
        spy.clear();
        header.destroy();
    }

    // Verifies that clicking on button on the search
    // toolbar the proper signal is emitted
    function test_search_buttons_emit_signal(data) {
        var header = headerComponent.createObject(testCase);
        spy.target = header;
        // click on the search button to push the search toolbar on to the stack
        var searchButton = findChild(header, "_searchButton");
        searchButton.clicked();
        // get the button
        spy.signalName = data.signalName;
        var button = findChild(header, data.buttonName);
        compare(spy.count, 0);
        button.clicked();
        compare(spy.count, 1);
        spy.clear();
        // click on the search button to push the search toolbar on to the stack
        var closeSearchButton = findChild(header, "_closeSearchButton");
        closeSearchButton.clicked();
        header.destroy();
    }

    // Verifies that when search button is clicked
    // the search toolbar is pushed to the stack
    function test_search_toolbar_pushed() {
        var header = headerComponent.createObject(testCase);
        spy.target = header;
        // click on the search button to push the search toolbar on to the stack
        var searchButton = findChild(header, "_searchButton");
        searchButton.clicked();
        // get the stack view and check that the current item is the search header
        var headerStack = findChild(header, "_headerStack");
        compare(headerStack.currentItem.objectName, "_searchHeader");
        // click to pop the search toolbar
        var closeSearchButton = findChild(headerStack.currentItem, "_closeSearchButton");
        closeSearchButton.clicked();
        // check search toolbar has been popped
        compare(headerStack.currentItem.objectName, "");
        header.destroy();
    }

    function test_signal_is_emitted_for_search_and_close_buttons() {
        var header = headerComponent.createObject(testCase);
        spy.target = header;
        spy.signalName = "searchButtonClicked";
        // click on the search button to push the search toolbar on to the stack
        var searchButton = findChild(header, "_searchButton");
        compare(spy.count, 0);
        searchButton.clicked();
        compare(spy.count, 1);
        spy.clear();
        // click to pop the search toolbar
        spy.signalName = "closeSearchButtonClicked";
        var closeSearchButton = findChild(header, "_closeSearchButton");
        compare(spy.count, 0);
        closeSearchButton.clicked();
        compare(spy.count, 1);
        // cleaning
        spy.clear();
        header.destroy();
    }

    function test_search_text_changed_signal_is_emitted() {
        var header = headerComponent.createObject(testCase);
        spy.target = header;
        // click on the search button to push the search toolbar on to the stack
        var searchButton = findChild(header, "_searchButton");
        searchButton.clicked();
        // check signal is emitted when text changes
        spy.signalName = "searchTextChanged";
        var searchText = findChild(header, "_searchText");
        compare(spy.count, 0);
        searchText.textChanged();
        compare(spy.count, 1);
        // cleaning
        spy.clear();
        header.destroy();
    }

    // Verify that prev button and next button are disabled when total is 0
    function test_prev_next_button_disabled_enabled() {
        var header = headerComponent.createObject(testCase);
        // click on the search button to push the search toolbar on to the stack
        var searchButton = findChild(header, "_searchButton");
        searchButton.clicked();
        // get prev button and next button
        var prevButton = findChild(header, "_prevButton");
        var nextButton = findChild(header, "_nextButton");
        header.total = 0;
        compare(prevButton.enabled, false);
        compare(nextButton.enabled, false);
        header.total = 1;
        compare(prevButton.enabled, true);
        compare(nextButton.enabled, true);
        // cleaning
        header.destroy();
    }

    // Verify that label change depending on total and current properties
    function test_label_change_with_total_and_current() {
        var header = headerComponent.createObject(testCase);
        // click on the search button to push the search toolbar on to the stack
        var searchButton = findChild(header, "_searchButton");
        searchButton.clicked();
        // get search label
        var searchLabel = findChild(header, "_searchLabel");
        header.total = 1;
        header.current = 1;
        compare(searchLabel.text, "1 of 1");
        header.total = 10;
        header.current = 2;
        compare(searchLabel.text, "2 of 10");
        // cleaning
        header.destroy();
    }
}
