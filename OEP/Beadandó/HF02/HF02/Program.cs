using System;
using System.Collections.Generic;


namespace HF02
{
    public enum Content
    {
        EMPTY,
        WALL,
        GHOST,
        TREASURE
    }
    
    public readonly record struct Position(int X, int Y)
    {
        public bool Inside(int l, int n, int k, int m)
        {
            return l <= X && X <= n && k <= Y && Y <= m;
        }

        public bool Direction()
        {
            return Inside(-1, 1, -1, 1) &&
                   ((X == 0 && Y != 0) || (X != 0 && Y == 0));
        }

        public static Position operator +(Position a, Position b)
        {
            return new Position(a.X + b.X, a.Y + b.Y);
        }
    }
    
    public class Labyrinth
    {
        public int N { get; }
        public int M { get; }

        private readonly Dictionary<Position, Content> map;

        public Labyrinth(int n, int m)
        {
            if (n <= 0 || m <= 0) throw new ArgumentException("A labirintus mérete legyen pozitív.");

            N = n;
            M = m;
            map = new Dictionary<Position, Content>(n * m);

            for (int i = 1; i <= N; i++)
            {
                for (int j = 1; j <= M; j++)
                {
                    map[new Position(i, j)] = Content.EMPTY;
                }
            }
        }

        public void Place(Position pos, Content c)
        {
            if (!map.ContainsKey(pos))
                throw new ArgumentOutOfRangeException(nameof(pos), "Nincs ilyen mező a labirintusban.");

            map[pos] = c;
        }

        public Content Spy(Position pos, Position dir)
        {
            Position target = pos + dir;

            if (!(pos.Inside(1, N, 1, M) &&
                  target.Inside(1, N, 1, M) &&
                  dir.Direction()))
            {
                throw new InvalidOperationException("Érvénytelen kémlelés (pozíció/irány).");
            }

            return map[target];
        }

        public void Gather(Position pos)
        {
            if (!pos.Inside(1, N, 1, M))
                throw new ArgumentOutOfRangeException(nameof(pos), "Nincs ilyen mező a labirintusban.");

            if (map[pos] != Content.TREASURE)
                throw new InvalidOperationException("Itt nincs kincs.");

            map[pos] = Content.EMPTY;
        }
    }
    
    internal class Program
    {
        static void Main(string[] args)
        {
            int n, m;
            string[] separatedLine = Console.ReadLine().Split();
            n = int.Parse(separatedLine[0]);
            m = int.Parse(separatedLine[1]);
            Labyrinth labyrinth = new Labyrinth(n, m);
            for (int i = 0; i < n; i++)
            {
                separatedLine = Console.ReadLine().Split();
                for (int j = 0; j < m; j++)
                {
                    switch (separatedLine[j])
                    {
                        case "Üres":
                            labyrinth.Place(new Position(i+1, j+1), Content.EMPTY);
                            break;
                        case "Fal":
                            labyrinth.Place(new Position(i+1, j+1), Content.WALL);
                            break;
                        case "Kincs":
                            labyrinth.Place(new Position(i+1, j+1), Content.TREASURE);
                            break;
                        case "Szellem":
                            labyrinth.Place(new Position(i+1, j+1), Content.GHOST);
                            break;
                    }
                }
            }

            try
            {
                separatedLine = Console.ReadLine().Split();
                labyrinth.Gather(new Position(int.Parse(separatedLine[0]), int.Parse(separatedLine[1])));
                Console.WriteLine("Sikerült begyűjteni");
            }
            catch (Exception e)
            {
                Console.WriteLine("Nem sikerült a begyűjtés");
            }
            try
            {
                separatedLine = Console.ReadLine().Split();
                Position pos = new Position(int.Parse(separatedLine[0]), int.Parse(separatedLine[1]));
                separatedLine = Console.ReadLine().Split();
                Position dir = new Position(int.Parse(separatedLine[0]), int.Parse(separatedLine[1]));
                Content result = labyrinth.Spy(pos, dir);
                if (result == Content.TREASURE)
                    Console.WriteLine("Kincs");
                else if (result == Content.WALL)
                    Console.WriteLine("Fal");
                else if (result == Content.EMPTY)
                    Console.WriteLine("Üres");
                else
                    Console.WriteLine("Szellem");
            }
            catch (Exception e)
            {
                Console.WriteLine("Nem sikerült megtekinteni a tartalmat");
            }
        }
    }
}
