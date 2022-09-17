package Patterns;
import java.util.Scanner;

public class OnlyDiamondPattern {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter a Value to print Cross Pattern: ");
        int n = 10;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                //System.out.print(n-1);
                if (j == 0 || j == n - 1 || i == 0 || i == n - 1 || i+j <= (n-1)/2 || i-j >(n-1)/2 || j-i >(n-1)/2 || i+j >(n-1)+(n-1)/2)
                    System.out.print("* ");
                else
                    System.out.print("  ");
            }
            System.out.println(" ");
        }
    }
}
