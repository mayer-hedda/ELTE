int[] homersekletek = new int[];
int n;

int.TryParse(Console.ReadLine(), out n);

for (int i = 0; i < n; i++)
{
    int.TryParse(Console.ReadLine(), out homersekletek[i]);
}

int mini = 0;
int mine = homersekletek[mini];
for (int i = 1; i < homersekletek.Length; i++)
{
    if (mine > homersekletek[i])
    {
        mini = i;
        mine = homersekletek[i];
    }
}

Console.WriteLine(mine);