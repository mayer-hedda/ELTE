int n;
int[] meresek = new int[];

int.TryParse(Console.ReadLine(), out n);

for (int i = 0; i <= n; i++)
{
    int.TryParse(Console.ReadLine(), out meresek[i]);
}

int napok = 0;
for (int i = 0; i <= meresek.Length; i++)
{
    if (meresek[i] != 0)
    {
        napok++;
    }
}

Console.WriteLine(napok);