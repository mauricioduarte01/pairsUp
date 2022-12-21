/*
 * Copyright (C) 2022  Mauricio Duarte
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * apptest is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.7
import Ubuntu.Components 1.3
//import QtQuick.Controls 2.2
import "utils.js" as Util
import QtMultimedia 5.12

Page {
    id: wrapper
    property int lastIndex : -1
    property int card1: -1
    property int remaining: Math.round(repeater.model / 2)

    header: PageHeader { visible: false }

    /* define the number of columns depending on the device xy orientation */
    property int n_columns: height > width ? 2 : 4
    property int n_rows: height > width ? 4 : 2
    /* grid auto-resize to keep aspect ratio */
    property int card_size: Math.min (width / n_columns, height / n_rows) * 0.9
    /* spacing between cards */
    property int card_xspacing: (width - card_size * n_columns) / (n_columns + 1)
    property int card_yspacing: (height - card_size * n_rows) / (n_rows + 1)

    /* how many different cards we have */
    property int imageCount: 4

    property int repeatCount: (repeater.model > imageCount)
                              ? repeater.model / imageCount : 1
    property var imageIndexes: Util.generateCardIndexes(imageCount, repeatCount)

    //        Image {
    //            id: bgd1
    ////            fillMode: Image.Tile
    //            anchors.fill: parent
    //            source: "qrc:/assets/bgd1.png"
    //            opacity: 0.8
    //            z: -1
    //        }

    Grid {
        id: grid
        x: wrapper.card_xspacing
        y: wrapper.card_yspacing
        columns: wrapper.n_columns
        rows: wrapper.n_rows

        columnSpacing: wrapper.card_xspacing
        rowSpacing: wrapper.card_yspacing

        Repeater {
            id: repeater
            model: 8

            delegate: Card {
                height: wrapper.card_size
                width: wrapper.card_size
                imageSource: "../assets/card2_" + wrapper.imageIndexes[index] + ".svg"
                onFinished: wrapper.verify(index)
            }
        }
    }
    function verify(index) {
        var currentItem = repeater.itemAt(index);
        var lastItem = repeater.itemAt(card1)
        while(card1 < 0) {
            card1 = index
            return
        }

        //var currentItem = repeater.itemAt(index)
        //var lastItem = repeater.itemAt(card1)

        /* if current card is the same as the last card, remove cards from grid */
        /* if currend card is the same as the last card, face up and count as a match */
        if(currentItem.imageSource === lastItem.imageSource) {
            --remaining;

            if (remaining === 0) {
                end_game_timer.start ();
            }
        }

        /* if there is no match, turn down again */
        else if (currentItem.imageSource !== lastItem.imageSource){
            currentItem.flipped = false     // volver a girar las cartas
            lastItem.flipped = false
        }
        return card1 = -1
    }

    function reset () {
        pageStack.push(Qt.resolvedUrl("L4.qml"))
    }

    Timer {
        id: end_game_timer
        interval: 2000
        signal done ()
        onTriggered: {
            var card0 = repeater.itemAt(0)
            card0.flipped = false
            card0.enabled = false

            flip_timer0.start ()
        }
    }

    Timer {
        id: flip_timer0
        interval: 100
        signal done ()
        onTriggered: {
            var card1 = repeater.itemAt(1)
            card1.flipped = false
            card1.enabled =false

            var card2 = repeater.itemAt(2)
            card2.flipped = false
            card2.enabled = false
            flip_timer1.start ()
        }
    }
    Timer {
        id: flip_timer1
        interval: 100
        signal done ()
        onTriggered: {
            var card3 = repeater.itemAt(3)
            card3.flipped = false
            card3.enabled =false

            var card4 = repeater.itemAt(4)
            card4.flipped = false
            card4.enabled = false
            flip_timer2.start ()
        }
    }

    Timer {
        id: flip_timer2
        interval: 100
        signal done ()
        onTriggered: {
            var card5 = repeater.itemAt(5)
            card5.flipped = false
            card5.enabled = false

            var card6 = repeater.itemAt(6)
            card6.flipped = false
            card6.enabled = false

            var card7 = repeater.itemAt(7)
            card7.flipped = false
            card7.enabled = false
            resetTimer.start()
        }
    }

    Timer {
        id: resetTimer
        interval: 750
        onTriggered: {
            reset()
        }
    }
}

