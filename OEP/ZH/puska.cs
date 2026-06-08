using System;
using System.Collections.Generic;
using System.Linq; // KÖTELEZŐ: A LINQ (Sum, Where, Any, FirstOrDefault) miatt!

namespace OepKomplexZhSablon
{
    // =========================================================================
    // 1. STRATEGY / STATE / SINGLETON MINTA (Absztrakt interfész/ős és egyke osztályok)
    // =========================================================================
    // ZH-kon a fix tulajdonságokat (pl. Méretek: S, M, L, XL vagy Állapotok) így kódoljuk le.
    
    public interface ISize
    {
        int Multi(); // Minden méretnek kötelező lesz ezt megvalósítania
    }

    // PÉLDA: SINGLETON (EGYKE) OSZTÁLY SZINTAKTIKA (S-es méret)
    public class S : ISize
    {
        // A statikus privát mező, ami az egyetlen létező példányt tárolja a memóriában
        private static S? _instance;

        // PRIVÁT KONSTRUKTOR: Megakadályozza, hogy a főprogramban bárki leírhassa: new S()
        private S() { }

        // Globális elérési pont. Ha még nincs példány, létrehozza (??=), ha van, azt adja vissza
        public static S Instance() => _instance ??= new S();

        // Az interfész metódus konkrét megvalósítása
        public int Multi() => 1;
    }

    // Másik Singleton osztály (M-es méret)
    public class M : ISize
    {
        private static M? _instance;
        private M() { }
        public static M Instance() => _instance ??= new M();
        public int Multi() => 2;
    }

    // Harmadik Singleton osztály (L-es méret)
    public class L : ISize
    {
        private static L? _instance;
        private L() { }
        public static L Instance() => _instance ??= new L();
        public int Multi() => 3;
    }

    // Negyedik Singleton osztály (XL-es méret)
    public class XL : ISize
    {
        private static XL? _instance;
        private XL() { }
        public static XL Instance() => _instance ??= new XL();
        public int Multi() => 4;
    }


    // =========================================================================
    // 2. ABSZTRAKT ŐSOSZTÁLY, ÖRÖKLŐDÉS ÉS KÉTIRÁNYÚ KAPCSOLATOK (UML: Gift)
    // =========================================================================
    
    public abstract class Gift
    {
        // ADATTAGOK (Attribútumok)
        // 'protected': a leszármazott (gyerek) osztályok is látják, de kívülről nem elérhető
        protected ISize _size; 

        // KÉTIRÁNYÚ KAPCSOLAT (UML: TargetShot 0..1-hez húzott nyíl, Target felirattal)
        // {getter, setter} -> tulajdonságként (Property) valósítjuk meg.
        // A '?' jelzi, hogy lehet null is (ha még nincs céllövöldéhez rendelve)
        public TargetShot? Target { get; set; } = null;

        // KONSTRUKTOR: Az ősosztály inicializálása
        protected Gift(ISize size)
        {
            _size = size;
        }

        // ABSZTRAKT METÓDUS: Nincs törzse! A gyerekeknek KÖTELEZŐ lesz felülírni (override).
        public abstract int Points();

        // VIRTUÁLIS VAGY SIMA METÓDUS: Van törzse, minden gyerek osztály örökli a működést.
        // Meghívja a gyerek egyedi pontját, és megszorozza a singleton méret szorzójával.
        public int Value()
        {
            return Points() * _size.Multi();
        }
    }


    // =========================================================================
    // 3. LESZÁRMAZOTT (GYEREK) OSZTÁLYOK ÉS AZ OVERRIDE (Ball, Figure, Plush)
    // =========================================================================
    
    // A ':' jelöli az öröklődést C#-ban (Ball osztály származik a Gift-ből)
    public class Ball : Gift
    {
        // ŐS KONSTRUKTOR HÍVÁSA: A 'base(size)' átadja a paramétert a Gift konstruktorának
        public Ball(ISize size) : base(size) { }

        // OVERRIDE: Felülírjuk az ősosztály absztrakt metódusát a konkrét értékkel
        public override int Points() => 1;
    }

    public class Figure : Gift
    {
        public Figure(ISize size) : base(size) { }
        public override int Points() => 2;
    }

    public class Plush : Gift
    {
        public Figure(ISize size) : base(size) { }
        public override int Points() => 3;
    }


    // =========================================================================
    // 4. AGGREGÁCIÓ, LISTÁK ÉS KIVÉTELKEZELÉS (UML: TargetShot)
    // =========================================================================
    
    public class TargetShot
    {
        // Privát belső változó a helyszínnek
        private string _location;

        // KOMPOZÍCIÓ / AGGREGÁCIÓ (UML: Gift * nyíl): Egy céllövöldében sok ajándék lehet.
        // 'readonly': maga a lista referenciája nem változhat, de elemet adhatunk hozzá.
        private readonly List<Gift> _gifts = new List<Gift>();

