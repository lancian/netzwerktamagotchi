package javafxandjava;

import javafx.scene.*;
import javafx.scene.shape.*;
import javafx.scene.paint.*;
import javafx.scene.input.*;
import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.input.MouseEvent;
import javafx.scene.Node;
import javafx.scene.paint.Color;
import javafx.scene.shape.Circle;
import javafx.scene.shape.LineTo;
import javafx.scene.shape.MoveTo;
import javafx.scene.shape.Path;
import com.sun.javafx.geom.*;

import javafx.animation.Interpolator;
import javafx.animation.KeyFrame;
import javafx.animation.Timeline;

import javafx.util.Math.*;
import java.lang.Math;

class Punkt {

    var X: Integer;
    var Y: Integer;

    override function toString() {
        return ("({X},{Y})");
    }

}

public class PunktGraph extends CustomNode {
    public var anfasserFarbe: Color = Color.RED;
    public var anfasserRadius: Integer = 10;
    public var startPunktX: Integer = 100;
    public var startPunktY: Integer = 100;

    public var tx=0;
    public var ty=0;
    public var duration = 30;

    public var timeline:Timeline = Timeline {
        repeatCount: Timeline.INDEFINITE
        keyFrames: [ ]
    };


    var punkte: Punkt[] = [Punkt { X: startPunktX, Y: startPunktY }];
    var anzPunkte: Integer = 0;
    var circleOpacity = 0;
    var pointSelected: Boolean = false;
    var mouseOverFarbe: Color = Color.rgb(200, 51, 51, 0.0);
    var anfasser: Node[] = [
                Circle {
                    var index = 0
                    centerX: bind punkte[index].X
                    centerY: bind punkte[index].Y
                    radius: anfasserRadius
                    opacity: bind circleOpacity
                    fill: anfasserFarbe
                    onMouseDragged: function(e: MouseEvent): Void {
                        punkte[index].X = e.x;
                        punkte[index].Y = e.y;
                    }
                    onMouseEntered: function(e) {
                        pointSelected = true;

                    }
                    onMouseExited: function(e) {
                        pointSelected = false;
                    }
                }
            ];
    var pathMouseOver: Path = Path {
                var index = 0;
                stroke: mouseOverFarbe
                strokeWidth: 50
                strokeLineCap: StrokeLineCap.ROUND
                elements: [
                    MoveTo {
                        x: bind punkte[index].X
                        y: bind punkte[index].Y
                    }
                ]
                onMouseEntered: function(e) {
                    circleOpacity = 1;
                }
                onMouseExited: function(e) {
                    circleOpacity = 0;
                }
            };
    public var path: Path = Path {
                var index = 0;
                stroke: Color.rgb(0, 0, 0, 0.4)
                strokeWidth: 1
                strokeDashArray: [8, 4]
                strokeLineCap: StrokeLineCap.ROUND
                elements: [
                    MoveTo {
                        x: bind punkte[index].X
                        y: bind punkte[index].Y
                    }
                ]
                onMouseEntered: function(e) {
                }
                onMouseExited: function(e) {
                }
            };

    function calcTime(index:Integer):Duration
    {
        var time:Duration;
        if(index < 1)
        {
            time = Duration.valueOf(0);
        }
        else
        {
            time = Duration.valueOf(Math.sqrt(((punkte[index].X-punkte[index-1].X)*(punkte[index].X-punkte[index-1].X))+((punkte[index].Y-punkte[index-1].Y)*(punkte[index].Y-punkte[index-1].Y)))*duration);
        }
        println("time: {time}");
        return time;
    }
    function cmp(px: Integer, py: Integer, px1: Integer, py1: Integer, px2: Integer, py2: Integer, pt: Integer): Integer {
        var line: Line2D = new Line2D(px1, py1, px2, py2);
        var ret = line.ptLineDist(px, py);
        var bounds: Bounds2D = line.getBounds2D();
        bounds.grow(pt, pt);
        if (not bounds.contains(px, py)) {
            ret = -1;
        }
        return ret;
    }

    public function addPunkt(mcx: Integer, mcy: Integer): Void {
        if ((not pointSelected) and (circleOpacity == 0)) {
            insert Punkt { X: mcx, Y: mcy } into punkte;
            anzPunkte++;
            insert KeyFrame {
                var index = anzPunkte
                var nextTx = bind punkte[index].X
                var nextTy = bind punkte[index].Y
                time: bind calcTime(index)
               // canSkip: true
                values: [tx => nextTx, ty => nextTy]
            }
            into timeline.keyFrames;
            insert LineTo {
                var index = anzPunkte
                x: bind punkte[index].X
                y: bind punkte[index].Y
            } into pathMouseOver.elements;
            insert LineTo {
                var index = anzPunkte
                x: bind punkte[index].X
                y: bind punkte[index].Y
            } into path.elements;
            insert Circle {
                var index = anzPunkte
                centerX: bind punkte[index].X
                centerY: bind punkte[index].Y
                radius: anfasserRadius
                opacity: bind circleOpacity
                fill: anfasserFarbe
                onMouseDragged: function(e: MouseEvent): Void {
                    punkte[index].X = e.x;
                    punkte[index].Y = e.y;
                }
                onMouseEntered: function(e) {
                    pointSelected = true;
                }
                onMouseExited: function(e) {
                    pointSelected = false;
                }
            } into anfasser;
        } else if ((not pointSelected) and (circleOpacity == 1)) {
            var ewIndex = 0;
            var elementWert: Integer;

            for (i in [0..(punkte.size() - 2)]) {
                elementWert = cmp(mcx, mcy, punkte.get(i).X, punkte.get(i).Y, punkte.get(i + 1).X, punkte.get(i + 1).Y, 5);
                if (elementWert > -1) {
                    ewIndex = i;
                }
            }
            insert Punkt { X: mcx, Y: mcy } after punkte[ewIndex];
            anzPunkte++;
            insert KeyFrame {
                var index = anzPunkte
                var nextTx = bind punkte[index].X
                var nextTy = bind punkte[index].Y
                time: bind calcTime(index)
               // canSkip: true
                values: [tx => nextTx, ty => nextTy]
            }
            into timeline.keyFrames;
            insert LineTo {
                var index = anzPunkte
                x: bind punkte[index].X
                y: bind punkte[index].Y
            } into pathMouseOver.elements;
            insert LineTo {
                var index = anzPunkte
                x: bind punkte[index].X
                y: bind punkte[index].Y
            } into path.elements;
            insert Circle {
                var index = anzPunkte
                centerX: bind punkte[index].X
                centerY: bind punkte[index].Y
                radius: anfasserRadius
                opacity: bind circleOpacity
                fill: Color.RED
                onMouseDragged: function(e: MouseEvent): Void {
                    punkte[index].X = e.x;
                    punkte[index].Y = e.y;
                }
                onMouseEntered: function(e) {
                    pointSelected = true;
                }
                onMouseExited: function(e) {
                    pointSelected = false;
                }
            } into anfasser;
        }
    }

    public override function create(): Node {
        return Group {
                    content: [
                        pathMouseOver,
                        path,

                        Group {
                            content: bind anfasser
                        },
                    ]
                };
    }

}
