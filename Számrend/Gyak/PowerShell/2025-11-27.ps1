# $sum = 0
# foreach ($i in $args) {
#     $sum += [int]$i
# }

# foreach ($line in $input) {
#     # $sum += [int]$line

#     if ($line -as [int]) {      # típúsellenőrzés
#         $sum += $line
#     }
# }
# "$sum"



# $a = [double](Read-Host "a>")
# $b = [double](Read-Host "b>")
# $c = [double](Read-Host "c>")

# $d = [math]::Pow($b, 2) - 4 * $a * $c

# if ($d -ge 0) {
#     $x1 = ((-$b + [math]::Sqrt($d)) / (2 * $a))
#     $x2 = ((-$b - [math]::Sqrt($d)) / (2 * $a))

#     "x1: $x1"
#     "x2: $x2"
# } else {
#     $real = -$b / (2 * $a)
#     $imag = [math]::Sqrt(-$d) / (2 * $a)
#     "x1: $real - ${imag}i"
#     "x2: $real + ${imag}i"
# }



# $in = "szamok.txt"
# $in = (Read-Host "fájl neve>")
# $odd = "odd.txt"
# $even = "even.txt"

# if(Test-Path $in) {
#     "File $in fond"
# } else {
#     "File $in not found"
#     exit
# }

# $i = 1
# Get-Content $in | ForEach-Object {
#     if ($i % 2 -eq 0) {
#         Add-Content $even $_
#     } else {
#         Add-Content $odd $_
#     }
#     $i++
# }



# Prím számok:

# $vege = (Read-Host "Vége>")

# $i = 1
# while($i -le $vege) {
#     $osztok = @()
#     for ($s = $i; $s > 0; $s--) {
#         if($i % $s -eq 0) {

#         }
#     }
# }


function isPrime($a) {
    if($a -lt 2)        {return $false}
    if($a -eq 2)        {return $true}
    if($a % 2 -eq 0)    {return $false}

    $limit = [math]::Sqrt($a)

    for($i = 3; $i -le $limit; $i += 2) {
        if ($a % $i -eq 0) {
            return $false
        }
    }
    return $true
}
for($i = 0; $i -lt [int]$args[0]; i++) {
    if(isPrime($i)) {
        "$i"
    }
}