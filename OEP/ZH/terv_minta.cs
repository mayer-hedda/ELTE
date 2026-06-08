using System;

// =========================================================================
// 1. SINGLETON (EGYKE) TERVEZÉSI MINTA
// =========================================================================
// Mikor kell? Ha egy osztályból pontosan egyetlen példány létezhet a rendszerben.
namespace SingletonPattern
{
    public class GlobálisRendszerkezelő
    {
        // A statikus magánváltozó, ami az egyetlen példányt tárolja.
        private static GlobálisRendszerkezelő? _instance;

        // PRIVÁT KONSTRUKTOR: Kívülről senki nem hívhatja meg a 'new' kulcsszót!
        private GlobálisRendszerkezelő() { }

        // Globális elérési pont: Ha még nincs példány, létrehozza, ha van, visszaadja.
        public static GlobálisRendszerkezelő Instance()
        {
            // A '??=' operátor lerövidíti az "if (_instance == null)" vizsgálatot
            return _instance ??= new GlobálisRendszerkezelő();
        }

        // Bármilyen egyedi üzleti logika, amit az egyke osztály végez
        public void Logolás(string üzenet)
        {
            Console.WriteLine($"[LOG]: {üzenet}");
        }
    }
}

// =========================================================================
// 2. STRATEGY (STRATÉGIA) TERVEZÉSI MINTA
// =========================================================================
// Mikor kell? Ha egy viselkedést többféle algoritmussal is meg lehet oldani, 
// és ezt futási időben akarjuk cserélgetni (pl. szorzók, adózási formák).
namespace StrategyPattern
{
    // A közös interfész (vagy absztrakt ősosztály), amit minden stratégiának meg kell valósítania
    public interface IFizetésiStratégia
    {
        void Fizet(int összeg);
    }

    // "A" konkrét stratégia
    public class KészpénzFizetés : IFizetésiStratégia
    {
        public void Fizet(int összeg) => Console.WriteLine($"{összeg} Ft kifizetve készpénzzel.");
    }

    // "B" konkrét stratégia
    public class KártyásFizetés : IFizetésiStratégia
    {
        public void Fizet(int összeg) => Console.WriteLine($"{összeg} Ft kifizetve bankkártyával.");
    }

    // A környezet (Context) osztály, ami HASZNÁLJA a választott stratégiát
    public class Kosár
    {
        // Polimorfizmus: az interfész típusú változó bármelyik fenti osztályt be tudja fogadni
        private IFizetésiStratégia _stratégia;

        // Konstruktorban kötelező megadni egy alapértelmezett stratégiát
        public Kosár(IFizetésiStratégia kezdőStratégia)
        {
            _stratégia = kezdőStratégia;
        }

        // FUTÁSI IDŐBEN CSERÉLHETŐ: Egy setter metódussal bármikor átváltható a stratégia
        public void StratégiaVáltás(IFizetésiStratégia újStratégia)
        {
            _stratégia = újStratégia;
        }

        // A hívást egyszerűen továbbdelegáljuk az éppen aktív stratégiának
        public void FizetésVégrehajtása(int végösszeg)
        {
            _stratégia.Fizet(végösszeg);
        }
    }
}

// =========================================================================
// 3. STATE (ÁLLAPOT) TERVEZÉSI MINTA
// =========================================================================
// Mikor kell? Ha az objektum viselkedése a belső állapotától függ, és az 
// állapotok maguktól, a metódusok hatására váltják egymást.
namespace StatePattern
{
    // Először deklaráljuk a fő osztályt (Context), hogy az állapotok hivatkozhassanak rá
    public class Csapda;

    // Az állapotok közös interfésze
    public interface ICsapdaÁllapot
    {
        void Aktiválódik(Csapda kontextus);
    }

    // 1. konkrét állapot: Élesített állapot
    public class Élesítve : ICsapdaÁllapot
    {
        public void Aktiválódik(Csapda kontextus)
        {
            Console.WriteLine("BUMM! A csapda működésbe lépett.");
            // ÁLLAPOTÁTMENET: A csapda átvált a következő állapotára
            kontextus.ÁllapotBeállítás(new Elsütve());
        }
    }

    // 2. konkrét állapot: Elsütött állapot
    public class Elsütve : ICsapdaÁllapot
    {
        public void Aktiválódik(Csapda kontextus)
        {
            Console.WriteLine("A csapda már el van sütve, nem történik semmi.");
        }
    }

    // A fő objektum, aminek változik az állapota
    public class Csapda
    {
        private ICsapdaÁllapot _aktuálisÁllapot;

        public Csapda()
        {
            _aktuálisÁllapot = new Élesítve(); // Kezdő állapot
        }

        // Ezzel a belső metódussal engedjük meg az állapot-osztályoknak az átmenetet
        public void ÁllapotBeállítás(ICsapdaÁllapot újÁllapot)
        {
            _aktuálisÁllapot = újÁllapot;
        }

        // Kívülről ezt hívjuk, de a működés teljesen a belső állapottól függ
        public void Rálépnek()
        {
            _aktuálisÁllapot.Aktiválódik(this); // Átadja saját magát (this) az állapotnak
        }
    }
}

// =========================================================================
// 4. TEMPLATE METHOD (SABLON METÓDUS) TERVEZÉSI MINTA
// =========================================================================
// Mikor kell? Ha egy algoritmus csontváza/lépései fixek, de az egyes rész-lépések 
// konkrét megvalósítását a leszármazott (gyerek) osztályokra akarjuk bízni.
namespace TemplateMethodPattern
{
    public abstract class KávéKészítőSablon
    {
        // EZ A SABLON METÓDUS: A lépések sorrendje szigorúan fix.
        // Nem virtuális, a gyerekek nem írhatják felül a teljes folyamatot!
        public void KávéFőzés()
        {
            VízForralás();          // 1. lépés: fix
            ŐrlésÉsForrázás();      // 2. lépés: fix
            KávéKitöltés();         // 3. lépés: fix
            Ízesítés();             // 4. lépés: ABSZTRAKT (a gyerek dönti el)
        }

        private void VízForralás() => Console.WriteLine("Víz forralása 95 fokra...");
        private void ŐrlésÉsForrázás() => Console.WriteLine("Kávé lefőzése...");
        private void KávéKitöltés() => Console.WriteLine("Kávé csészébe töltése...");

        // ABSZTRAKT LÉPÉS: Nincs törzse, a gyerek osztályok kötelesek megírni a saját verziójukat.
        protected abstract void Ízesítés();
    }

    // Konkrét megvalósítás "A"
    public class FeketeKávé : KávéKészítőSablon
    {
        protected override void Ízesítés()
        {
            Console.WriteLine("Nem adunk hozzá semmit, tisztán tálaljuk.");
        }
    }

    // Konkrét megvalósítás "B"
    public class Cappuccino : KávéKészítőSablon
    {
        protected override void Ízesítés()
        {
            Console.WriteLine("Meleg tejhab és kakaópor hozzáadása.");
        }
    }
}