int n;
int.TryParse(Console.ReadLine(), out n);
int[] arak = new int[n];

for (int i = 0; i < arak.Length; i++) int.TryParse(Console.ReadLine(), out arak[i]);

int maxi = 0;
int maxe = arak[0];

for (int i = 1; i < arak.Length; i++)
{
    if (arak[i] > maxe)
    {
        maxi = i;
        maxe = arak[i];
    }
}

Console.WriteLine(maxi);