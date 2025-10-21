/*
* Feladat: Fibonacci számok --> Irasd ki az első n darabot.
* Tömbök használatával (3 pont)
* Tömbök nélkül (7 pont)
*/
int n;      // Bemenet
int aktualis;
int elso = 0;
int masodik = 1;

Console.Write("Kérem adja meg n értékét: ");
int.TryParse(Console.ReadLine(), out n);

// Tömbökkel
List<int> eredmeny = new List<int> { 0, 1 };   // Kimenet
for (int i = 2; i < n; i++)
{
    int kovetkezo = eredmeny[i - 1] + eredmeny[i - 2];
    eredmeny.Add(kovetkezo);
}
Console.WriteLine($"A Fibonacci sorozat első {n} száma tömbökkel:\n {string.Join(", ", eredmeny)}");


// Tömbök nélkül
for (int i = 0; i < n; i++)
{
    if (i == 0)
    {
        Console.Write($"A Fibonacci sorozat első {n} száma tömbök nélkül:\n {elso}");
        continue;
    }
    else if (i == 1)
    {
        Console.Write(", " + masodik);
        continue;
    }

    aktualis = elso + masodik;
    Console.Write(", " + aktualis);

    elso = masodik;
    masodik = aktualis;
}