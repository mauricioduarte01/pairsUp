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
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import "utils.js" as Util
import QtMultimedia 5.12

import Example 1.0


MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'apptest.md'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    property int lastIndex : -1
    property int card1: -1
    property int remaining: Math.round(repeater.model / 2)

    Component.onCompleted: wrapper

//    ListModel {
//        id: listModel

//        Component.onCompleted: {
//            fillData()
//        }

//        function fillData() {
//            var assetPath = "../assets/"
//            append ({})
//            append({"imageSource": assetPath + "card_" + wrapper.imageIndexes[index] + ".svg"})
//            append({"imageSource": assetPath + "card_" + wrapper.imageIndexes[index] + ".svg"})
//            append({"imageSource": assetPath + "card_" + wrapper.imageIndexes[index] + ".svg"})

//            append({"imageSource": assetPath + "cow.svg", color: "red" })
//            append({"imageSource": assetPath + "dog.svg", color: "blue"})
//            append({"imageSource": assetPath + "dog.svg", color: "blue"})
//            append({"imageSource": assetPath + "sheep.svg", color: "green"})
//            append({"imageSource": assetPath + "sheep.svg", color: "green"})
//        }
//    }

    Page {
        header: PageHeader { visible: false }
        id: wrapper
        /* define the number of columns depending on the device xy orientation */
        property int n_columns: height > width ? 2 : 4
        property int n_rows: height > width ? 4 : 3
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
                    imageSource: "../assets/card_" + wrapper.imageIndexes[index] + ".svg" 
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
                console.log(index) // card1 e index tienen siempre el mismo valor
                console.log(card1)

                /* if current card is the same as the last card, remove cards from grid */
                /* if currend card is the same as the last card, face up and count as a match */
                if(currentItem.imageSource === lastItem.imageSource) {
        //            lastItem.state = "remove"
        //            currentItem.state = "remove"
                    --remaining;
                    console.log("Cards matched! (not removed, play with the statements above)")

                    if (remaining === 0) {
                         console.log('Game Over!')
                         end_game_timer.start ();

                    }
                   }

                /* if there is no match, turn down again */
                else if (currentItem.imageSource !== lastItem.imageSource){
                    currentItem.flipped = false     // volver a girar las cartas
                    lastItem.flipped = false
                    //delayTimer.start();
                    console.log("No match!")
                   }

                return card1 = -1
            }


    }
//    Timer {
//        id: delaytimer
//        interval: 1000
//        onTriggered: verify(index)
//    }

    function reset () {

        repeater.model = []
        //repeater.model.flipped = false
        console.log("function reset parsed!")
    }

    /* use Timer in order to flip all the cards and reset the grid */
    /* not yet implemented */
    Timer {
        id: end_game_timer
        interval: 2000
        signal done ()
        onTriggered: {
            console.log("end_game_timer")
            repeater.itemAt[0] = reset ()

            flip_timer0.start ()
        }
    }

    Timer {
        id: flip_timer0
        interval: 100
        signal done ()
        onTriggered: {
            repeater.itemAt[1] = reset ()
            repeater.itemAt[2] = reset ()
            //flip_timer1.start ()
        }
    }

}

