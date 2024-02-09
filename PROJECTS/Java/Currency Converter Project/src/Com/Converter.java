// last update with the currency values 8/2/2024
package Com;
import java.util.*;
import java.text.DecimalFormat;
public class Converter {
    public static void main(String[] args){
        Scanner input = new Scanner(System.in);
        double amount,changed_amount,amount_to_convert;
        int option, current_currency,optionIndex = -1;

        //Prompts
        String[] names_currency ={"$","LKR","INR","Pounds"};
        System.out.println("1.US Dollars\n2.LKR Rupees\n3.INR Rupees\n4.Pounds\nEnter in numeric value");
        System.out.println("Welcome to Currency convertor\nWhat currency do you have?");
        current_currency = input.nextInt();// the input for the current currency

        // setting i variable for the loop to start from 0
        int i = current_currency-1;

        System.out.println("which currency do you want to change to?");
        option = input.nextInt();// input for the which currency to change to

        //To check whether the conversion happens with different currency
        for (int j = 0; j < names_currency.length; j++) {
            if (names_currency[j].equals(names_currency[option - 1])) {
                optionIndex = j;
                break;
            }
        }
        if(current_currency== optionIndex) {
            System.out.println("Please enter different currency values");
        }

        //Gets the amount to convert
        System.out.println("Enter the amount:");
        amount = input.nextDouble();// amount of the current currency

        //verifying the amount
        System.out.println("The total amount is, " + names_currency[i] + amount);// verification

        amount_to_convert = amount;


        //converting the currency to US as benchmark
        if (names_currency[i].equals("LKR")) {
            amount_to_convert = amount / 313.04;
        } else if (names_currency[i].equals("INR")) {
            amount_to_convert = amount / 82.98;
        } else if (names_currency[i].equals("$")) {
            amount_to_convert = amount;
        } else if (names_currency[i].equals("Pounds")) {
            amount_to_convert = amount/0.79;
        }

        //formatting the amount to 2 decimal places
        DecimalFormat df = new DecimalFormat("#.##");

        //converting US dollars to the specific currency
        switch (option){
            case 3:
                changed_amount = amount_to_convert * 82.98 ;
                System.out.println("The converted amount is, INR "+df.format(changed_amount));
                break;
            case 1:
                changed_amount = amount_to_convert;
                System.out.println("The converted amount is, $" + df.format(changed_amount));
                break;
            case 2:
                changed_amount = amount_to_convert * 313.04;
                System.out.println("The converted amount is, LKR" + df.format(changed_amount));
                break;
            case 4:
                changed_amount = amount_to_convert * 0.79;
                System.out.println("The converted amount is, Pounds" + df.format(changed_amount));
                break;
            default:
                System.out.println("Error please select valid inputs");
        }

    }

}
