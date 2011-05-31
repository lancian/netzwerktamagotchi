/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package NETWORK;

import java.io.*;
import java.net.*;
import java.util.*;

/**
 *
 * @author Steffen
 */
public class Senden {

    public void Senden_IPs(int port, String mulitcastIp, int bufferGroesse, int intervall) throws IOException {
        DatagramSocket udpSend = new DatagramSocket(port);
        byte[] buffer = new byte[bufferGroesse];
        DatagramPacket Send = new DatagramPacket(
                                    buffer, buffer.length,
                                    InetAddress.getByName(mulitcastIp), port);
        buffer = ("Tamagotchi".getBytes());
        Send.setData(buffer);
        long z = new Date().getTime();

        while(true){
            if(z < new Date().getTime()){
                udpSend.send(Send);
                z = z + (intervall * 60000);
            }
        }
        
    }

    public boolean senden_tamagotchi(GAME.Tamagotchi tama, int port, String host) throws IOException{
        try {
            Socket socket = new Socket(host, port);
            ObjectOutputStream oos = new ObjectOutputStream(socket.getOutputStream());
            oos.writeObject(tama);
            oos.flush();
            oos.close();
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}





