int n;
int.TryParse(Console.ReadLine(), out n);

int[] meresek = new int[];
for (int i = 0; i < n; i++)
{
    int.TryParse(Console.ReadLine(), out meresek[i]);
}

int db = 0;
for (int i = 0; i < meresek.Length; i++)
{
    if (meresek[i] < 0)
    {
        db += 1;
    }
}

Console.WriteLine(db);