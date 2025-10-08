int db = 0;
int n;
int.TryParse(Console.ReadLine(), out n);
int[] jegy = new int[n];

for (int i = 0; i < jegy.Length; i++)
{
    int.TryParse(Console.ReadLine(), out jegy[i]);
}

for (int i = 0; i < jegy.Length; i++)
{
    if (jegy[i] == 1)
    {
        db++;
    }
}

Console.WriteLine(db);