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
    public void tryToBeam(String index);
    public void beamTamagotchi(Tamagotchi tama);
}
