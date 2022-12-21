/*
 * Copyright (C) 2022  Mauricio Duarte
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * pairs-up is distributed in the hope that it will be useful,
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
import QtMultimedia 5.12

Shape {
    id: card
    property alias flipped: flipable.flipped
    property alias state: flipable.state
    property alias frontCard: frontCardCheck.color
    property alias imageSource: images.source

    signal finished ()

    /* not yet implemented
    MediaPlayer {
        id: soundFx
    }
    */
    Rectangle {
        id: frontCardCheck
        anchors.fill: parent
        border.color: "black"
        color: "#DF6589"
        border.width: 2
        radius: 5

        Image {
            id: images
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width * 0.8
            height: parent.height * 0.8
            fillMode: Image.PreserveAspectFit
        }
    }

    Flipable {
        id: flipable
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width
        height: parent.height

        property bool flipped: false

        front: Rectangle {
            anchors.fill: parent
            //border.color: "black"
            color: "#862D37"
            radius: 4

            Image {
                width: 80
                height: 80
                anchors { fill: parent; centerIn: parent }
                fillMode: Image.PreserveAspectFit
                source: "../assets/star.svg" //back
            }
        }

        back: images

        transform: Rotation {
            id: rotation
            origin.x: card.width / 2
            origin.y: card.height / 2
            axis.x: 0
            axis.y: 1
            axis.z: 0

            Behavior on angle {
                NumberAnimation {
                    easing: UbuntuAnimation.StandardEasing
                }
            }
        }
        states: [
            State {
                name: "back"
                PropertyChanges { target: rotation; angle: 180 }
                when: flipable.flipped
            },
            /* not used *yet */
            State {
                name: "remove"
                PropertyChanges {
                    target: card;
                    visible: false;
                }
            }

        ]
        transitions: Transition {
            NumberAnimation { target: rotation; property: "angle"; duration: 500 }
            onRunningChanged: {
                if ((state == "back") && (!running))
                    finished()
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked:  card.flipped = true
        }
    }
}
