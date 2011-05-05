/*
 * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER
 *
 * Copyright � 2010, Oracle and/or its affiliates. All rights reserved.
 * Oracle is a registered trademark of Oracle Corporation and/or its affiliates.
 * Oracle and Java are registered trademarks of Oracle and/or its affiliates.
 * Other names may be trademarks of their respective owners.
 *
 * This file is available and licensed under the following license:
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:

 *   *  Redistributions of source code must retain the above copyright notice,
trademark notice, this list of conditions, and the following disclaimer.

 *   *  Redistributions in binary form must reproduce the above copyright notice,
trademark notice, this list of conditions, and the following disclaimer in
the documentation and/or other materials provided with the distribution.

 *   *  Neither the name of Oracle nor the names of its contributors may be used
to endorse or promote products derived from this software without specific
prior written permission.

 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 */
package GUI;

//import javafx.animation.*;
//import javafx.stage.*;
import javafx.scene.*;
import javafx.scene.shape.*;
import javafx.scene.paint.*;
import javafx.scene.input.*;
//import javafx.scene.layout.*;
//import javafx.scene.control.*;
import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.input.MouseEvent;
import javafx.scene.Node;
import javafx.scene.paint.Color;
//import javafx.scene.paint.RadialGradient;
//import javafx.scene.paint.Stop;
import javafx.scene.shape.Circle;
import javafx.scene.shape.LineTo;
import javafx.scene.shape.MoveTo;
import javafx.scene.shape.Path;
//import javafx.scene.shape.Rectangle;
//import javafx.scene.text.Font;
//import javafx.scene.text.Text;
//import javafx.util.Math;
import com.sun.javafx.geom.*;
//import javafx.geometry.*;
//import javafx.util.Sequences;

/**
 * @author Vaibhav Choudhary
 */
var pointSelected: Boolean = false;

class Point {
    var X:Integer;
    var Y:Integer;
    override function toString()
    {
        return ("({X},{Y})");
    }

}
/* PointGraph class - Create one point graph*/
public class PointGraph extends CustomNode {

//    var bewertungStr:String="";
    var startPunktX: Integer = 100;
    var startPunktY: Integer = 100;
    var punkte:Point[] = [Point{ X: startPunktX, Y: startPunktY}];
//    var punkteX: Integer[] = [startPunktX];
//    var punkteY: Integer[] = [startPunktY];
    var anzPunkte: Integer = 0;
//    var punktVerlauf: RadialGradient = RadialGradient {
//                centerX: 0.5
//                centerY: 0.5
//                stops: [
//                    Stop {
//                        color: Color.RED
//                        offset: 0.0
//                    },
//                    Stop {
//                        color: Color.BLACK
//                        offset: 0.3
//                    },
//                    Stop {
//                        color: Color.TRANSPARENT
//                        offset: 0.3
//                    },
//                    Stop {
//                        color: Color.TRANSPARENT
//                        offset: 0.9
//                    },
//                    Stop {
//                        color: Color.BLACK
//                        offset: 1.0
//                    }
//                ]
//            };
//    var neuerPunktVerlauf: RadialGradient = RadialGradient {
//                centerX: 0.5
//                centerY: 0.5
//                stops: [
//                    Stop {
//                        color: Color.BLUE
//                        offset: 0.0
//                    },
//                    Stop {
//                        color: Color.BLACK
//                        offset: 0.3
//                    },
//                    Stop {
//                        color: Color.TRANSPARENT
//                        offset: 0.3
//                    },
//                    Stop {
//                        color: Color.TRANSPARENT
//                        offset: 0.9
//                    },
//                    Stop {
//                        color: Color.BLACK
//                        offset: 1.0
//                    }
//                ]
//            };
    public var Y: Integer[];
    public var num: Integer;
    public var color: Color;
    var circleOpacity = 0;
    public var CityName: String;
//    var bewertungen: Node[] = [];
    var mouseOverFarbe:Color =  Color.rgb(200, 51, 51, 0.0);
    var anfasserFarbe:Color = Color.RED;
    var anfasser: Node[] = [
                Circle {
                    var index = 0
                    centerX: bind punkte[index].X
                    centerY: bind punkte[index].Y
                    radius: 30
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
                    println("aktives Element: {index}");
                }
                onMouseExited: function(e) {
                    circleOpacity = 0;
                }
            };
    var path: Path = Path {
                var index = 0;
                stroke: Color.rgb(0, 0, 0, 0.8)
                strokeWidth: 1
                strokeLineCap: StrokeLineCap.ROUND
                elements: [
                    MoveTo {
                        x: bind punkte[index].X
                        y: bind punkte[index].Y
                    }
                ]
                onMouseEntered: function(e) {
                //  circleOpacity = 1;
                }
                onMouseExited: function(e) {
                //   circleOpacity = 0;
                }
            };
    
//    function compare(w: Integer, w1: Integer, w2: Integer, t: Integer):Boolean {
//        if(((w1-w2)*(w1-w2))<(t*t)){
//            return true;
//        }
//        else if (((w1 < w) and (w < w2)) or  ((w1 > w) and (w > w2)))
//        {
//            return true;
//        }
//        else
//        {
//            return false;
//        }
//    }
//    function bewertung(p1:Integer, p2:Integer, bw:Integer):Integer
//    {
//        var ret = p1 - p2;
//        if(ret<0) ret = -1;
//        if(ret > bw) ret = bw;
//        return ret;
//    }

