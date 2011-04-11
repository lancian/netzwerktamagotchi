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

package javafxandjava;

import javafx.animation.*;
import javafx.stage.*;
import javafx.scene.*;
import javafx.scene.shape.*;
import javafx.scene.paint.*;
import javafx.scene.input.*;
import javafx.scene.layout.*;
import javafx.scene.control.*;
import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.input.MouseEvent;
import javafx.scene.Node;
import javafx.scene.paint.Color;
import javafx.scene.paint.RadialGradient;
import javafx.scene.paint.Stop;
import javafx.scene.shape.Circle;
import javafx.scene.shape.LineTo;
import javafx.scene.shape.MoveTo;
import javafx.scene.shape.Path;
import javafx.scene.shape.Rectangle;
import javafx.scene.text.Font;
import javafx.scene.text.Text;

/**
 * @author Vaibhav Choudhary
 */

/* Variable for showing temperature */
public var labelX = 0;
public var labelY = 0;
public var labelOpacity = 0;
public var labelText: String;
/* X Axis */
var X: Integer[]=[0,6,120,180,240,300,360,420];




/* PointGraph class - Create one point graph*/
public class PointGraph extends CustomNode {
    var startPunktX:Integer=100;
    var startPunktY:Integer=100;
    var punkteX: Integer[]=[startPunktX];
    var punkteY: Integer[]=[startPunktY];
    var anzPunkte:Integer=0;
    public var Y: Integer[];
    public var num: Integer;
    public var color: Color;
    var circleOpacity=0;
    public var CityName: String;
    var pathMouseOver: Path = Path {
            stroke: Color.rgb(200,51,51, 0.2)
            strokeWidth: 50
            strokeLineCap: StrokeLineCap.ROUND
            elements: [
                MoveTo {
                    x: bind punkteX[0]
                    y: bind punkteY[0]
                    //x: X[num] * 20.0,
                    //y: 300 - Y[num] * 10.0
                }
                ]
              };

    public  function addPoint(x:Integer, y:Integer):Void
    {
        anzPunkte++;
        insert x into punkteX;
        insert y into punkteY;
        insert LineTo {
                    x: bind punkteX[anzPunkte],
                    y: bind punkteY[anzPunkte]
                } into pathMouseOver.elements;

        println("ANZ: {pathMouseOver.elements.size()}");
    }

    public override function create(): Node {
        return Group {
            translateX: 60
            translateY: 10
            content: [
                pathMouseOver,
                Group {
                    content: [
                        /* temperature showing */
                        Group {
                            content: [
                                Rectangle {
                                    x: bind labelX,
                                    y: bind labelY,
                                    opacity: bind labelOpacity
                                    width: 40,
                                    height: 15
                                    arcHeight: 5
                                    arcWidth: 5
                                    fill: Color.BLACK
                                    stroke: Color.GRAY
                                    strokeWidth: 1
                                },
                                Text {
                                    fill: Color.WHITE
                                    font: Font {
                                        size: 12
                                        name: "Arial Bold"
                                    }
                                    x: bind labelX + 10,
                                    y: bind labelY + 12,
                                    opacity: bind labelOpacity
                                    content: bind labelText
                                }
                            ]
                        },

                        Text {
                            fill: Color.WHITE
                            font: Font {
                                size: 10
                            }
                            x: 10,
                            y: 300 - Y[0] * 10
                            content: CityName
                        }
                        /* Circle of Point Graph */
                        Group {
                            content: for(num in [0..
                            X.size() - 1]) {
                                [
                                    Circle {
                                        centerX: bind  X[num] 
                                        centerY: bind  Y[num]
                                        radius: 6
                                        opacity: bind circleOpacity
                                        fill: RadialGradient {
                                            centerX: 0.25
                                            centerY: 0.25
                                            stops: [
                                                Stop {
                                                    color: color
                                                    offset: 0.0
                                                },
                                                Stop {
                                                    color: Color.BLACK
                                                    offset: 1.0
                                                },

                                            ]
                                        }
                                        onMouseMoved: function( e: MouseEvent ):Void {
                                            labelX = X[num] * 20;
                                            labelY = 300 - Y[num] * 10;
                                            labelOpacity = 1;
                                            labelText = "{Y[num]} C";
                                        }
                                        onMouseEntered:function (e){ circleOpacity = 1; }
                                        onMouseExited: function( e: MouseEvent ):Void {
                                            labelOpacity = 0;
                                            circleOpacity = 0;
                                        }
                                         onMouseDragged: function(e:MouseEvent) : Void {
                                            X[num] += e.dragX/50;
                                            Y[num] += e.dragY/50;
                                            /*
                                            p[i] = if (e.sceneX < r) r else {
                                                if (e.sceneX > w-r) w-r else e.sceneX
                                            }
                                            p[i+1] = if (e.sceneY < r) r else {
                                                if (e.sceneY > h-r) h-r  else e.sceneY
                                            }

                                            if (t[i] > maxV) t[i] = maxV;
                                            if (t[i] < -maxV) t[i] = -maxV;
                                            if (t[i+1] > maxV) t[i+1] = maxV;
                                            if (t[i+1] < -maxV) t[i+1] = -maxV;
                                            */
                                        }
                                    }
                                ]
                            }
                        },
                        /* Joining of Circles */
                        Group {
                            content: for(num in [0..
                                (X.size() - 2)]) { [
                                    Path {
                                        stroke: Color.rgb(51,51,51, 0.2)
                                        strokeWidth: 50
                                        strokeLineCap: StrokeLineCap.ROUND
                                        elements: [
                                            MoveTo {
                                                x: bind  X[num]
                                                y: bind  Y[num]
                                                //x: X[num] * 20.0,
                                                //y: 300 - Y[num] * 10.0
                                            },
                                            LineTo {
                                                x: bind X[num  +  1],
                                                y: bind Y[num  +  1]
                                            }
                                        ]
                                    },
                                    Path {
                                        fill: null
                                        stroke: bind color
                                        strokeWidth: 2
                                        elements: [
                                            MoveTo {
                                                x: bind  X[num]
                                                y: bind  Y[num]
                                                //x: X[num] * 20.0,
                                                //y: 300 - Y[num] * 10.0
                                            },
                                            LineTo {
                                                x: bind X[num  +  1],
                                                y: bind Y[num  +  1]
                                            }
                                        ]
                                    }
                                ]
                            }
                            onMouseEntered:function (e){ circleOpacity = 1; }
                            onMouseExited: function (e){ circleOpacity = 0; }
                        }
                    ]
                }
            ]
        };
    }
}