        // ENKAPSZULÁCIÓ (Adatrejtés): Kívülről senki ne tudja direktben törölni a listát!
        // Az IReadOnlyList-en keresztül csak olvasni lehet kívülről (pl. foreach-elni)
        public IReadOnlyList<Gift> Gifts => _gifts;

        // Konstruktor
        public TargetShot(string location)
        {
            _location = location;
        }

        // METÓDUS FELTÉTELEKKEL ÉS EXCEPTION-NEL (UML cetli: Shows(a: Gift))
        public void Shows(Gift a)
        {
            // UML cetli: "if a.Target != null then error"
            // Ha az ajándéknak már van céllövöldéje, hibát dobunk (kivételkezelés)
            if (a.Target != null)
            {
                throw new Exception("Hiba: Ez az ajándék már egy másik céllövöldében van!");
            }

            // Kétirányú kapcsolat beállítása:
            a.Target = this;   // Az ajándéknak megmondjuk, hogy én vagyok a céllövöldéje
            _gifts.Add(a);     // Magamhoz (a listába) pedig felveszem az ajándékot
        }

        // Segédfüggvény az ajándék eltávolításához (ha megnyerik)
        public void RemoveGift(Gift a)
        {
            _gifts.Remove(a);
        }
    }


    // =========================================================================
    // 5. ÖSSZEGZÉS TÉTELE ÉS LINQ GYAKORLAT (UML: Guest)
    // =========================================================================
    
    public class Guest
    {
        // Publikus, csak olvasható tulajdonság (UML: name : string)
        public string Name { get; }
        
        // A vendégnél lévő nyert ajándékok listája {unique}
        private readonly List<Gift> _prizes = new List<Gift>();

        public Guest(string name)
        {
            Name = name;
        }

        // UML cetli: Wins(a: Gift)
        public void Wins(Gift a)
        {
            // UML feltétel: "if a.Target = null or a not in a.Target.Gifts then error"
            if (a.Target == null || !a.Target.Gifts.Contains(a))
            {
                throw new Exception("Hiba: Ez az ajándék nem nyerhető meg ebből a céllövöldéből!");
            }

            a.Target.RemoveGift(a); // Kivesszük a céllövöldéből
            _prizes.Add(a);         // Berakjuk a vendég nyereményei közé
        }

        // ÖSSZEGZÉS TÉTELE (UML cetli: Result(c: TargetShot) : int)
        // Feladat: Összegezni a vendég azon ajándékainak értékét, amik a 'c' céllövöldéből származnak.
        public int Result(TargetShot c)
        {
            // HAGYOMÁNYOS CIKLUS MEGOLDÁS (Puskának, ha a tanár nem szereti a LINQ-t):
            /*
            int sum = 0;
            foreach (Gift e in _prizes)
            {
                if (e.Target == c) // UML: e.Target = c
                {
                    sum += e.Value(); // UML: e.Value()
                }
            }
            return sum;
            */

            // SZEBB, PROGRAMOZÓS MEGOLDÁS LINQ-VAL:
            // "Válaszd ki azokat az e elemeket a prizes-ből, ahol e.Target megegyezik c-vel, és add össze a Value() értéküket"
            return _prizes.Where(e => e.Target == c).Sum(e => e.Value());
        }
    }


    // =========================================================================
    // 6. MAXIMUMKERESÉS TÉTELE (UML: AmPark)
    // =========================================================================
    
    public class AmPark
    {
        private List<TargetShot> _targets;
        private List<Guest> _guests = new List<Guest>();

        // Konstruktor ellenőrzéssel
        public AmPark(List<TargetShot> c)
        {
            // UML cetli: "if |c| < 2 then error" (|c| a lista hosszát jelenti)
            if (c.Count < 2)
            {
                throw new Exception("Hiba: A vidámparkban legalább 2 céllövöldének lennie kell!");
            }
            _targets = c;
        }

        public void Receives(Guest v)
        {
            // UML cetli: "if v in guests then error"
            if (_guests.Contains(v))
            {
                throw new Exception("Hiba: Ez a vendég már bent van a parkban!");
            }
            _guests.Add(v);
        }

        // MAXIMUMKERESÉS TÉTELE (UML cetli: Best(c: TargetShot) : string)
        // Feladat: Megkeresni azt a vendéget, aki a legtöbb pontot (Result) érte el a 'c' céllövöldében.
        public string Best(TargetShot c)
        {
            // UML cetli feltétel: "if |guests| = 0 then error"
            if (_guests.Count == 0) // vagy: if (!_guests.Any())
            {
                throw new Exception("Hiba: Nincsenek vendégek a parkban!");
            }

            // Klasszikus maximumkeresés tétel felépítése:
            Guest? bestElem = null; // Ide mentjük a legjobb embert
            int maxVal = -1;        // Ide mentjük a legmagasabb pontszámot (kezdőérték nagyon kicsi)

            foreach (Guest g in _guests)
            {
                int currentResult = g.Result(c); // Aktuális elem értéke

                // Feltétel vizsgálat (UML szerint: ha nagyobb, mint az eddigi max)
                if (currentResult > maxVal)
                {
                    maxVal = currentResult;
                    bestElem = g;
                }
            }

            // UML cetli feltétel: "if max = 0 then error"
            // Ha a legjobb eredmény is 0 pont, vagy nem találtunk senkit, hibát dobunk
            if (bestElem == null || maxVal <= 0)
            {
                throw new Exception("Hiba: Senki nem ért el pontot ezen a céllövöldén!");
            }

            return bestElem.Name; // Visszaadjuk a nyertes nevét (string)
        }
    }


