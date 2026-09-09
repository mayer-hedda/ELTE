namespace Lovagok
{
    public abstract class Lovag
    {
        public string Nev { get; }
        public int Eletero { get; protected set; } = 100;
        protected int GyogyulasMax { get; set; }
        protected int SebzesMax { get; set; }
        protected int SerultHatar { get; set; }
        protected int TartomanyIndex { get; set; } = 0;

        private static readonly Random _rnd = new Random();

        protected Lovag(string nev) => Nev = nev;

        public bool IsElo() => Eletero > 0;

        public abstract bool IsSerult();

        public void Harcol(int n) => Eletero -= n;

        public void Visszavonul(List<Tartomany> tartomanyok)
        {
            while (!tartomanyok[TartomanyIndex].IsKiralyi())
                TartomanyIndex--;
        }

        public void Gyogyul()
        {
            int r = _rnd.Next(1, GyogyulasMax + 1);
            Eletero = Math.Min(100, Eletero + r);
        }

        public void Kor(List<Tartomany> tartomanyok)
        {
            if (TartomanyIndex >= tartomanyok.Count - 1 && !tartomanyok[TartomanyIndex].IsEllenseges())
            {
                Console.WriteLine($"  {Nev} elérte az utolsó tartományt, vár.");
                return;
            }

            if (IsSerult())
            {
                Console.WriteLine($"  {Nev} sérült, visszavonul...");
                Visszavonul(tartomanyok);
                Console.WriteLine($"  {Nev} visszavonult: {tartomanyok[TartomanyIndex].Nev}, életerő: {Eletero}");
                Gyogyul();
                Console.WriteLine($"  {Nev} gyógyult, életerő: {Eletero}");
            }
            else
            {
                TovabbLep(tartomanyok);
            }
        }

        protected abstract void TovabbLep(List<Tartomany> tartomanyok);

        public override string ToString() =>
            $"{Nev} ({GetType().Name}), életerő: {Eletero}, tartomány: {TartomanyIndex}";
    }

    public class Ovatos : Lovag
    {
        public Ovatos(string nev) : base(nev)
        {
            GyogyulasMax = 20;
            SebzesMax = 20;
            SerultHatar = 90;
        }

        public override bool IsSerult() => Eletero <= 90;

        protected override void TovabbLep(List<Tartomany> tartomanyok)
        {
            if (TartomanyIndex >= tartomanyok.Count - 1) return;
            TartomanyIndex++;
            Console.WriteLine($"  {Nev} belép: {tartomanyok[TartomanyIndex]}, életerő: {Eletero}");
            tartomanyok[TartomanyIndex].FogadOvatost(this);
        }
    }

    public class Bator : Lovag
    {
        public Bator(string nev) : base(nev)
        {
            GyogyulasMax = 30;
            SebzesMax = 40;
            SerultHatar = 40;
        }

        public override bool IsSerult() => Eletero <= 40;

        protected override void TovabbLep(List<Tartomany> tartomanyok)
        {
            if (tartomanyok[TartomanyIndex].IsEllenseges())
            {
                Console.WriteLine($"  {Nev} marad harcolni: {tartomanyok[TartomanyIndex]}, életerő: {Eletero}");
                tartomanyok[TartomanyIndex].FogadBatort(this);
            }
            else
            {
                if (TartomanyIndex >= tartomanyok.Count - 1) return;
                TartomanyIndex++;
                Console.WriteLine($"  {Nev} belép: {tartomanyok[TartomanyIndex]}, életerő: {Eletero}");
                tartomanyok[TartomanyIndex].FogadBatort(this);
            }
        }
    }

    public class Vakmero : Lovag
    {
        public Vakmero(string nev) : base(nev)
        {
            GyogyulasMax = 40;
            SebzesMax = 40;
            SerultHatar = 0;
        }

        public override bool IsSerult() => false;

        protected override void TovabbLep(List<Tartomany> tartomanyok)
        {
            if (TartomanyIndex >= tartomanyok.Count - 1) return;
            TartomanyIndex++;
            Console.WriteLine($"  {Nev} belép: {tartomanyok[TartomanyIndex]}, életerő: {Eletero}");
            tartomanyok[TartomanyIndex].FogadVakmerot(this);
        }
    }
}
