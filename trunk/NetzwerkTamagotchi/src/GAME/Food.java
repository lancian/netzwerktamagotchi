package GAME;


public class Food implements Comparable<Food> {

    private double startValue = 0;
    private final double lowLimit = -10;
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
	
    private int index = 0;

    public int getIndex() {
            return index;
    }

    public void setIndex(int index) {
            this.index = index;
    }

    public int getMHDinSec(){
        return (int) MHD/1000;
    }


    public Food(int Value) {
             this.startValue = Value;
    }

//	TODO nur f�r testzwecke
    public Food(int X, int Y) {
            this.fieldX = X;
            this.fieldY = Y;
    }

    public Food(int Value, long TTL, long MHD, int posX, int posY){
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

    public int getFoodValue(){
        if (System.currentTimeMillis() >= creation + MHD ){
            if (System.currentTimeMillis() >= creation + 2*MHD){
                return (int)lowLimit;
            } else {
                double deterioation = lowLimit / MHD;
                return (int)((System.currentTimeMillis() - creation - MHD) * deterioation);
            }
        } else {

            double deterioation = (startValue) / MHD;
            return (int)(startValue - (System.currentTimeMillis() - creation) * deterioation);
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
//		int tmpPosX = posX; 
//		for ( int i= 0; i < Math.floor(Math.log10(posY))+1 ; i++ ){
//			tmpPosX = tmpPosX * 10;
//		}
//		return tmpPosX + posY;
            return getFieldX()*100000 + getFieldY();
    }

@Override
    public int compareTo(Food o) {
            // TODO Auto-generated method stub
            int comparison = this.fieldX - o.fieldX;
            if(comparison != 0){
                    return comparison;
            }
            return this.fieldY - o.fieldY;
    }

}
