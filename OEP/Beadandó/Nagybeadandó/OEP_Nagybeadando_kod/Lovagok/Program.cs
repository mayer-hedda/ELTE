namespace Lovagok
{
    public class Jatek
    {
        private List<Lovag> _lovagok = new();
        private List<Tartomany> _tartomanyok = new();

        public Jatek(string fajlNev) => Betolt(fajlNev);

        public void Betolt(string fajlNev)
        {
            string[] sorok = File.ReadAllLines(fajlNev);

            string[] elemek = sorok[0].Split(' ');
            for (int i = 0; i < elemek.Length - 1; i += 2)
            {
                string nev = elemek[i];
                string tipus = elemek[i + 1];
                Tartomany t = tipus switch
                {
                    "K" => new Kiralyi(nev),
                    "S" => new Semleges(nev),
                    "E" => new Ellenseges(nev),
                    _ => throw new Exception($"Ismeretlen tartomány típus: {tipus}")
                };
                _tartomanyok.Add(t);
            }

            for (int i = 1; i < sorok.Length; i++)
            {
                if (string.IsNullOrWhiteSpace(sorok[i])) continue;
                string[] reszek = sorok[i].Split(' ');
                string nev = reszek[0];
                string fajta = reszek[1];
                Lovag l = fajta switch
                {
                    "o" => new Ovatos(nev),
                    "b" => new Bator(nev),
                    "v" => new Vakmero(nev),
                    _ => throw new Exception($"Ismeretlen lovag típus: {fajta}")
                };
                _lovagok.Add(l);
            }
        }

        public void Futtat()
        {
            int kor = 1;
            while (!SikeresE() && _lovagok.Any(l => l.IsElo()))
            {
                Console.WriteLine($"\n=== {kor}. kör ===");
                foreach (Lovag l in _lovagok)
                {
                    if (!l.IsElo()) continue;
                    Console.WriteLine($"\n{l.Nev} lép ({l.GetType().Name}, életerő: {l.Eletero}):");
                    l.Kor(_tartomanyok);
                    if (!l.IsElo())
                        Console.WriteLine($"  *** {l.Nev} hősi halált halt! ***");
                }
                kor++;
            }

            Console.WriteLine();
            if (SikeresE())
                Console.WriteLine("A küldetés sikeres! Minden tartomány felszabadult.");
            else
                Console.WriteLine("A küldetés sikertelen. Nem sikerült minden tartományt felszabadítani.");

            var halottak = _lovagok.Where(l => !l.IsElo()).ToList();
            if (halottak.Any())
            {
                Console.WriteLine("\nHősi halottak:");
                foreach (var l in halottak)
                    Console.WriteLine($"  - {l.Nev}");
            }
        }

        public bool SikeresE() => _tartomanyok.All(t => !t.IsEllenseges());
    }


    internal class Program
    {
        static void Main(string[] args)
        {
            Console.Write("Adja meg a bemeneti fájl nevét: ");
            string? input = Console.ReadLine();

            if (string.IsNullOrWhiteSpace(input))
            {
                Console.WriteLine("Nem adott meg fájlnevet.");
                return;
            }

            string fajlNev = input;
            if (!File.Exists(fajlNev))
            {
                string kombinalt = Path.Combine(AppContext.BaseDirectory, fajlNev);
                if (File.Exists(kombinalt))
                    fajlNev = kombinalt;
                else
                {
                    Console.WriteLine($"A fájl nem található: {input}");
                    Console.WriteLine($"Keresett helyek:\n  {input}\n  {kombinalt}");
                    return;
                }
            }

            try
            {
                Jatek j = new Jatek(fajlNev);
                j.Futtat();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Hiba a futtatás során: {ex.Message}");
            }
        }
    }
}
