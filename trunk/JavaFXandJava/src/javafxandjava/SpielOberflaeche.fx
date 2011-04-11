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
 */

/**
 * @author sschmiech
 */
public class SpielOberflaeche extends ISpielOberflaeche {

    var breiteOberflaeche: Integer = 800;
    var hoeheOberflaeche: Integer = 500;
    def canvas = Group {};
    var futter: Node[] = [];

  var pg: PointGraph = PointGraph{
    Y: [60,20,90,200,100,300,350,300],
    color: Color.LIGHTBLUE,
    CityName: "NewYork,USA"
};
    var content: Node[] = [Rectangle {
                    width: bind breiteOberflaeche
                    height: bind hoeheOberflaeche
                    fill: Color.WHITE
                    var path: Path;
                    onMousePressed: function(mouse) {
                        if (mouse.button == MouseButton.SECONDARY) {
                            println("Right button clicked");
                            //canvas.content.
                        }
                        else
                        {
                           pg.addPoint(mouse.x, mouse.y);
                     /*   path = Path {
                            stroke: Color.BLUE
                            strokeWidth: 2
                            strokeLineCap: StrokeLineCap.ROUND
                            strokeLineJoin: StrokeLineJoin.ROUND
                            elements: MoveTo { x: mouse.x y: mouse.y }
                        }*/
                        insert path into canvas.content
                    }
                    }
                    onMouseDragged: function(mouse) {
                        insert LineTo { x: mouse.x y: mouse.y } into path.elements
                    }
                },
                canvas];


    var chartData: PieChart.Data[] = [];
    var spielLogik: ISpielLogik = null;
    
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
        insert pizza into content;
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
        var chart =
                PieChart3D {
                    data: chartData
                    pieThickness: 25
                    pieLabelFont: Font { size: 9 };
                    pieToLabelLineOneLength: 10
                    pieToLabelLineTwoLength: 20
                    pieLabelVisible: true
                    pieValueVisible: true
                    translateY: -50
                };

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
        steuerbox.translateX = breiteOberflaeche-100;
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
                var randI = (Math.random() * (sizeof content - 1)).intValue();
                var pizza: pizzaUI;
                pizza = (content.get(randI) as pizzaUI);
                pizza.starteVerwessung();
                println("Starte verfaulen Pizza Nr. {randI}");

            // futter[randI].starteVerwessung();
            }
        } into content;

        
    var stage:Stage = Stage  {
            style: StageStyle.TRANSPARENT
            title: "Insert an object on mouse click"
            scene: Scene {
                content: bind content
            }
        }
    }

}
