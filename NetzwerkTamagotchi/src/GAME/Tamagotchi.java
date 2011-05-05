package GAME;

import java.util.UUID;

public class Tamagotchi implements Comparable<Tamagotchi> {

    //TODO to be defined
    private int healthPoints = 25;
    private int maxHealthPoints = 100;

    public int getHealthPoints() {
            return healthPoints;
    }

    public void setHealthPoints(int healthPoints) {
            this.healthPoints = healthPoints;
    }

    private UUID id;

    /**
     * @return the id
     */
    public String getId() {
        return id.toString();
    }

    public Tamagotchi() {
        this.id = UUID.randomUUID();
    }

    public Tamagotchi(String id){
        this.id = UUID.fromString(id);
    }

    public boolean eatFood(Food food){
        healthPoints = healthPoints - food.getFoodValue();
        if ( healthPoints <= 0 ){
            return false;
        } else if ( healthPoints > maxHealthPoints ) {
            healthPoints = maxHealthPoints;
        }
        return true;
    }

    @Override
    public boolean equals(Object obj) {
        if ( obj == null || this.getClass() != obj.getClass() ) {
                return false;
        } else {
                Tamagotchi tmp = (Tamagotchi) obj;
                return this.id == tmp.id;
        }
    }

    @Override
    public int hashCode() {
        return id.hashCode();
    }

    @Override
    public int compareTo(Tamagotchi t) {
        return this.id.compareTo(t.id);
    }

}
