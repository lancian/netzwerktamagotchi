/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package javafxandjava;

import javafx.scene.chart.PieChart;
import javafx.stage.*;
import javafx.scene.input.*;
import javafxandjava.JavaTest;
import javafx.scene.chart.PieChart3D;
import javafx.scene.Scene;
import javafx.scene.text.Font;
import javafxandjava.ISpielLogik;
import javafx.scene.control.Button;
import java.lang.Math;
import javafxandjava.pizzaUI;
import javafx.scene.Node;
import javafx.scene.shape.*;
import javafx.scene.paint.Color;
import javafx.scene.control.TextBox;
import javafx.scene.control.Label;
import javafx.scene.Group;
import javafx.animation.*;
import javafx.animation.transition.*;
/*
import javafx.animation.transition.*;
import javafx.scene.shape.SVGPath;
import javafx.scene.input.MouseEvent;
import javafx.scene.shape.Shape;
import javafx.scene.text.Text;
import javafx.fxd.FXDNode;
import javafx.scene.CustomNode;
import javafx.lang.FX;
import javafx.scene.Cursor;
import javafx.scene.effect.DropShadow;
import javafx.scene.Group;
import javafx.scene.input.MouseEvent;
import javafx.scene.paint.Color;
import javafx.scene.paint.RadialGradient;
import javafx.scene.paint.Stop;
import javafx.scene.Scene;
import javafx.scene.shape.SVGPath;
import javafx.scene.text.Font;
import javafx.scene.text.Text;
import javafx.scene.text.TextOrigin;
import javafx.stage.Stage;
import java.lang.UnsupportedOperationException;
import java.awt.Frame;
 */

/**
 * @author sschmiech
 */
public class SpielOberflaeche extends ISpielOberflaeche {
    override public function delFood(x: Integer, y: Integer): Void {
    // throw new UnsupportedOperationException('Not implemented yet');
    }

    override public function setLebensEnergie(arg0: Integer): Void {
    // throw new UnsupportedOperationException('Not implemented yet');
    }

    var breiteOberflaeche: Integer = 800;
    var hoeheOberflaeche: Integer = 500;
    var ei:Ei = Ei{};
    var frosch: Frosch;
    var futter: Node[] = [];
    var pg: PunktGraph = PunktGraph { };
    var content: Node[] = [];
    //   canvas];
    var chartData: PieChart.Data[] = [];
    var spielLogik: ISpielLogik = null;
    var aniPath:AnimationPath = AnimationPath.createFromPath(Path{elements: bind pg.path.elements});
    //var anim:PathTransition;







    def bar1 = Rectangle {
        width: 5
        height: 50
        fill: Color.RED
    };

    def track1 = Path {
        stroke: Color.BLACK
        strokeWidth: 4
        elements: [
            MoveTo  {
                x: 50
                y: 100
            },
            LineTo {
                x: 350
                y: 100
            },
        ]
    };


    def anim = PathTransition {
        node: frosch
        path: bind AnimationPath.createFromPath(track1)
        orientation: OrientationType.NONE
        interpolator: Interpolator.LINEAR
        duration: 5s
        repeatCount: Timeline.INDEFINITE
    };






//    var cb: JavaTest = new JavaTest();
    override public function setLogik(logik: ISpielLogik): Void {
        if (spielLogik == null) {
            spielLogik = logik;
        }
    }

    override public function addFutter(haltbarkeit: Integer, x: Integer, y: Integer): Void {
        var pX: Integer;
        var pY: Integer;
        var pizza: pizzaUI = pizzaUI {};
        if (haltbarkeit > 0) {
            pizza.gut = Duration.valueOf(haltbarkeit);
            pizza.schlecht = Duration.valueOf(haltbarkeit);
            pizza.starteVerwessung();
        }
        if ((x > 0) and (x < breiteOberflaeche)) {
            pX = x;
        } else {
            pX = (Math.random() * breiteOberflaeche).intValue();
        }

        if ((y > 0) and (y < hoeheOberflaeche)) {
            pY = y;
        } else {
            pY = (Math.random() * hoeheOberflaeche).intValue();
        }
        pizza.translateX = pX;
        pizza.translateY = pY;
        insert pizza into futter;
    }

    override public function getBreiteOberflaeche(): Integer {
        return breiteOberflaeche;
    }

    override public function getHoeheOberflaeche(): Integer {
        return hoeheOberflaeche;
    }

    override public function setBreiteOberflaeche(breite: Integer): Void {
        breiteOberflaeche = breite;
    }

    override public function setHoeheOberflaeche(hoehe: Integer): Void {
        hoeheOberflaeche = hoehe;
    }

    public override function addData(l: String, v: Number): Void {
        var labelString = l;

        var data = PieChart.Data {
                    label: l
                    value: v
                    action: function() {

                        println("{labelString} clicked!");
                    }
                };

        insert data into chartData;

        var pizza = pizzaUI {};
        var randX = (Math.random() * 900).intValue();
        var randY = (Math.random() * 500).intValue();
        pizza.translateX = randX;
        pizza.translateY = randY;
        insert pizza into futter;
    }

