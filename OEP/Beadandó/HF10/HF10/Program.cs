using System;
using System.Collections.Generic;
using System.Linq;

namespace HF10
{
    public interface ISize
    {
        int Multi();
    }

    public class S : ISize
    {
        private static S? _instance;
        private S() { }
        public static S Instance() => _instance ??= new S();
        public int Multi() => 1;
    }

    public class M : ISize
    {
        private static M? _instance;
        private M() { }
        public static M Instance() => _instance ??= new M();
        public int Multi() => 2;
    }

    public class L : ISize
    {
        private static L? _instance;
        private L() { }
        public static L Instance() => _instance ??= new L();
        public int Multi() => 3;
    }

    public class XL : ISize
    {
        private static XL? _instance;
        private XL() { }
        public static XL Instance() => _instance ??= new XL();
        public int Multi() => 4;
    }

    public abstract class Gift
    {
        protected ISize _size;
        public TargetShot? Target { get; set; } = null;
        protected Gift(ISize size) => _size = size;
        public abstract int Points();
        public int Value() => Points() * _size.Multi();
    }

    public class Ball : Gift
    {
        public Ball(ISize size) : base(size) { }
        public override int Points() => 1;
    }

    public class Figure : Gift
    {
        public Figure(ISize size) : base(size) { }
        public override int Points() => 2;
    }

    public class Plush : Gift
    {
        public Plush(ISize size) : base(size) { }
        public override int Points() => 3;
    }

    public class TargetShot
    {
        private string _location;
        private readonly List<Gift> _gifts = new();
        public IReadOnlyList<Gift> Gifts => _gifts;
        public TargetShot(string h) => _location = h;
        public void Shows(Gift a)
        {
            if (a.Target != null) throw new Exception();
            a.Target = this;
            _gifts.Add(a);
        }
        public void RemoveGift(Gift a) => _gifts.Remove(a);
    }

    public class Guest
    {
        public string Name { get; }
        private readonly List<Gift> _prizes = new();
        public Guest(string n) => Name = n;
        public void Wins(Gift a)
        {
            if (a.Target == null || !a.Target.Gifts.Contains(a)) throw new Exception();
            a.Target.RemoveGift(a);
            _prizes.Add(a);
        }
        public int Result(TargetShot c)
        {
            return _prizes.Where(e => e.Target == c).Sum(e => e.Value());
        }
    }

    public class AmPark
    {
        private List<TargetShot> _targets;
        private List<Guest> _guests = new();
        public AmPark(List<TargetShot> c)
        {
            if (c.Count < 2) throw new Exception();
            _targets = c;
        }
        public void Receives(Guest v)
        {
            if (_guests.Contains(v)) throw new Exception();
            _guests.Add(v);
        }
        public string Best(TargetShot c)
        {
            if (!_guests.Any()) throw new Exception();
            Guest? bestElem = null;
            int maxVal = -1;
            foreach (var g in _guests)
            {
                int res = g.Result(c);
                if (res > maxVal)
                {
                    maxVal = res;
                    bestElem = g;
                }
            }
            if (bestElem == null || maxVal <= 0) throw new Exception();
            return bestElem.Name;
        }
    }

    internal class Program
    {
        static void Main(string[] args)
        {
            string choice = Console.ReadLine();
            switch (choice)
            {
                case "Sizes":
                    TestSizes();
                    break;
                case "Gifts":
                    TestGifts();
                    break;
                case "TargetShot":
                    TestTarget();
                    break;
                case "Guest":
                    TestGuest();
                    break;
                case "AmPark":
                    TestAmPark();
                    break;
            }
        }

        public static void TestSizes()
        {
            S testSOne = S.Instance();
            S testSTwo = S.Instance();
            Console.WriteLine(testSOne == testSTwo);
            M testMOne = M.Instance();
            M testMTwo = M.Instance();
            Console.WriteLine(testMOne == testMTwo);
            L testLOne = L.Instance();
            L testLTwo = L.Instance();
            Console.WriteLine(testLOne == testLTwo);
            XL testXLOne = XL.Instance();
            XL testXLTwo = XL.Instance();
            Console.WriteLine(testXLOne == testXLTwo);
            Console.WriteLine(testSOne.Multi());
            Console.WriteLine(testMOne.Multi());
            Console.WriteLine(testLOne.Multi());
            Console.WriteLine(testXLOne.Multi());
        }

