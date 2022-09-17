package Patterns;
import java.util.Scanner;

public class ButterFly {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter a Value to print Cross Pattern: ");
        int n = 15;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                //System.out.print(n-1);
                if ((j<=i && i+j <= (n-1)) || ((j>=i) && (i+j)>=n-1))
                    System.out.print("* ");
                else
                    System.out.print("  ");
            }
            System.out.println(" ");
        }
    }
}
