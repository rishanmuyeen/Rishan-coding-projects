import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.InetAddress;
import java.net.Socket;

public class Client extends Frame implements Runnable {
    TextField textField;
    Button send;
    TextArea textArea;
    Socket socket;
    DataInputStream dataInputStream;
    DataOutputStream dataOutputStream;
    Thread chat;

    Client() throws IOException {
        Font font = new Font("Andale Mono", Font.PLAIN, 12);
        textField = new TextField();
        textField.setBounds(100,350,300,50);

        textArea = new TextArea();
        textArea.setBounds(20,40,450,300);
        textArea.setForeground(Color.GREEN);
        textArea.setFont(font);
        Color transparentBlack = new Color(0, 0, 0, 127); // (R, G, B, Alpha)
        textArea.setBackground(transparentBlack);

        addWindowListener(new java.awt.event.WindowAdapter() {
            public void windowClosing(java.awt.event.WindowEvent windowEvent) {
                System.exit(0);
            }
        });


        send = new Button("Send");
        send.setBounds(210,480,100,50);

        send.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String reply = textField.getText();
                textArea.append("Client: "+ reply+"\n" );
                textField.setText("");

                try {
                    dataOutputStream.writeUTF(reply);
                    dataOutputStream.flush();
                } catch (IOException ex) {
                    throw new RuntimeException(ex);
                }
            }
        });

        InetAddress serverAddress = InetAddress.getByName("123.231.111.99");
        System.out.println("Sending connection request to the server at port 12000");
        //as of now this uses the localhost but if you want to communicate with your friend then change it to the server address
        socket = new Socket("localhost", 12000);
        System.out.println("Connected to the server");
        dataInputStream = new DataInputStream(socket.getInputStream());
        dataOutputStream = new DataOutputStream(socket.getOutputStream());

        add(textArea);
        add(textField);
        add(send);

        chat = new Thread(this);
        chat.setPriority(10);
        chat.start();

        setSize(500,600);
        setTitle("Client");
        setLayout(null);
        setVisible(true);
    }

    public static void main(String[] args) throws IOException {
        new Client();
    }

    @Override
    public void run() {
        while(true){
            try {
                String message = dataInputStream.readUTF();
                textArea.append("Server: "+ message+"\n");
            } catch (Exception E){
                System.out.println(E.getMessage());
            }
        }
    }
}
