import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;

public class Server extends Frame implements Runnable {
    TextField textField;
    Button send;
    TextArea textArea;
    ServerSocket serverSocket;
    Socket socket;
    DataInputStream dataInputStream;
    DataOutputStream dataOutputStream;
    Thread chat;

    Server() throws IOException {
        Font font = new Font("Andale Mono", Font.PLAIN, 12);
        textField = new TextField();
        textField.setBounds(100,350,300,50);

        textArea = new TextArea();
        textArea.setBounds(20,40,450,300);
        textArea.setForeground(Color.GREEN);
        textArea.setFont(font);
        Color transparentBlack = new Color(0, 0, 0, 127); // (R, G, B, Alpha)
        textArea.setBackground(transparentBlack);

        send = new Button("Send");
        send.setBounds(210,480,100,50);

        addWindowListener(new java.awt.event.WindowAdapter() {
            public void windowClosing(java.awt.event.WindowEvent windowEvent) {
                System.exit(0);
            }
        });


        send.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String reply = textField.getText();
                textArea.append("Server: "+ reply+"\n" );
                textField.setText("");

                try {
                    dataOutputStream.writeUTF(reply);
                    dataOutputStream.flush();
                } catch (IOException ex) {
                    throw new RuntimeException(ex);
                }
            }
        });

        serverSocket = new ServerSocket(12000);
        System.out.println("Server is open at port 12000");
        socket = serverSocket.accept();
        System.out.println("Server is connected to the client!");
        dataInputStream = new DataInputStream(socket.getInputStream());
        dataOutputStream = new DataOutputStream(socket.getOutputStream());

        add(textArea);
        add(textField);
        add(send);

        chat = new Thread(this);
        chat.setPriority(10);
        chat.start();

        setSize(500,600);
        setTitle("Server");
        setLayout(null);
        setVisible(true);
    }

    public static void main(String[] args) throws IOException {
        new Server();
    }

    @Override
    public void run() {
        while(true){
            try {
                String message = dataInputStream.readUTF();
                textArea.append("Client: "+ message+"\n");
            } catch (Exception E){
                System.out.println(E.getMessage());
            }
        }
    }
}
