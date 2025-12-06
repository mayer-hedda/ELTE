param(
    [string]$SablonFajl,
    [string]$AdatbazisFajl
)

if (-not $SablonFajl -or -not $AdatbazisFajl) {
    Write-Error "Hiba: Két paramétert kell megadni! Használat: .\mikulas_sajat.ps1 <sablon> <adatbazis>"
    exit 1
}

if (-not (Test-Path $SablonFajl) -or -not (Test-Path $AdatbazisFajl)) {
    Write-Error "Hiba: A megadott fájlok valamelyike nem található."
    exit 1
}

$sablonSzoveg = Get-Content -Path $SablonFajl -Raw

Get-Content -Path $AdatbazisFajl | ForEach-Object {
    $adatok = $_ -split ';'
    
    $nev = $adatok[0]
    $cim = $adatok[1]
    $ido = $adatok[2]

    $sablonSzoveg.Replace('<nev>', $nev).Replace('<cim>', $cim).Replace('<idopont>', $ido)


    Write-Host "----------------------------------------"
}