    function cmp(px: Integer, py: Integer, px1: Integer, py1: Integer, px2: Integer, py2: Integer, pt: Integer): Integer
    {
        var line:Line2D = new Line2D(px1,  py1,  px2,  py2);
        var ret = line.ptLineDist(px, py);
        var bounds:Bounds2D = line.getBounds2D();
        bounds.grow(pt, pt);
        if(not bounds.contains(px, py))
        {
            ret=-1;
        }
        return ret;
        /*
       // Line2D line = new Line2D();
      //  Line2D line = new Line2D.Double(px1, px2, py1, py2);
        //ret = Math.abs(Line2D.ptLineDist(arg0, arg1, arg2, arg3, arg4, arg5);
        var x = px; var y = py; var t = pt;
        var x1 = px1; var y1 = py1;
        var x2 = px2; var y2 = py2;
        var tx1; var  tx2; var ty1; var ty2;
        var ret = t;
        // Falls X1 > X2 Punkte tauschen
        if(x1 > x2)
        {
            var tmp = x1;
            x1 = x2;
            x2 = tmp;
            tmp = y1;
            y1 = y2;
            y2 = tmp;
        }
            tx1 = x1 - t;
            tx2 = x2 + t;
        if(y2 > y1)
        {
            ty1 = y1 - t;
            ty2 = y2 + t;
        }
        else
        {
            ty1 = y1 + t;
            ty2 = y2 - t;
        }
        var a : Integer[];
        a[0] = bewertung(y, ty1, t);
        a[1] = bewertung(tx2, x, t);
        a[2] = bewertung(ty2, y, t);
        a[3] = bewertung(x, tx1, t);
        bewertungStr = "N:{a[0]}  O:{a[1]}  S:{a[2]}  W:{a[3]}";
        for(i in [0..a.size()-1])
            if(a[i]<ret) ret = a[i];
        return ret;*/
    }
//    function insertAtIn(wert:Integer, index:Integer, sequnece:Sequences):Integer[]
//    {
//        var newSequence:Sequences = [];
//        for(i in [0..index])
//        {
//            if(i<sequnece.size())
//            insert sequnece.
//        }
//    }
    public function addPoint(mcx: Integer, mcy: Integer): Void {
        if ((not pointSelected) and (circleOpacity == 0)) {
            insert  Point{X:mcx, Y:mcy} into punkte;
//            insert x into punkteX;
//            insert y into punkteY;
            /*   insert MoveTo {
            x: bind punkteX[anzPunkte],
            y: bind punkteY[anzPunkte]
            //x: X[num] * 20.0,
            //y: 300 - Y[num] * 10.0
            } into pathMouseOver.elements; */
            anzPunkte++;
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
                radius: 10
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
//            println("ANZ: {pathMouseOver.elements.size()} anzP: {anzPunkte} x last {punkteX[anzPunkte]}  x last-1 {punkteX[anzPunkte - 1]} \n {pathMouseOver.elements}");
        } else if ((not pointSelected) and (circleOpacity == 1)) {
//            delete bewertungen;
            var ewIndex = 0;
            var elementWert:Integer;
//            var elementWerte:Integer[]=[];
//            var elementWerteIndexes:Integer[]=[];
            for (i in [0..(punkte.size() - 2)]) {
                elementWert=cmp(mcx, mcy, punkte.get(i).X,  punkte.get(i).Y,  punkte.get(i+1).X,  punkte.get(i+1).Y, 5);
//                var fontSz = 12;
                if(elementWert>-1)
                {
//                    fontSz = 20;
                    ewIndex = i;
                }
//                insert Text {
//                    x: (anfasser[i] as Circle).centerX +30
//                    y: (anfasser[i] as Circle).centerY +30
//                    font: Font { size: fontSz }
//                    content: "{i} ({(anfasser[i] as Circle).centerX}|{(anfasser[i] as Circle).centerY}) : {elementWert}"
//                } into bewertungen;



//                if(elementWert>-1){
//                  insert elementWert into elementWerte;
//                  insert i into elementWerteIndexes;
//                 };
            }

            /*
            var min = elementWerte[0]; 
            for(a in [0..elementWerte.size()] )
            {
                if(elementWerte.get(a)>-1)
                {
                    if(elementWerte.get(a)<min)
                    {
                        println("{elementWerte.get(a)} < {min} ");
                        min = elementWerte.get(a);
                        ewIndex = a;
                     }
                }
            }*/
//            println("insert at {ewIndex} ");
//            println("Punkte: ");
//            for (i in [0..(punkte.size()-1)]) print("{punkte.get(i).toString()}, ");
            insert  Point{X:mcx, Y:mcy} after punkte[ewIndex];
//            println("Punkte: ");
//            for (i in [0..(punkte.size()-1)]) print("{punkte.get(i).toString()}, ");
            //insertAtIn(x,ewIndex, punkteX);
//            insert x after punkteX[ewIndex];
//            insert y after punkteY[ewIndex];
            anzPunkte++;
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
                    radius: 10
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
                //    translateX: 60
                //    translateY: 10
                    content: [
                        pathMouseOver,
                        path,

                        Group {
                            content: bind anfasser
                        },
//                        Group {
//                            content: bind bewertungen
//                        }
                        ]
                };
    }

}
