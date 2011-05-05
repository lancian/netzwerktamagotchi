/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package GAME;

import javafx.reflect.FXClassType;  
import javafx.reflect.FXLocal;
import javafx.reflect.FXLocal.Context;
import javafx.reflect.FXLocal.ObjectValue;
import GUI.*;
import java.awt.Dimension;
import java.awt.Toolkit;
/**
 *
 * @author sschmiech
 */
public class Main implements ISpielLogik {
    private ISpielOberflaeche spielGui;
    private TamagotchiManager tamaMngr;
    
    public Main()
    {
        Context context = FXLocal.getContext();
        FXClassType instance = context.findClass("GUI.SpielOberflaeche");
        ObjectValue obj = (ObjectValue)instance.newInstance();
        spielGui = (ISpielOberflaeche)obj.asObject();
        spielGui.setLogik(this);
    }

    public void printString(String s)
    {
        System.out.println("String printed with java: "+s);
    }
public static void main(String args[]) {
    System.out.println("test");
    ISpielLogik logik =  new Main();

    Dimension screen = Toolkit.getDefaultToolkit().getScreenSize();
    // TODO setBreite & setHoehe in gui anpassen
    logik.setBreiteOberflaeche((int)screen.getWidth());
    logik.setHoeheOberflaeche((int)screen.getHeight());
    logik.zeigeSpielOberflaeche();

    int fieldsX = (int)( (screen.getWidth()-100) / 50 - 1 );
    int fieldsY = (int)( screen.getHeight() / 50 - 1 );

    FoodManager foodMngr = new FoodManager(fieldsX, fieldsY, logik);
    foodMngr.start();
    FoodCreator foodCrtr = new FoodCreator(fieldsX, fieldsY, foodMngr, logik);
    foodCrtr.start();
    TamagotchiManager tamaMngr = new TamagotchiManager(logik, foodMngr);
    tamaMngr.start();
    tamaMngr.addTamagotchi(new Tamagotchi());
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
    public void delFood(int x, int y){
        spielGui.delFood(x, y);
    }

    @Override
    public void setLifepoints(int e, String id){
        spielGui.setLebensEnergie(e, id);
    }

    @Override
    public void setBreiteOberflaeche( int breite){
        spielGui.setBreiteOberflaeche(breite);
    }

    @Override
    public void setHoeheOberflaeche( int hoehe){
        spielGui.setHoeheOberflaeche(hoehe);
    }

    @Override
    public void killTamagotchi(String index){
        spielGui.killTamagotchi(index);
    }

    @Override
    public void setTamagotchi(Tamagotchi tama) {
//        braucht man nich, es sei denn netzwerk braucht die funktion
        //TODO entscheiden ob id reicht oder tama gebraucht wird
//        tamaMngr.addTamagotchi(tama);
        spielGui.setTamagotchi(tama.getId());
    }
}
