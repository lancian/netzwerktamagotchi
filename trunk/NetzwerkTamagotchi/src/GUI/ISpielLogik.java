/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package GUI;

import GAME.Tamagotchi;

/**
 *
 * @author sschmiech
 */
public interface ISpielLogik {
    public void neuesFutter(int x, int y, int haltbarkeit);
    public void zeigeSpielOberflaeche();
    public void setBreiteOberflaeche( int breite);
    public void setHoeheOberflaeche( int hoehe);
    public void setLifepoints(int e, String id);
    public void delFood(int x, int y);
    public void killTamagotchi(String index);
    public void setTamagotchi(Tamagotchi tama);
}
