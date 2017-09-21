import QtQuick 2.7


ListModel {
    ListElement {
        title: qsTr("1. Gameboard")
        image: "qrc:/assets/steps/wizard-1.png"
        content: "Place the gameboard in the center of the table.<br/>
<img src='qrc:/assets/steps/wizard-1-internal.png' width=%1 /><br/><br/>
Assemble the Volcano and place it in the indicated space on the gameboard.<br/><br/>
<img src='qrc:/assets/steps/wizard-1-internal2.png' width=%1 /><br/><br/>
Each cardboard ring is divided into 6 sectors; position each ring randomly,
in such a way that each sector is linked to two sectors of the successive ring.
"
    }

    ListElement {
        title: qsTr("2. Map")
        image: "qrc:/assets/steps/wizard-2.png"
        content: "Set up the map.<br/>
Place one First Conquer tile on each island.<br/>
Randomly place the faction tokens in each region on the map, excluding the starting one.<br/><br/>
In a 3-player game: return to the gamebox the faction tokens in the regions marked “4+”.<br/><br/>
In a 2-player game: return to the gamebox the faction tokens in the regions marked “3+” and “4+”.
"
    }

    ListElement {
        title: qsTr("3. Region Decks")
        image: "qrc:/assets/steps/wizard-3.png"
        content: "Sort the 72 Region cards into 4 decks by color.<br/><br/>
Shuffle each deck and place them face-down.
"
    }

    ListElement {
        title: qsTr("4. Gods, Warchiefs and Buildings Cards")
        image: "qrc:/assets/steps/wizard-4.png"
        content: "Sort the God, Warchief and Building cards by type. <br/>
Shuffle each deck and place them face-down. <br/>
Reveal the first two God and Warchief cards, and the first four Building cards to form the display area.
"
    }

    ListElement {
        title: qsTr("5. Demons and Feasts Cards")
        image: "qrc:/assets/steps/wizard-5.png"
        content: "Shuffle the Demon cards and place one randomly, face-up in each corresponding slot of the Timeline. <br/>
Shuffle the Feast cards and place one randomly, face-up in each corresponding slot of the Timeline.<br/>
Return the leftover Demon and Feast cards to the gamebox.
"
    }

    ListElement {
        title: qsTr("6. Player Gameboard")
        image: "qrc:/assets/steps/wizard-6.png"
        content: "Each player chooses a color and takes all the following in their color:
<ul>
<li>Player gameboard.</li>
<li>Set of Resource tokens, which they place in the corresponding resource spaces, marked ‘3’. </li>
<li>Set of Troop tokens, which they place in the corresponding troop spaces, marked ‘2’.</li>
<li>Set of 4 Champions and 8 Banners. </li>
<li>Domination point counter, which they place in the starting space of the Domination point track. Use this counter to keep track of Domination points. </li>
</ul>
<em>Note: During the game you can go lower than 0 Domination points, and you can also go higher than 100 Domination points.</em><br/><br/>
<b>Only in a 2-player game:</b>
<ul>
<li>Take the Champions of the two non-player colors, and:</li>
<li>Place the Champions of a non-player color on four random action spaces of the Volcano, one in each ring.</li>
<li>Now place the Champions of the other non-player color on the four action spaces opposite to the action spaces of the first non-player Champions.</li>
<li>At the end of the 3rd Phase of each Era, move all the non-player Champions clockwise 1 step.</li>
</ul>
"
    }

    ListElement {
        title: qsTr("7. Gods and Domination Points")
        image: "qrc:/assets/steps/wizard-7.png"
        content: "Each player takes a random God card from the deck and keeps it face up.<br/>
The player then advances their Domination point counter by the amount indicated on the top-right corner of their God card.
"
    }

    ListElement {
        title: qsTr("8. Honor Track")
        image: "qrc:/assets/steps/wizard-8.png"
        content: "Randomly stack the Honor track counters on the starting space of the Honor track.<br/>
This track indicates player order. The player whose counter is in the lead plays first. In the case that two or more players are tied (as in the start of the game) follow the order of the counters from the top of the stack to the bottom.
"
    }

    ListElement {
        title: qsTr("9. Knowledge")
        image: "qrc:/assets/steps/wizard-9.png"
        content: "To complete the setup: starting from the last player on the Honor track, each player can either place 2 of their Knowledge discs in the leftmost space of two different Knowledge tracks or 1 disc in the second space of a single Knowledge track.<br/><br/>
<em>Note: only in the Set Up, players cannot place a disc in a track where another player is already present.</em>
"
    }
}
