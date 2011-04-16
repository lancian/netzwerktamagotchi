/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package javafxandjava;

import javafx.reflect.FXClassType;  
import javafx.reflect.FXLocal;
import javafx.reflect.FXLocal.Context;
import javafx.reflect.FXLocal.ObjectValue;
/**
 *
 * @author sschmiech
 */
public class JavaTest implements ISpielLogik {
    private ISpielOberflaeche spielGui;
    
    public JavaTest()
    {
        Context context = FXLocal.getContext();
        FXClassType instance = context.findClass("javafxandjava.SpielOberflaeche");
        ObjectValue obj = (ObjectValue)instance.newInstance();
        spielGui = (ISpielOberflaeche)obj.asObject();
        spielGui.setLogik(this);
        spielGui.addFutter(0, 0, 0);
    }

    public void printString(String s)
    {
        System.out.println("String printed with java: "+s);
    }
public static void main(String args[]) {
    System.out.println("test");
    ISpielLogik gui =  new JavaTest();
    gui.zeigeSpielOberflaeche();
    /*
    String [] labels = {"January", "Febuary", "March", "April"};
    int [] values = { 18, 20, 25, 37 };

    for ( int i=0; i < values.length; i++ ) {
      ji.addData(labels[i], values[i]);
    }

    ji.zeigeSpielOberflaeche();
     *
     */
  }

    @Override
    public void neuesFutter(int x, int y, int haltbarkeit) {
        System.out.println("Neues Futter via Java x:"+x+" y:"+y+" haltbar:"+haltbarkeit);
        spielGui.addFutter(haltbarkeit, x, y);
    }

    @Override
    public void zeigeSpielOberflaeche() {
        spielGui.zeigeSpielOberflaeche();
    }

    @Override
    public void setPosition(int x, int y) {
        throw new UnsupportedOperationException("Not supported yet.");
    }
}
