using System;
using TextFile;

namespace SzamitastechnikaiUzlet;

class Program
{
    static void Main(string[] args)
    {
        try
        {
            TextFileReader beolvaso = new("input.txt");
            int napiOsszBevetel = 0;

            while (beolvaso.ReadLine(out string aktualisSor))
            {
                if (string.IsNullOrWhiteSpace(aktualisSor)) continue;

                string[] adatsor = aktualisSor.Split(' ', StringSplitOptions.RemoveEmptyEntries);
                
                if (adatsor.Length > 0)
                {
                    Szamla aktualisSzamla = new(adatsor[0]);

                    for (int i = 2; i < adatsor.Length; i += 2)
                    {
                        if (int.TryParse(adatsor[i], out int termekAr))
                        {
                            aktualisSzamla.UjTetel(termekAr);
                        }
                    }
                    
                    napiOsszBevetel += aktualisSzamla.Osszeg;
                }
            }

            Console.WriteLine(napiOsszBevetel);
        }
        catch (Exception)
        {
            Console.WriteLine("nincs");
        }
    }
}