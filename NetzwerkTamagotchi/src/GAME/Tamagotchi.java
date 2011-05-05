package GAME;

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

    private long id;

    /**
     * @return the id
     */
    public long getId() {
        return id;
    }

    public Tamagotchi() {
        //TODO wahrscheinlich UUID nehmen
        this.id = System.currentTimeMillis();
    }

    public Tamagotchi(long id){
        this.id = id;
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
        //TODO auf UUID Hash umstellen
        return (int)this.id;
    }

    @Override
    public int compareTo(Tamagotchi t) {
        //TODO auf UUID umstellen
        return (int)(this.id - t.id);
    }

}
