namespace Progalap_hf_2
{
    internal class Program
    {
        static void Main(string[] args)
        {
            /*
             * Feladat: Fibonacci számok --> Irasd ki az első n darabot.
             * Tömbök használatával (3 pont)
             * Tömbök nélkül (7 pont)
             */

            int n;      // Bemenet
            int aktualis;
            int elso = 0;
            int masodik = 1;

            Console.Write("Kérem adja meg n értékét: ");
            int.TryParse(Console.ReadLine(), out n);

            for (int i = 0; i < n; i++)
            {
                if (i == 0)
                {
                    Console.Write($"A Fibonacci sorozat első {n} száma: {elso}");
                    continue;
                } 
                else if (i == 1)
                {
                    Console.Write(", " + masodik);
                    continue;
                }

                aktualis = elso + masodik;
                Console.Write(", " + aktualis);

                elso = masodik;
                masodik = aktualis;
            }

        }
    }
}
