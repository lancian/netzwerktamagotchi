package GAME;

import java.util.UUID;

public class Tamagotchi implements Comparable<Tamagotchi> {

    //TODO to be defined
    private int healthPoints = 250;
    private int maxHealthPoints = 1000;

    public int getHealthPoints() {
            return healthPoints;
    }

    public boolean setHealthPoints(int healthPoints) {
        this.healthPoints = healthPoints;
        if (healthPoints <= 0) {
            return false;
        } else {
            return true;
        }
    }

    private UUID id;

    /**
     * @return the id
     */
    public String getId() {
        return id.toString();
    }

    /**
     * Default Constructor
     */
    public Tamagotchi() {
        this.id = UUID.randomUUID();
    }

    public Tamagotchi(String id){
        this.id = UUID.fromString(id);
    }

    public boolean eatFood(Food food){
        healthPoints = (int)( healthPoints * food.getFoodValue() );
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
                return this.id.equals(tmp.id);
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

    public boolean tryToBeam(){
        if (healthPoints >= maxHealthPoints/0.5){
            healthPoints = (int)( healthPoints * 0.75);
            return true;
        } else {
            return false;
        }
    }

}
