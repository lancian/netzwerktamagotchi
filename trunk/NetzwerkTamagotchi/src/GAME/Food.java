package GAME;


public class Food implements Comparable<Food> {

    private double startValue = 0;
    private final double lowLimit = 0.9;
    private long MHD = 0;
    private long TTL = 0;
    private long creation = 0;
    private int fieldX = 0;
    private int fieldY = 0;

    public int getPosX() {
            return getFieldX()*50;
    }

    public int getPosY() {
            return getFieldY()*50;
    }

    /**
     * @return the fieldX
     */
    public int getFieldX() {
        return fieldX;
    }

    /**
     * @return the fieldY
     */
    public int getFieldY() {
        return fieldY;
    }

    public int getMHDinSec(){
        return (int) MHD/1000;
    }


    public Food(int Value) {
             this.startValue = Value;
    }

    /**
     * Constructor to search for a food on the given field
     * @param X Field X
     * @param Y Field Y
     */
    public Food(int X, int Y) {
            this.fieldX = X;
            this.fieldY = Y;
    }

    /**
     * Default Constructor
     * @param Value
     * @param TTL
     * @param MHD
     * @param posX
     * @param posY
     */
    public Food(double Value, long TTL, long MHD, int posX, int posY){
        creation = System.currentTimeMillis();
        this.startValue = Value;
        this.TTL = TTL;
        this.MHD = MHD;
        this.fieldX = posX;
        this.fieldY = posY;
    }

    @Override
    public String toString() {
            return "Value = " + this.startValue;
    }

    public double getFoodValue(){
        if (System.currentTimeMillis() >= creation + MHD ){
            if (System.currentTimeMillis() >= creation + 2*MHD){
                return (int)lowLimit;
            } else {
                double deterioation = (1 - lowLimit) / MHD;
                return ( 1 - (System.currentTimeMillis() - creation - MHD) * deterioation);
            }
        } else {
            double deterioation = (startValue - 1) / MHD;
            return (startValue - (System.currentTimeMillis() - creation) * deterioation);
        }
    }

    public boolean checkState(){
            if (System.currentTimeMillis() > TTL ){
                    return false;
            } else {
                    return true;
            }
    }

    @Override
    public boolean equals(Object obj) {
        if ( obj == null || this.getClass() != obj.getClass() ) {
                return false;
        } else {
                Food tmp = (Food) obj;
                return this.fieldX == tmp.fieldX && this.fieldY == tmp.fieldY;
        }
    }

    @Override
    public int hashCode() {
            return getFieldX()*100000 + getFieldY();
    }

@Override
    public int compareTo(Food o) {
            int comparison = this.fieldX - o.fieldX;
            if(comparison != 0){
                    return comparison;
            }
            return this.fieldY - o.fieldY;
    }

}
