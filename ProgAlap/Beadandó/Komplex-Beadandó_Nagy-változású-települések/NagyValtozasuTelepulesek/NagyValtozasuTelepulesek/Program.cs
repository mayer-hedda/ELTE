using System;
using System.Linq;

namespace NagyValtozasuTelepulesek
{
    /*
     * Készítette: Mayer Hedda Adrienn
     * Neptun: DRWZQC
     * E-mail: drwzqc@inf.elte.hu
     *
     * Feladat:
     *      A meteorológiai intézet az ország N településére adott M napos időjárás előrejelzést,
     *      az adott településen az adott napra várt legmagasabb hőmérsékletet.
     *      Készíts programot, amely megadja azokat a településeket, ahol a hőmérséklet
     *      egyik napról a következőre legalább 10 fokot változik.
     *      Bemenet:
     *      A standard bemenet első sorában a települések száma (1≤N≤1000) és a napok száma (1≤M≤1000) van.
     *      Az ezt követő N sorban az egyes napokra jósolt M hőmérséklet értéke található (-50≤Hi,j≤50).
     *      Kimenet:
     *      A standard kimenet első sorába azon települések T számát kell kiírni,
     *      ahol a hőmérséklet egyik napról a következőre legalább 10 fokot változik!
     *      Ezt kövesse ezen települések sorszáma, növekvő sorrendben!
     */
    class Program
    {
        static void Main(string[] args)
        {
            int[][] idojaras;
            int db;
            int[] y;

            idojaras = Beolvas();
            (db, y) = Kivalogat(idojaras);
            Kiir(db, y);
        }

        // --- BEOLVASÁS ---
        static int[][] Beolvas()
        {
            if (Console.IsInputRedirected)
            {
                return BeolvasBiro();
            }
            else
            {
                return BeolvasKezi();
            }
        }

        static int[][] BeolvasBiro()
        {
            string line = Console.ReadLine();
            if (string.IsNullOrEmpty(line)) return new int[0][];
            
            string[] s = line.Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
            int n = int.Parse(s[0]);
            int m = int.Parse(s[1]);

            int[][] adatok = new int[n][];
            for (int i = 0; i < n; i++)
            {
                adatok[i] = Console.ReadLine()
                    .Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries)
                    .Select(int.Parse)
                    .ToArray();
            }
            return adatok;
        }

        static int[][] BeolvasKezi()
        {
            int n, m;
            bool ok;
            do {
                Console.Write("Települések száma (N) = ");
                ok = int.TryParse(Console.ReadLine(), out n) && n >= 0;
                if (!ok) Console.WriteLine("Nemnegatív egész szám kell!");
            } while (!ok);

            do {
                Console.Write("Napok száma (M) = ");
                ok = int.TryParse(Console.ReadLine(), out m) && m >= 0;
                if (!ok) Console.WriteLine("Nemnegatív egész szám kell!");
            } while (!ok);

            int[][] adatok = new int[n][];
            for (int i = 0; i < n; i++)
            {
                adatok[i] = new int[m];
                for (int j = 0; j < m; j++)
                {
                    do {
                        Console.Write("{0}. település {1}. nap hőmérséklete = ", i + 1, j + 1);
                        ok = int.TryParse(Console.ReadLine(), out adatok[i][j]);
                        if (!ok) Console.WriteLine("Valós szám kell!");
                    } while (!ok);
                }
            }
            return adatok;
        }

        // --- FELDOLGOZÁS (Kiválogatás) ---
        static (int, int[]) Kivalogat(int[][] idojaras)
        {
            int n = idojaras.Length;
            int[] eredmeny = new int[n];
            int db = 0;

            for (int i = 0; i < n; i++)
            {
                if (TobbMintTiz(idojaras[i]))
                {
                    eredmeny[db] = i + 1;
                    db++;
                }
            }
            Array.Sort(eredmeny, 0, db);
            return (db, eredmeny);
        }

        static bool TobbMintTiz(int[] napok)
        {
            bool van = false;
            int j = 0;
            while (!van && j < napok.Length - 1)
            {
                if (Math.Abs(napok[j + 1] - napok[j]) >= 10)
                {
                    van = true;
                }
                else
                {
                    j++;
                }
            }
            return van;
        }

        // --- KIÍRÁS ---
        static void Kiir(int db, int[] y)
        {
            if (Console.IsInputRedirected)
            {
                Console.Write(db);
                for (int i = 0; i < db; i++)
                {
                    Console.Write(" " + y[i]);
                }
                Console.WriteLine();
            }
            else
            {
                if (db == 0)
                {
                    Console.WriteLine("Nincs a feltételnek megfelelő település.");
                }
                else
                {
                    Console.WriteLine("{0} darab feltételnek megfelelő település van, sorszámaik:", db);
                    for (int i = 0; i < db; i++)
                    {
                        Console.Write(y[i] + (i == db - 1 ? "" : ", "));
                    }
                    Console.WriteLine();
                }
                Console.WriteLine("Nyomjon ENTER-t a kilépéshez!");
                Console.ReadLine();
            }
        }
    }
}