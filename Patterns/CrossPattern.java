package Patterns;
import java.util.Scanner;

public class CrossPattern {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter a Value to print Cross Pattern: ");
        int n = 8;

        for(int i = 0;i < n; i++)
        {
            for (int j = 0; j < n; j++)
            {
                //System.out.print(n-1);
                if( j == 0 || j== n-1 ||i==0||i==n-1 || i+j == n-1 || i == j)
                    System.out.print("* ");
                else
                    System.out.print("  ");
            }
            System.out.println(" ");
        }
    }
}
