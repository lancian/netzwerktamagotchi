package GAME;

import GUI.*;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Felix
 */
public class TamagotchiManager extends Thread {

    private List<Tamagotchi> tamaList = new ArrayList<Tamagotchi>();
    private ISpielLogik logik = null;
    private FoodManager foodMngr = null;


    public TamagotchiManager(ISpielLogik logik, FoodManager foodMngr) {
        this.logik = logik;
        this.foodMngr = foodMngr;
    }

    public void addTamagotchi(Tamagotchi tama){
        synchronized(tamaList){
            tamaList.add(tama);
            Collections.sort(tamaList);
        }
        //TODO eventuell auch net gebraucht
        logik.setTamagotchi(tama);
    }

    public void eatFood(int fieldX, int fieldY, long id){
        Food tmpFood = foodMngr.getFoodToEat(fieldX, fieldY);
        if(tmpFood != null){
            synchronized(tamaList){
                int search = Collections.binarySearch(tamaList, new Tamagotchi(id));
                if (search != -1 ){
                    Tamagotchi tmpTama = tamaList.get(search);
                    if ( tmpTama.eatFood(tmpFood) ){
                        logik.setLifepoints(tmpTama.getHealthPoints(), tmpTama.getId());
                        logik.delFood(tmpFood.getFieldX(), tmpFood.getFieldY());
                    } else {
                        logik.killTamagotchi(id);
                        tamaList.remove(search);
                    }
                }
            }
        }
    }

    @Override
    public void run(){
        synchronized(tamaList){
            for (Tamagotchi tama : tamaList) {
                tama.setHealthPoints((int)(tama.getHealthPoints()*0.9));
                logik.setLifepoints(tama.getHealthPoints(), tama.getId());
            }
        }
        try {
            sleep(10000);
        } catch (InterruptedException ex) { }
    }

}
