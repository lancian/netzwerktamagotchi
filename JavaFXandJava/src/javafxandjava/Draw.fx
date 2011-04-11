/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package javafxandjava;

import javafx.scene.Cursor;
import javafx.scene.Group;
import javafx.scene.Scene;
import javafx.scene.input.KeyCode;
import javafx.scene.paint.Color;
import javafx.scene.shape.Circle;
import javafx.scene.shape.Line;
import javafx.scene.shape.LineTo;
import javafx.scene.shape.MoveTo;
import javafx.scene.shape.Path;
import javafx.scene.shape.Rectangle;
import javafx.scene.shape.StrokeLineCap;
import javafx.scene.shape.StrokeLineJoin;
import javafx.stage.Stage;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import javafx.scene.control.Button;

def APP_PADDING = 4;
def CONTENT_PADDING = 4;
def Rect_Padding = 1;
def D = 22;
def circle_widthstroke = 2;
def BG = Color.WHITE;
def Padding = 2;
def Line_Padding = 2;
def FG = Color.BLACK;
def scene_width = 600;
def scene_height = 400;
def COLORS = [
    Color.RED,
    Color.ORANGE,
    Color.YELLOW,
    Color.GREEN,
    Color.LIGHTBLUE,
    Color.BLUE,
    Color.MAGENTA,
    Color.BLACK
];
var COLOR = Color.BLACK;
var SIZE = 1;
var buttons: HBox;
// group of strokes
def canvas = Group {}

function undo() {
    def index = sizeof canvas.content;
    if (index > 0) {
        delete canvas.content[index - 1] from canvas.content
    }
}

Stage {
    title: "Draw (JavaFX Draw)"
    scene: Scene {
        width: scene_width
        height: scene_height
        content: [
            // background canvas for drawing
            Rectangle {
                fill: BG
                width: bind canvas.scene.width - Rect_Padding
                height: bind canvas.scene.height - Rect_Padding
                var path: Path;
                onMousePressed: function(mouse) {
                    path = Path {
                        stroke: COLOR
                        strokeWidth: SIZE
                        strokeLineCap: StrokeLineCap.ROUND
                        strokeLineJoin: StrokeLineJoin.ROUND
                        elements: MoveTo { x: mouse.x y: mouse.y }
                    }
                    insert path into canvas.content
                }
                onMouseDragged: function(mouse) {
                    insert LineTo { x: mouse.x y: mouse.y } into path.elements
                }
                onKeyPressed: function(key) {
                    if (key.controlDown and key.code == KeyCode.VK_Z) {
                        undo()
                    }
                }
            }
            canvas,
            // controls
            VBox {
                layoutX: APP_PADDING
                layoutY: APP_PADDING
                spacing: CONTENT_PADDING
                content: [
                    // horizontally laid out colored boxes
                    HBox {
                        spacing: CONTENT_PADDING
                        content: for (color in COLORS) Rectangle {
                            fill: color
                            width: D
                            height: D
                            blocksMouse: true
                            cursor: Cursor.HAND
                            onMousePressed: function(e) {
                                COLOR = color
                            }
                        }
                    }
                    // horizontally laid out stroke sizes
                    HBox {
                        spacing: CONTENT_PADDING
                        content: for (size in [1..5]) Group {
                            content: [
                                Circle {
                                    strokeWidth: circle_widthstroke
                                    stroke: bind if (SIZE == size) then FG else null
                                    fill: BG
                                    radius: D/Padding
                                    blocksMouse: true
                                    cursor: Cursor.HAND
                                    onMousePressed: function(e) {
                                        SIZE = size
                                    }
                                }
                                Line {
                                    def o = (D - size)/Padding - Line_Padding;
                                    strokeWidth: size
                                    stroke: bind COLOR
                                    strokeLineCap: StrokeLineCap.ROUND
                                    startX: -o
                                    endX: o
                                }
                            ]
                        }
                    }
                ]
            }
            // horizontally laid out buttons
            buttons = HBox {
                layoutX: APP_PADDING
                layoutY: bind canvas.scene.height - buttons.height - APP_PADDING
                spacing: CONTENT_PADDING
                content: [
                    Button {
                        text: "Clear"
                        cursor: Cursor.HAND
                        focusTraversable: false
                        onMousePressed: function(e) {
                            delete canvas.content
                        }
                    },
                    Button {
                        focusTraversable: false
                        text: "Undo"
                        cursor: Cursor.HAND
                        onMousePressed: function(e) {
                            undo()
                        }
                    }
                ]
            }
        ]
    }
}