namespace Progalap_hf_1
{
    internal class Program
    {
        static void Main(string[] args)
        {
            /*
             * Feladat: Szignum függvény megvalósítása
             * sgn(-3) --> -1
             * sgn(3) --> 1
             * 
             * Specifikáció: https://progalap.elte.hu/specifikacio/v1/?uuid=1af3782b-fe63-4293-aead-d34eb8f323cb
             * Stuktogram: https://progalap.elte.hu/stuki/v1/?uuid=1b439522-b30e-4dcb-83c9-6208d0061756
             */

            double x;       // Bemenet
            double y;       // Kimenet

            Console.Write("Írj be egy számot: ");
            Double.TryParse(Console.ReadLine(), out x);

            if (x > 0)
            {
                y = 1;
            }
            else if (x < 0)
            {
                y = -1;
            }
            else
            {
                y = 0;
            }

            Console.WriteLine($"A(z) {x} szám szignuma: {y}");
        }
    }
}
