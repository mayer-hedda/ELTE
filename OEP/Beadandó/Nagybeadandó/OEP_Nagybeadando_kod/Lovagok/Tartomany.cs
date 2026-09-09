namespace Lovagok
{
    public interface ITartomanyAllapot
    {
        void FogadOvatost(Ovatos l);
        void FogadBatort(Bator l);
        void FogadVakmerot(Vakmero l);
        bool IsKiralyi();
        bool IsSemleges();
        bool IsEllenseges();
    }
    
    public class KiralyiAllapot : ITartomanyAllapot
    {
        public void FogadOvatost(Ovatos l) => l.Gyogyul();
        public void FogadBatort(Bator l) { }
        public void FogadVakmerot(Vakmero l) { }
        public bool IsKiralyi() => true;
        public bool IsSemleges() => false;
        public bool IsEllenseges() => false;
    }

    public class SemlegesAllapot : ITartomanyAllapot
    {
        private readonly Tartomany _tartomany;
        public SemlegesAllapot(Tartomany tartomany) => _tartomany = tartomany;

        public void FogadOvatost(Ovatos l) { }
        public void FogadBatort(Bator l) => _tartomany.Allapot = new KiralyiAllapot();
        public void FogadVakmerot(Vakmero l) => _tartomany.Allapot = new KiralyiAllapot();

        public bool IsKiralyi() => false;
        public bool IsSemleges() => true;
        public bool IsEllenseges() => false;
    }

    public class EllensegesAllapot : ITartomanyAllapot
    {
        private readonly Tartomany _tartomany;
        private int _ellenségEletero = 100;
        private static readonly Random _rnd = new Random();

        public EllensegesAllapot(Tartomany tartomany) => _tartomany = tartomany;

        public int EllenségEletero => _ellenségEletero;

        public void FogadOvatost(Ovatos l)
        {
            int n = _rnd.Next(1, 21);
            l.Harcol(n);
            _ellenségEletero -= n;
            Console.WriteLine($"  Csata! Lovag életerő: {l.Eletero}, Ellenség életerő: {_ellenségEletero}");
            if (_ellenségEletero <= 0)
                _tartomany.Allapot = new SemlegesAllapot(_tartomany);
        }

        public void FogadBatort(Bator l)
        {
            int n = _rnd.Next(1, 41);
            l.Harcol(n);
            _ellenségEletero -= n;
            Console.WriteLine($"  Csata! Lovag életerő: {l.Eletero}, Ellenség életerő: {_ellenségEletero}");
            if (_ellenségEletero <= 0)
            {
                _tartomany.Allapot = new SemlegesAllapot(_tartomany);
                return;
            }
            if (!l.IsSerult())
            {
                n = _rnd.Next(1, 41);
                l.Harcol(n);
                _ellenségEletero -= n;
                Console.WriteLine($"  Csata! Lovag életerő: {l.Eletero}, Ellenség életerő: {_ellenségEletero}");
                if (_ellenségEletero <= 0)
                    _tartomany.Allapot = new SemlegesAllapot(_tartomany);
            }
        }

        public void FogadVakmerot(Vakmero l)
        {
            while (true)
            {
                int n = _rnd.Next(1, 41);
                l.Harcol(n);
                _ellenségEletero -= n;
                Console.WriteLine($"  Csata! Lovag életerő: {l.Eletero}, Ellenség életerő: {_ellenségEletero}");
                if (_ellenségEletero <= 0)
                {
                    _tartomany.Allapot = new SemlegesAllapot(_tartomany);
                    break;
                }
                if (!l.IsElo())
                    break;
            }
        }

        public bool IsKiralyi() => false;
        public bool IsSemleges() => false;
        public bool IsEllenseges() => true;
    }

    

    public abstract class Tartomany
    {
        public string Nev { get; }
        public ITartomanyAllapot Allapot { get; set; }

        protected Tartomany(string nev, ITartomanyAllapot allapot)
        {
            Nev = nev;
            Allapot = allapot;
        }

        public void FogadOvatost(Ovatos l) => Allapot.FogadOvatost(l);
        public void FogadBatort(Bator l) => Allapot.FogadBatort(l);
        public void FogadVakmerot(Vakmero l) => Allapot.FogadVakmerot(l);

        public bool IsKiralyi() => Allapot.IsKiralyi();
        public bool IsSemleges() => Allapot.IsSemleges();
        public bool IsEllenseges() => Allapot.IsEllenseges();

        public override string ToString() =>
            IsKiralyi() ? $"{Nev} [KIRÁLYI]" :
            IsSemleges() ? $"{Nev} [SEMLEGES]" :
            $"{Nev} [ELLENSÉGES]";
    }


    public class Kiralyi : Tartomany
    {
        public Kiralyi(string nev) : base(nev, new KiralyiAllapot()) { }
    }

    public class Semleges : Tartomany
    {
        public Semleges(string nev) : base(nev, null!)
        {
            Allapot = new SemlegesAllapot(this);
        }
    }

    public class Ellenseges : Tartomany
    {
        public Ellenseges(string nev) : base(nev, null!)
        {
            Allapot = new EllensegesAllapot(this);
        }

        public int EllenségEletero =>
            Allapot is EllensegesAllapot ea ? ea.EllenségEletero : 0;
    }
}
