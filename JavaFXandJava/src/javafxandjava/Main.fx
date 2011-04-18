/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 * Testbeitrag von Steffen ;)
 */

package javafxandjava;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.text.Text;
import javafx.scene.text.Font;

/**
 * @author sschmiech
 */

Stage {
    title: "Application title"
    scene: Scene {
        width: 250
        height: 80
        content: [
            Text {
                font: Font {
                    size: 16
                }
                x: 10
                y: 30
                content: "Application content"
            }
        ]
    }
}