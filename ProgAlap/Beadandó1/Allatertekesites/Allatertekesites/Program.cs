using System;

namespace Allatertekesites
{
/*
 * Mayer Hedda Adrienn - DRWZQC - drwzqc@inf.elte.hu
 *
 * ----------
 *
 * FELADAT - Állatértékesítés:
 *
 * Egy állatkereskedő N napon keresztül forgalmaz állatokat. Minden napra ismerjük, hogy addig mekkora bevétele volt.
 * Készíts programot, amely megadja, hogy a kereskedő hány napon adott el állatot!
 *
 * Bemenet:
 * A standard bemenet első sorában található a napok száma (1≤N≤100) van.
 * Az ezt követő N sorban pedig az addigi bevétel értékei vannak (0≤Bi≤1000000).
 *
 * Kimenet:
 * A standard kimenet egyetlen sorába ki kell írni az eladások számát!
 *
 * ----------
 *
 * Specifikáció: https://progalap.elte.hu/specifikacio/v1/?uuid=a040865f-553a-4144-aac2-3aca08ed8769
 * Stuktogram: https://progalap.elte.hu/stuki/v1/?uuid=20e6f4be-6391-4b51-be87-b43aaa38a837
 */

    class Program
    {
        static void Main(string[] args)
        {
            // Bekérés
            int n;

            // Console.Write("Napok száma: "); 
            int.TryParse(Console.ReadLine(), out n);

            int[] bevetel = new int[n];

            // Console.WriteLine("Bevételek: ");
            for (int i = 0; i < bevetel.Length; i++)
            {
                // Console.Write($"\t{i+1} nap: ");
                int.TryParse(Console.ReadLine(), out bevetel[i]);
            }

            // Feldolgozás
            int db = 0;
            for (int i = 0; i < n; i++)
            {
                if ((i == 0 && bevetel[i] > 0) || (i > 0 && bevetel[i] > bevetel[i - 1]))
                {
                    db++;
                }
            }

            // Kiírás
            // Console.WriteLine($"A kereskedő {db} napon adott el állatot.");
            Console.WriteLine(db);
        }
    }
}   