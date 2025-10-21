namespace _2025_09_16
{
    internal class Program
    {
        static void Main(string[] args)
        {
            // Egysoros kommentek
            /*
             * Többsoros komment
             */

            /*
            // ----- VÁLTOZÓK -----
            int szam = 10;
            double lebegopontos = 5.6;
            bool logikai = false;
            string szoveg = "Szöveg";


            // ----- FELDOLGOZÁS -----
            // intek összeadása, kivonása, szorzása
            int szam1 = 7;
            int szam2 = 12;

            int osszeg = szam1 + szam2;
            int kulonbseg = szam1 - szam2;
            int szorzat = szam1 * szam2;

            Console.WriteLine("A két szám ({3}, {4}) \n\tösszege: {0} \n\tkülönbsége: {1} \n\tszorzata: {2}\n", osszeg, kulonbseg, szorzat, szam1, szam2);

            // double összeadása, kivonása, szorzása
            double db1 = 2.5;
            double db2 = 3.67;

            double dbOsszeg = db1 + db2;
            double dbKulonbseg = db1 - db2;
            double dbSzorzat = db1 * db2;

            Console.WriteLine("A két lebegőpontos szám ({3}, {4}) \n\tösszege: {0} \n\tkülönbsége: {1} \n\tszorzata: {2}\n", dbOsszeg, dbKulonbseg, dbSzorzat, db1, db2);

            // bool összeadása, szorzása
            bool igaz = true;
            bool hamis = false;

            bool boolOsszeg = igaz && hamis;
            bool boolSzorzat = igaz || hamis;

            Console.WriteLine("A két logikai érték ({2}, {3}) \n\tösszege: {0} \n\tszorzata: {1}\n", boolOsszeg, boolSzorzat, igaz, hamis);

            // string összeadása
            string szoveg1 = "Hello";
            string szoveg2 = "World!";

            string strOsszeg = szoveg1 + " " + szoveg2;

            Console.WriteLine("A két szöveg összege: {0}\n", strOsszeg);

            // ----- KIIRATÁS -----
            // Console.WriteLine("Hello, World!");


            // ----- BEOLVASÁS -----
            int inputSzam;

            int.TryParse(Console.ReadLine(), out inputSzam);                        // specifikáció -> Bemenet

            int inputSzamKetszerese = inputSzam * 2;                                // specifikáció -> Utófeltétel

            Console.WriteLine("A beírt szám kétszerese: {0}", inputSzamKetszerese);  // specifikáció -> Kimenet
            */


            // ----- FELADAT -----
            /*
             * Bekérünk 2 számot a felhasználótól
             * Visszaadjuk a nagyobbikat
             * 
             * megjegyzés: nem lehetnek egyenlőek
             */

            // Bemenet
            int x, y;

            // Kimenet
            int z;

            // Bekérés
            Console.Write("Adj meg egy számot: ");
            int.TryParse(Console.ReadLine(), out x);

            Console.Write("Adj meg egy másik számot: ");
            int.TryParse(Console.ReadLine(), out y);

            // Feldolgozás
            if (x > y)
            {
                z = x;
            }
            else
            {
                z = y;
            }

            // Kiírás
            Console.WriteLine("\nA megadott számok közül a(z) {0} a nagyobb.", z);
        }
    }
}
