using System; 

namespace KulonbozoEletkoruDolgozokSzama
{
    /*
     * Mayer Hedda Adrienn - DRWZQC
     * drwzqc@inf.elte.hu
     *
     * Feladat:
     *     Egy vállalat tárolja dolgozói életkorát és fizetését.
           Írj programot, amely megadja, hányféle életkorú ember van a vállalatnál!
           Bemenet:
           A standard bemenet első sorában az emberek száma (1≤N≤100), alatta so-
           ronként egy-egy ember kora (1≤K≤100) és a fizetése van (0≤F≤2 000 000).
           Kimenet:
           A standard kimenet egyetlen sorába egyetlen egész számot kell írni, a
           különböző életkorú dolgozók számát!
     * 
     * 
     */
    class Program
    {
        struct Dolgozok
        {
            public int kor;
            public int fizetes;
        } 
    
        static Boolean elso(int i, Dolgozok[] l)
        {
            int j = 0;

            while (j <= i-1 && l[i].kor != l[j].kor)
            {
                j++;
            }

            return j > i - 1;
        }
    
        static void Main(string[] args)
        {
            // BEKÉRÉS:
            // Console.Write("Adja meg a dolgozók számát: ");
            int n = int.Parse(Console.ReadLine());
        
            Dolgozok[] l = new Dolgozok[n];
            for (int i = 0; i < n; i++)
            {
                // Console.Write($"Adja meg az {i+1}. dolgozó korát és fizetését szóközzel elválasztva: ");
                String s = Console.ReadLine();
                l[i].kor = int.Parse(s.Split(' ')[0]);
                l[i].fizetes = int.Parse(s.Split(' ')[1]);
            }
        
        
            // FELDOLGOZÁS:
            int db = 0;

            for (int i = 0; i < n; i++)
            {
                if (elso(i, l))
                {
                    db++;
                }
            }
        
        
            // KIÍRÁS:
            Console.WriteLine(db);
            // Console.WriteLine($"{db} db különböző életkorú dolgozó szerepel a megadott listában.");
        }
    }
}