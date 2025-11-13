namespace ProbaZh;

/*
 * 1. Feladat:
 *      Egy 12 oszlopot, és n sort tartalmazó mátrixban tároljuk Piripócs reggel 8 és este 8 között mért hőmérsékleteit.
 *      Válogasd ki azokat a hőmérsékleteket minden napra, a maximális hőmérsékletet!
 *
 * Specifikáció: https://progalap.elte.hu/specifikacio/v1/?uuid=04b01a41-0aff-4aa0-a0f7-4274930800b3
 * Stuktogram: https://progalap.elte.hu/stuki/v1/?uuid=306ebc92-f316-4233-bef1-a82e00123c2b
 *
 * Visszavezetési táblázat:
 *      Másolás:
 *          e       ~   1
 *          u       ~   n
 *          f(i)    ~   MAX(1..j, meresek[i][j])
 *
 *      Maximumkiválasztás:
 *          e       ~   1
 *          u       ~   12
 *          f(i)    ~   meresek[i][j]
 *
 *
 * 2. Feladat:
 *
 * Stuktogram: https://progalap.elte.hu/stuki/v1/?uuid=fd134d79-d089-40b2-a230-67c457958e3f
 * Kód: 
 */

class Program
{
    struct Hallgato
    {
        public string nev;
        public int kor;
        public bool golya;
    }
    
    static bool golyaE(Hallgato h)
    {
        return h.golya == true;
    }
    
    static void Main(string[] args)
    {
        // Bekérés
        int n;
        do
        {
            Console.Write("Hallgatók száma: ");
            n = int.Parse(Console.ReadLine());
        } while (!(n >= 1 && n <= 100));
        
        Hallgato[] l =  new Hallgato[n];
        for (int i = 0; i < n; i++)
        {
            do
            {
                string[] s = Console.ReadLine().Split(" ");
                l[i].nev = s[0];
                l[i].kor = int.Parse(s[1]);
                l[i].golya = bool.Parse(s[2]);
            } while (!(l[i].kor <= 25 && l[i].kor >= 17));

        }
        
        
        // Feldolgozás:
        int db = 0;
        for (int i = 0; i < n; i++)
        {
            if (golyaE(l[i])) db++;
        }
        
        
        // Kiírás:
        Console.WriteLine($"A megadott hallgatók között {db} db gólya van.");
    }
}