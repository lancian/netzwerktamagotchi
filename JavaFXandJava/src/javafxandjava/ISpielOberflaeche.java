/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package javafxandjava;

/**
 *
 * @author sschmiech
 */
public interface ISpielOberflaeche {
  public void addData(String name, float data);
  public void zeigeSpielOberflaeche();
  public void setLogik(ISpielLogik logik);
  public void addFutter(int haltbarkeit, int x, int y);
  public int getBreiteOberflaeche();
  public int getHoeheOberflaeche();
  public void setBreiteOberflaeche( int breite);
  public void setHoeheOberflaeche( int hoehe);

  //Felix
  public void setLebensEnergie(int e);
  public void delFood(int x, int y);
//  public void updateFood(int index, int haltbarkeit);

}
