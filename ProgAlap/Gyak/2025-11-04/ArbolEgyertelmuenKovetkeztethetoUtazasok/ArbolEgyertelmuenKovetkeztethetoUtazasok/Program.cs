namespace ArbolEgyertelmuenKovetkeztethetoUtazasok;

// Specifikáció: https://progalap.elte.hu/specifikacio/v1/?uuid=7670348d-91be-40a9-bb11-62f518f9f245
// Stuktogram: https://progalap.elte.hu/stuki/v1/?uuid=e23e7223-6ab9-4a41-bbed-2178ab8b1cf9

class Program
{
    struct Rep
    {
        public int t;
        public int a;
    }

    static int darab(int n, Rep[] l, int j)
    {
        int temp = 0;
        for (int i = 0; i < n; i++)
        {
            if (l[i].a == l[j].a)
            {
                temp++;
            }
        }
        
        return temp;
    }
    
    static void Main(string[] args)
    {
        // Bekérés:
        int n;
        int.TryParse(Console.ReadLine(), out n);

        Rep[] l = new Rep[n];
        for (int i = 0; i < n; i++)
        {
            int[] adat = Console.ReadLine().Split(' ').Select(int.Parse).ToArray();
            
            l[i].t = adat[0];
            l[i].a = adat[1];
        }

        int db = 0;
        
        // Feldolgozás:
        for (int i = 0; i < n; i++)
        {
            if (darab(n, l, i) == 1)
            {
                db++;
            }
        }
        
        // Kiírás:
        Console.WriteLine(db);
    }
}