        public static void TestGifts()
        {
            string input = Console.ReadLine();
            ISize testSize = input switch { "S" => S.Instance(), "M" => M.Instance(), "L" => L.Instance(), "XL" => XL.Instance(), _ => null };
            input = Console.ReadLine();
            Gift tested = input switch { "Ball" => new Ball(testSize), "Figure" => new Figure(testSize), "Plush" => new Plush(testSize), _ => null };
            Console.WriteLine(tested?.Value());
        }

        public static void TestTarget()
        {
            TargetShot tested = new TargetShot("Tatooine");
            Gift testGift = new Ball(L.Instance());
            Console.WriteLine(tested.Gifts.Count);
            try { tested.Shows(testGift); } catch { Console.WriteLine("Exception - Gift targetshot is not null"); }
            Console.WriteLine(tested.Gifts.Count);
            try { tested.Shows(testGift); } catch { Console.WriteLine("Exception - Gift targetshot is not null"); }
            Console.WriteLine(tested.Gifts.Count);
        }

        public static void TestGuest()
        {
            string input = Console.ReadLine();
            Guest testedOne = new Guest(input);
            Gift testGift = new Ball(L.Instance());
            TargetShot testTS = new TargetShot("random");
            testTS.Shows(testGift);
            Console.WriteLine(testedOne.Name);
            try { testedOne.Wins(testGift); } catch { Console.WriteLine("Exception - Gift not at targetshot"); }
            try { testedOne.Wins(testGift); } catch { Console.WriteLine("Exception - Gift not at targetshot"); }
            
            string name2 = Console.ReadLine();
            Guest testedTwo = new Guest(name2);
            int numTShots = int.Parse(Console.ReadLine());
            int numGifts = int.Parse(Console.ReadLine());
            List<TargetShot> targetShots = new List<TargetShot>();
            for (int i = 0; i < numTShots; i++) targetShots.Add(new TargetShot(Console.ReadLine()));
            
            for (int i = 0; i < numGifts; i++)
            {
                string s = Console.ReadLine();
                ISize size = s switch { "S" => S.Instance(), "M" => M.Instance(), "L" => L.Instance(), "XL" => XL.Instance(), _ => null };
                string type = Console.ReadLine();
                Gift g = type switch { "Ball" => new Ball(size), "Figure" => new Figure(size), "Plush" => new Plush(size), _ => null };
                int tsIdx = int.Parse(Console.ReadLine());
                targetShots[tsIdx].Shows(g);
                testedTwo.Wins(g);
            }
            Console.WriteLine(testedTwo.Name);
            int targetShotIdx = int.Parse(Console.ReadLine());
            Console.WriteLine(testedTwo.Result(targetShots[targetShotIdx]));
        }

        public static void TestAmPark()
        {
            int numGuest = int.Parse(Console.ReadLine());
            int numTShots = int.Parse(Console.ReadLine());
            int numGifts = int.Parse(Console.ReadLine());
            List<TargetShot> targetShots = new List<TargetShot>();
            for (int i = 0; i < numTShots; i++) targetShots.Add(new TargetShot(Console.ReadLine()));
            
            AmPark tested = null;
            bool noLength = false;
            try { tested = new AmPark(targetShots); }
            catch { noLength = true; Console.WriteLine("Exception - targetShot list too short"); }

            for (int i = 0; i < numGuest; i++)
            {
                Guest testGuest = new Guest(Console.ReadLine());
                for (int j = 0; j < numGifts; j++)
                {
                    int targetChoice = int.Parse(Console.ReadLine());
                    string s = Console.ReadLine();
                    ISize size = s switch { "S" => S.Instance(), "M" => M.Instance(), "L" => L.Instance(), "XL" => XL.Instance(), _ => null };
                    string type = Console.ReadLine();
                    Gift g = type switch { "Ball" => new Ball(size), "Figure" => new Figure(size), "Plush" => new Plush(size), _ => null };
                    targetShots[targetChoice].Shows(g);
                    testGuest.Wins(g);
                }
                tested?.Receives(testGuest);
            }
            if (!noLength && tested != null)
            {
                int finalTS = int.Parse(Console.ReadLine());
                Console.WriteLine(tested.Best(targetShots[finalTS]));
            }
        }
    }
}