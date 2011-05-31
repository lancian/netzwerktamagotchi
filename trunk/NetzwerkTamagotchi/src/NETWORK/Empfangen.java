/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package NETWORK;
import java.net.*;
import java.io.*;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author Steffen
 */

public class Empfangen {

    public void empfangen_IPs(int port, String mulitcastIp, int bufferGroesse) throws IOException {
        MulticastSocket udpReceive = new MulticastSocket(port);
        InetAddress gruppe = InetAddress.getByName(mulitcastIp);
        udpReceive.joinGroup(gruppe);
        byte[] buffer = new byte[bufferGroesse];
        DatagramPacket Receive = new DatagramPacket(
        buffer, bufferGroesse);
        udpReceive.receive(Receive);
        if ( Receive.getData() == "Tamagotchi".getBytes() ){
            // In Datenbank IP Adresse speichern und aktuelles Datum
            // Receive.getAddress();
        }
    }

    private void liste_aktualisieren(){
        //Aus Datenbank
    }

    public void empfangen_tamagotchi (int port) throws IOException {
        GAME.Tamagotchi tama = null;
        ServerSocket serverSocket = new ServerSocket(port);
        Socket socket = serverSocket.accept();
        ObjectInputStream ois = new ObjectInputStream(socket.getInputStream());
        try {
            tama = (GAME.Tamagotchi) ois.readObject();
        } catch (ClassNotFoundException ex) {
        }
        ois.close();

        // Funktionsaufruf:
        // Der Logik sagen, dass ein Tamagotchi da ist.
    }
}
