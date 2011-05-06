package GAME;

import GUI.*;

public class FoodCreator extends Thread {
	
    private int fieldsX = 12;
    private int fieldsY = 9;
    private FoodManager foodMngr = null;
    private ISpielLogik logik = null;

    public FoodCreator(int fieldsX, int fieldsY, FoodManager foodMngr, ISpielLogik logik) {
        this.fieldsX = fieldsX;
        this.fieldsY = fieldsY;
        this.foodMngr = foodMngr;
        this.logik = logik;
    }

    @Override
    public void run() {
            while (true) {
                    Food tmpFood = null;
                    if ( !foodMngr.isFull() ){
                        do {
                                int posX = (int)(fieldsX * Math.random());
                                int posY = (int)(fieldsY * Math.random());
    // TODO Wertebereich festlegen und randomisieren
                                double Value = 1 + Math.random();
                                long TTL = 100000;
                                long MHD = 30000;
                                tmpFood = new Food(Value, TTL, MHD, posX, posY);
                        } while (foodMngr.containsFood(tmpFood));
                        foodMngr.addFood(tmpFood);
                        logik.neuesFutter(tmpFood.getPosX(), tmpFood.getPosY(), tmpFood.getMHDinSec());
                    }
                    try {
// TODO schlafzeit noch festlegen
                        do {
                            sleep(10000);
                        } while (foodMngr.isFull());
                    } catch (InterruptedException e) {	}
            }
    }
	

}
