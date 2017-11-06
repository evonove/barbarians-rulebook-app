import QtQuick 2.7
import QtWebView 1.1

WebView {
    id: root

    property int elementsFound: 0
    property int currentElement: 0

    Keys.onPressed: console.log("rulebook", event, event.text)

    function init() {
        root.elementsFound = 0;
        root.currentElement = 0;

        root.runJavaScript("init()");
        console.debug("search init call");
    }

    function find(text) {
        root.runJavaScript("find('%1')".arg(text), function(result) {
            console.debug("search find call", result);

            root.elementsFound = result;
        });
        root.runJavaScript("current()", function(result) {
            root.currentElement = result + 1;
        });
    }

    function next() {
        root.runJavaScript("next()", function(result) {
            console.debug("search next call", result);

            root.currentElement = result + 1;
        });
    }

    function prev() {
        root.runJavaScript("prev()", function(result) {
            console.debug("search prev call", result);

            root.currentElement = parseInt(result) + 1;
        });
    }
}