    public override function zeigeSpielOberflaeche(): Void {
        pg.addPunkt(10, 10);
        pg.addPunkt(20, 20);
        var clickOp = 0.0;
        var clickX = 0.0;
        var clickY = 0.0;
        var click: Circle = Circle {
                    fill: Color.TRANSPARENT
                    stroke: Color.RED
                    strokeWidth: 2
                    radius: 6
                    opacity: bind clickOp
                    centerX: bind clickX
                    centerY: bind clickY
                };
        insert Rectangle {
            width: bind breiteOberflaeche
            height: bind hoeheOberflaeche
            fill: Color.rgb(200, 200, 200, 0.01)
            // var path: Path;
            onMousePressed: function(mouse) {
                if (mouse.button == MouseButton.SECONDARY) {
                    println("Right button clicked");
                    //canvas.content.
                    clickOp = 1.0;
                    clickX = mouse.x;
                    clickY = mouse.y;
                    println("rc: {mouse.x}|{mouse.y}");
                    insert LineTo {
                        x: clickX
                        y: clickY
                    } into track1.elements;
                } else {
                    pg.addPunkt(mouse.x, mouse.y);
                    if(pg.path.elements.size() == 6)
                    {
                        ei.opacity = 0.0;
                        frosch = Frosch{
                                        translateX: bind pg.tx
                                        translateY: bind pg.ty
                                        };
                        insert frosch into content;
                        pg.timeline.play();
                    }
                    println("lc: {mouse.x}|{mouse.y}");
                /*   path = Path {
                stroke: Color.BLUE
                strokeWidth: 2
                strokeLineCap: StrokeLineCap.ROUND
                strokeLineJoin: StrokeLineJoin.ROUND
                elements: MoveTo { x: mouse.x y: mouse.y }
                }*/
                //   insert path into canvas.content
                }
            }
            onMouseDragged: function(mouse) {
            // insert LineTo { x: mouse.x y: mouse.y } into path.elements
            }
        } into content;
        insert click into content;

        var neuesFutterX = TextBox {
                    text: "0"
                    columns: 3
                    selectOnFocus: true
                };

        var neuesFutterY = TextBox {
                    text: "0"
                    translateX: 30
                    columns: 3
                    selectOnFocus: true
                };
        var neuesFutterHaltbarkeit = TextBox {
                    text: "0"
                    translateX: 60
                    columns: 3
                    selectOnFocus: true
                };

        var steuerbox = Group {
                    content: [
                        neuesFutterX,
                        neuesFutterY,
                        neuesFutterHaltbarkeit,
                        Button {
                            text: "neues Futter"
                            action: function() {
                                println("{neuesFutterX.text}");
                                if (spielLogik != null) {
                                    spielLogik.neuesFutter(Integer.valueOf(neuesFutterX.text),
                                    Integer.valueOf(neuesFutterY.text),
                                    Integer.valueOf(neuesFutterHaltbarkeit.text));
                                }

                            }
                            translateY: 20
                        }
                    ]
                };
        steuerbox.translateX = breiteOberflaeche - 100;
        insert steuerbox into content;
        insert Button {
            text: "Schließen"
            translateX: 810
            translateY: 0
            strong: true
            font: Font { size: 24 name: "Tahoma" }

            action: function() {
                stage.close();
            }
        } into content;

        insert pg into content;
        insert Button {
            text: "Neu"
            translateX: 810
            translateY: 60
            strong: true
            font: Font { size: 24 name: "Tahoma" }

            action: function() {
                var pizza = pizzaUI {};
                var randX = (Math.random() * 900).intValue();
                var randY = (Math.random() * 500).intValue();
                pizza.translateX = randX;
                pizza.translateY = randY;
                insert pizza into content;
                println("Neue Pizza ({randX}|{randY})");
            }
        } into content;
        insert Button {
            text: "verfaule"
            translateX: 810
            translateY: 110
            strong: true
            font: Font { size: 24 name: "Tahoma" }

            action: function() {
                var randI = (Math.random() * (sizeof futter - 1)).intValue();
                var pizza: pizzaUI;
                pizza = (futter.get(randI) as pizzaUI);
                pizza.starteVerwessung();
                println("Starte verfaulen Pizza Nr. {randI}");

            // futter[randI].starteVerwessung();
            }
        } into content;
        insert ei into content;
       // insert frosch into content;
        insert Group {
            content: bind futter
        } into content;

        insert bar1 into content;
      
//        def anim = PathTransition {
//                    path: AnimationPath.createFromPath(pg.path)
//                    orientation: OrientationType.ORTHOGONAL_TO_TANGENT
//                    node: frosch
//                    interpolator: Interpolator.LINEAR
//                    duration: 8s
//                    repeatCount: Timeline.INDEFINITE
//         };
//         anim.play();

        var stage: Stage = Stage {
                    style: StageStyle.TRANSPARENT
                    visible: true
                    title: "Insert an object on mouse click"
                    scene: Scene {
                        fill: null
                        content: bind content
                    }
                }
    }

}
