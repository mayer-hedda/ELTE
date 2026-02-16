using System.Drawing;
using TextFile;

namespace Circle_Point_Skeleton
{
    /*
    !!! ELŐADÁS !!!
    
    - Osztály Vs Objektum
        Osztály: objektum szerkezetének mintáját adja meg "objektum típusa"
        Objektum: önálló egyede egy osztálynak
    
    - Konstruktor
        objektum példányosításakor lefutó "metódus"
        paramétereket várhat
    
    - Metódus
        osztály viselkedését/"cselekvéseit" írja le
        - osztályszintű metódus = static
            nem kell objektumot létrehozni a metódus meghívásához
    
    - Osztály adattagok
        osztályt leíró "tulajdonságok"
    
    - Láthatóság
        private, public, később protected
    
    - new kulcsszó
        új objektum inicializálása
     */
    internal class Program
    {
        static void Main()
        {
            //try catch => elkapjuk a kivételeket
            try
            {
                //txt legyen Content és Copy if newer
                TextFileReader reader = new TextFileReader("input.txt");

                reader.ReadDouble(out double a);
                reader.ReadDouble(out double b);
                reader.ReadDouble(out double c);

                // új objektum létrehozása new kulcsszóval => lefut az osztály konstruktora
                Circle circle = new Circle(new Point(a, b), c);

                reader.ReadInt(out int n);

                Point[] points = new Point[n];

                for (int i = 0; i < n; i++)
                {
                    reader.ReadDouble(out a);
                    reader.ReadDouble(out b);
                    points[i] = new Point(a, b);
                }

                // számlálás ~ progalap
                int db = 0;
                foreach (Point point in points)
                {
                    //metódus meghívása paraméterrel
                    if (circle.Contains(point))
                    {
                        db++;
                    }
                }
                Console.WriteLine($"A kör lemezére eső pontok száma: {db}");

            }
            catch (FileNotFoundException)
            {
                Console.WriteLine("Rossz a fájl név!");
            }
            catch (Circle.NonPositiveRadius)
            {
                Console.WriteLine("Kör sugara nem lehet negativ!");
            }
        }
    }
}
