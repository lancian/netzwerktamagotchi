package GAME;
import GUI.*;

public class Tamagotchi {

    private int healthPoints = 25;

    public int getHealthPoints() {
            return healthPoints;
    }

    public void setHealthPoints(int healthPoints) {
            this.healthPoints = healthPoints;
    }

    private FoodManager foodMngr = null;
    private ISpielLogik gui = null;

    /**
     * @param foodMngr the foodMngr to set
     */
    public void setFoodMngr(FoodManager foodMngr) {
        this.foodMngr = foodMngr;
    }

    /**
     * @param gui the gui to set
     */
    public void setGui(ISpielLogik gui) {
        this.gui = gui;
    }

    private long id;

    /**
     * @return the id
     */
    public long getId() {
        return id;
    }


    public Tamagotchi(FoodManager foodMngr, ISpielLogik gui) {
            this.foodMngr = foodMngr;
            this.gui = gui;
            this.id = System.currentTimeMillis();
    }

    public Tamagotchi() {
            // TODO Auto-generated constructor stub
    }

    public boolean eatFood(int posX, int posY){
            Food tmpFood = foodMngr.getFoodToEat(posX, posY);
            if(tmpFood == null){
                return false;
            } else {
                healthPoints = healthPoints - tmpFood.getFoodValue();
                if ( healthPoints <= 0 ){
                    gui.killTamagotchi(id);
                } else {
                    gui.setLifepoints(healthPoints);
                    gui.delFood(tmpFood.getFieldX(), tmpFood.getFieldY());
                }

            }
            return true;
    }
	
}
