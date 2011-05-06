package GAME;

import java.util.*;
import GUI.*;


public class FoodManager extends Thread {
	
	private List<Food> foodList = new ArrayList<Food>();

    private int maxFields = 0;
    private ISpielLogik logik = null;

	public FoodManager(int fieldsX, int fieldsY, ISpielLogik logik) {
            maxFields = (fieldsX + 1)*(fieldsY + 1);
            this.logik = logik;
	}
	
	@Override
	public void run() {
		synchronized (foodList) {
                    for (Food tmpFood : foodList) {
                        if (!tmpFood.checkState()){
                            foodList.remove(tmpFood);
                            logik.delFood(tmpFood.getFieldX(), tmpFood.getFieldY());
                        }
                    }
		}
		try {
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}
	
	public void addFood(Food food){
            synchronized (foodList) {
                foodList.add(food);
                Collections.sort(foodList);
            }
	}
	
	public boolean containsFood(Food food){
            return foodList.contains(food);
	}
	
//	public Food getFoodToEat(int posX, int posY){
//        int fieldX = posX / 50;
//        int fieldY = posY / 50;
    public Food getFoodToEat(int fieldX, int fieldY){
        synchronized (foodList) {
                int search = Collections.binarySearch(foodList, new Food(fieldX,fieldY));
                if ( search != -1 ){
                    Food returnFood = foodList.get(search);
                    foodList.remove(search);
                    return returnFood;
                } else {
                    return null;
                }
            }
	}

        public boolean isFull(){
            if ( foodList.size() >= maxFields ){
                return true;
            } else {
                return false;
            }
        }

}