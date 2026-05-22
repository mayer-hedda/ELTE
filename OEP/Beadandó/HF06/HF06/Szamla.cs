namespace SzamitastechnikaiUzlet;

public class Szamla
{
    public string Nev { get; }
    public int Osszeg { get; private set; }

    public Szamla(string vasarloNeve)
    {
        Nev = vasarloNeve;
        Osszeg = 0;
    }

    public void UjTetel(int ar)
    {
        Osszeg += ar;
    }
}