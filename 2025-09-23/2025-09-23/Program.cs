namespace _2025_09_23
{
    internal class Program
    {
        static void Main(string[] args)
        {
            // ----- Háromszög egyenlőtlenség -----
            // Specifikáció: https://progalap.elte.hu/specifikacio/v1/?uuid=9f85f0b6-7fa3-464e-be23-6358365c3a37
            // Stuki: https://progalap.elte.hu/stuki/v1/?uuid=7b3841d7-3c00-4331-9d15-200cecd94324

            //double a, b, c;     // Bemenet
            //bool x;           // Kimenet

            //Console.Write("Adja meg a háromszög a oldalát: ");
            //Double.TryParse(Console.ReadLine(), out a);

            //Console.Write("Adja meg a háromszög b oldalát: ");
            //Double.TryParse(Console.ReadLine(), out b);

            //Console.Write("Adja meg a háromszög c oldalát: ");
            //Double.TryParse(Console.ReadLine(), out c);

            //if (a + b > c && a + c > b && b + c > a)
            //{
            //    x = true;
            //}
            //else
            //{
            //    x = false;
            //}

            //Console.WriteLine("A megadott oldalakból lehetséges háromszöget alkotni. Ennek az állításnak az eredménye: {0}", x);



            // ----- Faktoriális -----
            // Specifikáció: https://progalap.elte.hu/specifikacio/v1/?uuid=c0d15b05-5f62-4e17-ad09-4e4e28752904
            // Stuki: https://progalap.elte.hu/stuki/v1/?uuid=73e15999-d59f-43d6-a1b0-cfede9438e09

            int x;              // Bemenet
            int eredmeny = 1;   // Kimenet

            Console.Write("Adja meg a faktoriális számát: ");
            int.TryParse(Console.ReadLine(), out x);

            for (int i = 1; i <= x; i++)
            {
                eredmeny *= i;
            }

            Console.WriteLine("{0}! = {1}", x, eredmeny);



            // ----- Óra, perc, másodperc átváltás -----
            // Specifikáció: https://progalap.elte.hu/specifikacio/v1/?uuid=75121b14-e6f6-4937-9840-bbbb252ab0d2
            // Stuki: https://progalap.elte.hu/stuki/v1/?uuid=c31eeaa7-aec7-420e-96a8-af44dd7e1615

            int ora, perc, masodperc;   // Bemenet
            int mp;                     // Kimenet
            
            Console.Write("Adja meg az órát: ");
            int.TryParse(Console.ReadLine(), out ora);

            Console.Write("Adja meg a percet: ");
            int.TryParse(Console.ReadLine(), out perc);

            Console.Write("Adja meg a másodpercet: ");
            int.TryParse(Console.ReadLine(), out masodperc);

            mp = ora * 3600 + perc * 60 + masodperc;

            Console.WriteLine("{0} óra, {1} perc és {2} másodperc összesen {3} másodperc.", ora, perc, masodperc, mp);



            // ----- [0, 100] intervallum 5-el osztható számok -----
            // Specifikáció:
            // Stuki: 


        }
    }
}
