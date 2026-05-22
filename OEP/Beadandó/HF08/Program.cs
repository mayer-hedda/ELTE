namespace HF08
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Unittest to run");
            string valasztas = Console.ReadLine();

            switch (valasztas)
            {
                case "File":
                    TestFile();
                    break;

                case "Folder":
                    TestFolder();
                    break;
            }
        }

        public static void TestFile()
        {
            Console.WriteLine("Unittesting File class");
            Console.WriteLine("Testing - Constructor");

            File vizsgaltFajl;
            int meretErtek;

            try
            {
                Console.WriteLine("Input - Size of file");
                meretErtek = int.Parse(Console.ReadLine());
                vizsgaltFajl = new File(meretErtek);
            }
            catch
            {
                Console.WriteLine("Result - Constructor - Unsuccessful");
            }

            Console.WriteLine("Testing - GetSize");

            try
            {
                Console.WriteLine("Input - Size of file");
                meretErtek = int.Parse(Console.ReadLine());
                vizsgaltFajl = new File(meretErtek);
                Console.WriteLine(vizsgaltFajl.GetSize());
            }
            catch
            {
                Console.WriteLine("Result - GetSize - Unsuccessful");
            }

            Console.WriteLine("Testing - Inheritance");

            try
            {
                Registration orokoltPelda = new File(10);
                Console.WriteLine("Inherited registration");
            }
            catch
            {
                Console.WriteLine("Result - Inheritance - Unsuccessful");
            }
        }

        public static void TestFolder()
        {
            Console.WriteLine("Unittesting Folder class");
            Console.WriteLine("Testing - Constructor");

            Folder vizsgaltMappa;

            try
            {
                vizsgaltMappa = new Folder();
            }
            catch
            {
                Console.WriteLine("Result - Constructor - Unsuccessful");
            }

            Console.WriteLine("Testing - Add and Remove");

            try
            {
                vizsgaltMappa = new Folder();
                Console.WriteLine(vizsgaltMappa.GetSize());

                File ujAdatfajl = new File(100);
                vizsgaltMappa.Add(ujAdatfajl);
                Console.WriteLine(vizsgaltMappa.GetSize());

                vizsgaltMappa.Remove(ujAdatfajl);
                Console.WriteLine(vizsgaltMappa.GetSize());
            }
            catch
            {
                Console.WriteLine("Result - Add and Remove - Unsuccessful");
            }

            Console.WriteLine("Testing - GetSize");

            try
            {
                vizsgaltMappa = new Folder();
                ReadRegistrations(vizsgaltMappa);
                Console.WriteLine(vizsgaltMappa.GetSize());
            }
            catch
            {
                Console.WriteLine("Result - GetSize - Unsuccessful");
            }

            Console.WriteLine("Testing - Inheritance");

            try
            {
                Registration orokoltBejegyzes = new File(10);
                Console.WriteLine("Inherited registration");
            }
            catch
            {
                Console.WriteLine("Result - Inheritance - Unsuccessful");
            }
        }

        public static void ReadRegistrations(Folder gyoker)
        {
            Console.WriteLine("Input - Registrations in the folder");
            int bejegyzesekSzama = int.Parse(Console.ReadLine());

            string[] adatSor;

            for (int j = 0; j < bejegyzesekSzama; j++)
            {
                Console.WriteLine("Input - Registration");
                adatSor = Console.ReadLine().Split();

                if (adatSor[0] == "Folder")
                {
                    Folder hozzaadottMappa = new Folder();
                    gyoker.Add(hozzaadottMappa);
                    ReadRegistrations(hozzaadottMappa);
                }
                else
                {
                    File hozzaadottFajl = new File(int.Parse(adatSor[1]));
                    gyoker.Add(hozzaadottFajl);
                }
            }
        }
    }
}