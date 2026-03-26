using System.Collections;
using System.Collections.Generic;
using System.Xml.Linq;

namespace HF04
{
    public struct Item
    {
        public int pr;
        public string data;

        public Item()
        {
            pr = 0;
            data = "";
        }
    }

    public class PrQueue
    {
        private List<Item> seq = new List<Item>();

        public void SetEmpty()
        {
            seq.Clear();
        }

        public bool IsEmpty()
        {
            return seq.Count == 0;
        }

        public void Add(Item e)
        {
            seq.Add(e);
        }

        public Item GetMax()
        {
            if (IsEmpty()) throw new InvalidOperationException("Üres sor!");
            
            int ind = MaxIndex();
            
            return seq[ind];
        }

        public Item RemMax()
        {
            if (IsEmpty()) throw new InvalidOperationException("Üres sor!");
            
            Item e = seq[MaxIndex()];
            
            seq.RemoveAt(MaxIndex());
            
            return e;
        }

        private int MaxIndex()
        {
            if (IsEmpty()) throw new InvalidOperationException("Üres sor!");

            int ind = 0;
            int maxPr = seq[0].pr;

            for (int i = 1; i < seq.Count; i++)
            {
                if (seq[i].pr > maxPr)
                {
                    maxPr = seq[i].pr;
                    ind = i;
                }
            }
            return ind;
        }
    }

    internal class Program
    {
        static void Main(string[] args)
        {
            string[]? input;
            input = Console.ReadLine()?.Split();
            PrQueue testQ = new PrQueue();
            switch (input[0])
            {
                case "Hozzáad":
                    Console.WriteLine("A sor üres:");
                    Console.WriteLine(testQ.IsEmpty());
                    Console.WriteLine("Prioritás Adat bemenet:");
                    input = Console.ReadLine()?.Split();
                    int pr1 = int.Parse(input[0]);
                    Item toAdd1;
                    toAdd1.pr = pr1;
                    toAdd1.data = input[1];
                    testQ.Add(toAdd1);
                    Console.WriteLine("A sor nem üres:");
                    Console.WriteLine(!testQ.IsEmpty());
                    break;
                case "Üres":
                    Console.WriteLine("A sor üres:");
                    Console.WriteLine(testQ.IsEmpty());
                    try
                    {
                        testQ.GetMax();
                    }
                    catch
                    {
                        Console.WriteLine("Hiba - GetMax");
                    }
                    try
                    {
                        testQ.RemMax();
                    }
                    catch
                    {
                        Console.WriteLine("Hiba - RemMax");
                    }
                    break;
                case "Kiürítés":
                    Console.WriteLine("A sor üres:");
                    Console.WriteLine(testQ.IsEmpty());
                    Console.WriteLine("Prioritás Adat bemenet:");
                    input = Console.ReadLine()?.Split();
                    int pr2 = int.Parse(input[0]);
                    Item toAdd2;
                    toAdd2.pr = pr2;
                    toAdd2.data = input[1];
                    testQ.Add(toAdd2);
                    Console.WriteLine("A sor nem üres:");
                    Console.WriteLine(!testQ.IsEmpty());
                    Console.WriteLine("Kiürítés...");
                    testQ.SetEmpty();
                    Console.WriteLine("Újra hozzáadás...");
                    testQ.Add(toAdd2);
                    Item e = testQ.RemMax();
                    Console.WriteLine(e.data);
                    Console.WriteLine("A sor üres:");
                    Console.WriteLine(testQ.IsEmpty());
                    try
                    {
                        testQ.GetMax();
                    }
                    catch
                    {
                        Console.WriteLine("Hiba - GetMax");
                    }
                    try
                    {
                        testQ.RemMax();
                    }
                    catch
                    {
                        Console.WriteLine("Hiba - RemMax");
                    }
                    break;
                case "Maximumkiválasztás":
                    Console.WriteLine("Elemek hozzáadása...");
                    Console.WriteLine("Prioritás Adat bemenet:");
                    input = Console.ReadLine()?.Split();
                    int pr3 = int.Parse(input[0]);
                    Item toAdd3;
                    toAdd3.pr = pr3;
                    toAdd3.data = input[1];
                    Console.WriteLine("Prioritás Adat bemenet:");
                    input = Console.ReadLine()?.Split();
                    pr3 = int.Parse(input[0]);
                    Item toAdd4;
                    toAdd4.pr = pr3;
                    toAdd4.data = input[1];
                    Console.WriteLine("Prioritás Adat bemenet:");
                    input = Console.ReadLine()?.Split();
                    pr3 = int.Parse(input[0]);
                    Item toAdd5;
                    toAdd5.pr = pr3;
                    toAdd5.data = input[1];
                    testQ.Add(toAdd3);
                    testQ.Add(toAdd4);
                    testQ.Add(toAdd5);
                    Console.WriteLine("Max lekérdezése:");
                    Item toGet = testQ.GetMax();
                    Console.WriteLine(toGet.data);
                    Console.WriteLine("Max eltávolítása:");
                    toGet = testQ.RemMax();
                    Console.WriteLine(toGet.data);
                    Console.WriteLine("Max lekérdezése:");
                    toGet = testQ.GetMax();
                    Console.WriteLine(toGet.data);
                    break;
            }
        }
    }
}