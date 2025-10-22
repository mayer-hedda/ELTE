namespace ANapAmikorNemVoltKapas;
/*
 * Specifikáció: https://progalap.elte.hu/specifikacio/v1/?uuid=bb49ba74-3440-4fc7-81a7-9012bf8d00a3
 * Stuktogram: https://progalap.elte.hu/stuki/v1/?uuid=07431a52-e4b2-4e4d-adba-7f5e406436a3
 */

class Program
{
    static void Main(string[] args)
    {
        // Bekérés
        int n;
        int.TryParse(Console.ReadLine(), out n);
        
        int[] fogasok =  new int[n];
        for (int j = 0; j < n; j++)
        {
            int.TryParse(Console.ReadLine(), out fogasok[j]);
        }
        
        
        // Feldolgozás
        int i = 1;
        int ind = -1;
        while (i < n && fogasok[i-1] != 0)
        {
            i++;
        }

        bool van = i < n;
        if (van)
        {
            ind = i;
        }


        // Kiírás
        Console.WriteLine($"{ind}");
    }
}