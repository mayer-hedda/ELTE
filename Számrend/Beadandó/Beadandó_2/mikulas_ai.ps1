param(
    [Parameter(Mandatory=$true)]
    [string]$SablonFajl,

    [Parameter(Mandatory=$true)]
    [string]$AdatbazisFajl
)

# Ellenőrizzük, hogy léteznek-e a fájlok
if (-not (Test-Path $SablonFajl) -or -not (Test-Path $AdatbazisFajl)) {
    Write-Host "Hiba: A megadott sablon vagy adatbázis fájl nem található!" -ForegroundColor Red
    exit
}

# Beolvassuk a sablont egyetlen stringként
$sablonSzoveg = Get-Content -Path $SablonFajl -Raw -Encoding UTF8

# Beolvassuk az adatbázist soronként
$adatbazisSorok = Get-Content -Path $AdatbazisFajl -Encoding UTF8

# Végigmegyünk az adatbázis sorain
foreach ($sor in $adatbazisSorok) {
    # Üres sorok átugrása
    if ([string]::IsNullOrWhiteSpace($sor)) { continue }

    # Pontosvessző mentén darabolunk
    $adatok = $sor -split ';'

    # Ellenőrizzük, hogy megvan-e mind a 3 adat
    if ($adatok.Count -ge 3) {
        $nev = $adatok[0].Trim()
        $cim = $adatok[1].Trim()
        $idopont = $adatok[2].Trim()

        # Helyettesítés a sablonban
        $aktualisLevel = $sablonSzoveg -replace '<nev>', $nev `
                                        -replace '<cim>', $cim `
                                        -replace '<idopont>', $idopont

        # Kiírás a szabványos kimenetre
        Write-Output $aktualisLevel
        
        # Elválasztó vonal
        Write-Output "--------------------------------------------------"
    }
}