namespace KevesKonyv
{
/*
 * Specifikáció: https://progalap.elte.hu/specifikacio/v1/?uuid=e66ec342-bf86-42e7-b132-af9f3674fed0
 * Stuktogram: https://progalap.elte.hu/stuki/v1/?uuid=d662449a-e33d-46de-8900-f56849d8b112
 */
    class Program
    {
        struct Konyvtar
        {
            public string szerzo;
            public string cim;
            public int peldany;
            public int kolcsonzott;
        }
        
        static void Main(string[] args)
        {
            int n;
            int.TryParse(Console.ReadLine(), out n);
            Konyvtar[] k =  new Konyvtar[n];

            for (int i = 0; i < n; i++) 
            {
                string[] sor = Console.ReadLine().Split(';');
                
                k[i].szerzo = sor[0];
                k[i].cim = sor[1];
                k[i].peldany = int.Parse(sor[2]);
                k[i].kolcsonzott = int.Parse(sor[3]);
            }

            int db = 0;
            int[] y = new int[n];

            for (int i = 0; i < n; i++)
            {
                if (k[i].peldany - k[i].kolcsonzott <= 2)
                {
                    y[db] = i+1;
                    db++;
                }
            }
            
            Console.Write(db);
            for (int i = 0; i < db; i++)
            {
                Console.Write(" " + y[i]);
            }
        }
    }
}