    // =========================================================================
    // 7. A FŐPROGRAM (Main) - BEMENET BEOLVASÁS ÉS TESZTELÉS SZINTAKTIKA
    // =========================================================================
    // A ZH-kon a konzolos beolvasást pontosan a megadott input formátum szerint kell megírni.
    
    class Program
    {
        static void Main(string[] args)
        {
            // --- BEMENETI ADATOK BEOLVASÁSA (Konzolról) ---
            
            // 1. Számok beolvasása (pl. hány céllövölde, hány vendég van)
            int numTShots = int.Parse(Console.ReadLine() ?? "0");
            int numGuest = int.Parse(Console.ReadLine() ?? "0");
            int numGifts = int.Parse(Console.ReadLine() ?? "0");

            // 2. Céllövöldék listájának feltöltése ciklussal
            List<TargetShot> targetShots = new List<TargetShot>();
            for (int i = 0; i < numTShots; i++)
            {
                string location = Console.ReadLine() ?? "";
                targetShots.Add(new TargetShot(location));
            }

            // 3. Kivételkezelés (Try-Catch blokk) objektum létrehozásakor
            AmPark? testedPark = null;
            bool failedInit = false;
            try
            {
                testedPark = new AmPark(targetShots);
            }
            catch (Exception ex)
            {
                failedInit = true;
                Console.WriteLine($"Exception - {ex.Message}");
            }

            // 4. Vendégek és ajándékok beolvasása (Egymásba ágyazott ciklusok)
            for (int i = 0; i < numGuest; i++)
            {
                string guestName = Console.ReadLine() ?? "";
                Guest testGuest = new Guest(guestName);

                for (int j = 0; j < numGifts; j++)
                {
                    int targetChoice = int.Parse(Console.ReadLine() ?? "0"); // Melyik céllövöldéhez tartozik
                    
                    // Singleton minta lekérése bemenet alapján (C# Switch kifejezés!)
                    string sizeStr = Console.ReadLine() ?? "";
                    ISize size = sizeStr switch
                    {
                        "S" => S.Instance(),
                        "M" => M.Instance(),
                        "L" => L.Instance(),
                        "XL" => XL.Instance(),
                        _ => throw new Exception("Ismeretlen méret!")
                    };

                    // Öröklődés példányosítása bemenet alapján (Polimorfizmus)
                    string typeStr = Console.ReadLine() ?? "";
                    Gift g = typeStr switch
                    {
                        "Ball" => new Ball(size),
                        "Figure" => new Figure(size),
                        "Plush" => new Plush(size),
                        _ => throw new Exception("Ismeretlen ajándék típus!")
                    };

                    // Logika futtatása
                    targetShots[targetChoice].Shows(g);
                    testGuest.Wins(g);
                }

                // A '?' operátor biztosítja, hogy csak akkor fut le a függvény, ha a 'testedPark' nem null
                testedPark?.Receives(testGuest);
            }

            // --- KIÉRTÉKELÉS ÉS TESZTELÉS ---
            if (!failedInit && testedPark != null)
            {
                try
                {
                    int finalTargetIndex = int.Parse(Console.ReadLine() ?? "0");
                    
                    // Meghívjuk a maximumkeresést a kiválasztott céllövöldére
                    string winner = testedPark.Best(targetShots[finalTargetIndex]);
                    Console.WriteLine($"A győztes ezen a helyszínen: {winner}");
                }
                catch (Exception ex)
                {
                    // Ha a Best() hibát dobott (pl max = 0 vagy nincs vendég), itt kapjuk el
                    Console.WriteLine($"Hiba a kiértékelés során: {ex.Message}");
                }
            }
        }
    }
}



// Gyors emlékeztető a ZH-ra (Hogyan használd ezt a fájlt):
// Ha cetlit látsz if ... then error szöveggel: Azonnal írd a kódba: if (feltétel) { throw new Exception("..."); }.
// Ha egyke (Singleton) osztály kell: Másold le az S osztály szerkezetét (privát konstruktor, statikus _instance, és az Instance() metódus).
// Ha összegzést vagy keresést látsz a cetlin: Használd a Guest.Result (összegzés) vagy az AmPark.Best (maximumkeresés) ciklusmintáját. Keresésnél a maxVal kezdőértéke mindig kisebb legyen, mint a legkisebb lehetséges érték (pl. -1).