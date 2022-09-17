package Patterns;
import java.util.Scanner;

public class TriangleAndInvertedPattern {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter a Value to print Cross Pattern: ");
        int n = 10;
        for (
                int i = 0;
                i < n; i++) {
            for (int j = 0; j < n; j++) {
                //System.out.print(n-1);
                //if(j== 0|| j == n-1) System.out.print(": ");
                if (j >i && j+i <=n-1 || j<=i && j+i >n-1)
                    System.out.print("* ");
                else
                    System.out.print("  ");
            }
            System.out.println(" ");
        }
    }
}
