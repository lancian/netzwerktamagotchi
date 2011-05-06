/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package GUI;

import GUI.ISpielLogik;

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
  public void setLebensEnergie(int e, String id);
  public void delFood(int x, int y);
  public void killTamagotchi(String index);
  public void setTamagotchi(String index);
  public void beamTamagotchi(String index);

}
