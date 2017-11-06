import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3


/* An index to easily navigate through sections in the rulebook page.
 */
Page {
    id: root

    /* This signal is emitted when a user clicks on the item delegate.
     * The fragment argument is used to navigate to the section in the
     * html document. See Rulebook page component. */
    signal itemClicked(string fragment)

    header: ToolBar {
        id: _header

        readonly property string navigateBefore: "\uE408"

        font.family: "Material Icons"
        font.pixelSize: 24

        RowLayout {
            anchors.fill: parent

            ToolButton {
                objectName: "_backButton"

                text: _header.navigateBefore
                onClicked: root.StackView.view.pop()
            }
        }
    }

    ListView {
        objectName: "_indexList"
        anchors.fill: parent
        model: _indexModel

        delegate: ItemDelegate {
            width: parent.width
            text: model.title

            // These lines defines a different style for the
            // elements with level "top"
            leftPadding: model.level === "top" ? 16 : 32
            font.weight: model.level === "top" ? Font.DemiBold : Font.Normal
            font.pixelSize: model.level === "top" ? 16 : 13

            onClicked: {
                root.itemClicked(model.fragment);
                root.StackView.view.pop();
            }
        }
    }

    ListModel {
        id: _indexModel

        ListElement { title: qsTr("Introduction"); level: "top"; fragment: "#introduction" }
        ListElement { title: qsTr("Goal Of Game"); level: "sub"; fragment: "#goal_of_game" }

        ListElement { title: qsTr("Game Flow"); level: "top"; fragment: "#game_flow" }

        ListElement { title: qsTr("1st Phase: Maintenance"); level: "top"; fragment: "#maintenance" }

        ListElement { title: qsTr("2nd Phase: Action"); level: "top"; fragment: "#action" }
        ListElement { title: qsTr("Gaining Resources"); level: "sub"; fragment: "#gaining_resources" }
        ListElement { title: qsTr("Erect Building"); level: "sub"; fragment: "#erect_building" }
        ListElement { title: qsTr("Invoke"); level: "sub"; fragment: "#invoke" }
        ListElement { title: qsTr("War"); level: "sub"; fragment: "#war" }
        ListElement { title: qsTr("Knowledge"); level: "sub"; fragment: "#knowledge" }
        ListElement { title: qsTr("Other Actions"); level: "sub"; fragment: "#other_actions" }
        ListElement { title: qsTr("Trade Actions"); level: "sub"; fragment: "#trade_actions" }

        ListElement { title: qsTr("3rd Phase: End Era"); level: "top"; fragment: "#end_era" }
        ListElement { title: qsTr("Demon Card"); level: "sub"; fragment: "#demon_card" }
        ListElement { title: qsTr("Feast Card"); level: "sub"; fragment: "#feast_card" }
        ListElement { title: qsTr("Final Event"); level: "sub"; fragment: "#final_event" }

        ListElement { title: qsTr("Game End"); level: "top"; fragment: "#game_end" }
        ListElement { title: qsTr("Final Scoring"); level: "sub"; fragment: "#final_scoring" }

        ListElement { title: qsTr("Variant"); level: "top"; fragment: "#variant" }

        ListElement { title: qsTr("Components"); level: "top"; fragment: "#components" }

        ListElement { title: qsTr("Hunt Expansion"); level: "top"; fragment: "#hunt_expansion" }
        ListElement { title: qsTr("Hunt Introduction"); level: "sub"; fragment: "#hunt_introduction" }
        ListElement { title: qsTr("Hunt Setup"); level: "sub"; fragment: "#hunt_setup" }
        ListElement { title: qsTr("Hunt New Actions"); level: "sub"; fragment: "#hunt_new_actions" }
        ListElement { title: qsTr("Hunt"); level: "sub"; fragment: "#hunt" }
        ListElement { title: qsTr("Beast And Monsters"); level: "sub"; fragment: "#beast_and_monsters" }
        ListElement { title: qsTr("Magma Tokens"); level: "sub"; fragment: "#magma_tokens" }

        ListElement { title: qsTr("Additional Modules"); level: "top"; fragment: "#additional_modules" }
        ListElement { title: qsTr("Personal Objectives"); level: "sub"; fragment: "#personal_objectives" }
        ListElement { title: qsTr("Special Buildings"); level: "sub"; fragment: "#special_buildings" }
        ListElement { title: qsTr("Havoc Maker Tokens"); level: "sub"; fragment: "#havoc_maker_tokens" }
        ListElement { title: qsTr("Additional Demons and Feasts"); level: "sub"; fragment: "#additional_demons_feasts" }
        ListElement { title: qsTr("Kickstarter Exclusive Map"); level: "sub"; fragment: "#kickstarter_map" }

        ListElement { title: qsTr("One Player Rules"); level: "top"; fragment: "#one_player_rules" }
        ListElement { title: qsTr("Setup"); level: "sub"; fragment: "#one_player_setup" }
        ListElement { title: qsTr("Game Flow"); level: "sub"; fragment: "#one_player_game_flow" }
        ListElement { title: qsTr("Game End"); level: "sub"; fragment: "#one_player_game_end" }
        ListElement { title: qsTr("Special Rules"); level: "sub"; fragment: "#one_player_special_rules" }

        ListElement { title: qsTr("Expansion Components"); level: "top"; fragment: "#expansion_components" }

        ListElement { title: qsTr("Reference"); level: "top"; fragment: "#reference" }
        ListElement { title: qsTr("Cards Reference"); level: "top"; fragment: "#cards_reference" }

        ListElement { title: qsTr("Credits"); level: "top"; fragment: "#credits" }
    }
}
