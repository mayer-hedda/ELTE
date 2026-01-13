<# 
set-executionpolicy remotesigned
#>

# # kiiratás
# "hello world"

<#
Többsoros komment
#>

# # ide írom amiket beolvasok futtatáskor, de tudok alapértelmezett értéket is adni
# param(
#     [int]$n,
#     $asdsa = 0
# )

# # amit ide írok változót, azt nem tudom felülírni, csak használni
# $asd = "asd"

# # kiiratok az outputra valamit
# write-output "asdasd $n | $asd"

# param(
#     [int]$n = 0,

#     # # help esetekhez:
#     # $1,
#     # [switch]$help
# )

# # # help esetekhez:
# # if ($1 -eq "asd") {
# #     "asd"
# # }
# # if($help) {
# #     "asd"
# # }

# if ($n -eq 0 -or $n -gt 100) {
#     "figyu, ez 1-100-ig megy amúgy"
# }

# $nyeroszam = Get-Random -Minimum 1 -Maximum 100     # ha nem adok minimum maximum paramétert, akkor kihasználja a teljes integer teret
# write-output "tipp: $n | "


# param(
#     $n = 10
# )

# $a = 0
# $b = 1

# for ($i = 1; $i -le $n; $i++) {
#    "$a" 
#    $t = $a + $b
#    $a = $b
#    $b = $t
# }



# param(
#     $n = 10
# )

# $say = Read-Host "mit mondjak"
# $say = [int]$say

# "> $say"




# # FELADAT: Számológép : 2 szám meg egy operátor x <operátor> y (+ - * /)
# param(
#     [string]$x,
#     [string]$op,
#     [string]$y
# )
# $x = [double]$x
# $y = [double]$y
# $eredmeny

# switch($op) {
#     "+"{$eredmeny = $x + $y}
#     "-"{$eredmeny = $x - $y}
#     "*"{$eredmeny = $x * $y}
#     "/"{$eredmeny = $x / $y}
#     # "div"{$eredmeny = $x -div $y}             # ezt meg kell nézni
#     "%"{$eredmeny = $x % $y}
# }

# "$x $op $y = $eredmeny"



# param(
#     [string]$x,
#     [string]$op,
#     [string]$y
# )
# function help() {
#     "Használat: x <operáció> y"
# }

# if($op -eq "") {
#     help
#     exit
# }
# if(-not [double]::TryParse($x, [ref]$null)) {
#     "x nem szám"
#     exit
# }
# if(-not [double]::TryParse($y, [ref]$null)) {
#     "y nem szám"
#     exit
# }

# $x = [double]$x
# $y = [double]$y
# $eredmeny

# switch($op) {
#     "+"{$eredmeny = $x + $y}
#     "-"{$eredmeny = $x - $y}
#     "*"{$eredmeny = $x * $y}
#     "/"{$eredmeny = $x / $y}
#     # "div"{$eredmeny = $x -div $y}             # ezt meg kell nézni
#     "%"{$eredmeny = $x % $y}
#     default{
#         help
#         exit
#     }
# }

# "$x $op $y = $eredmeny"




param(
    [string]$x,
    [string]$op,
    [string]$y
)
function help() {
    "Használat: x <operáció> y"
}

if(-not [double]::TryParse($x, [ref]$null)) {
    "x nem szám"
    while(-not [double]::TryParse($x, [ref]$null)){
        "Írj egy x-t:"
        $x = Read-Host ">"
    }
}
if($op -eq "") {
    help
    while($op -eq "") {
        "Írj egy op-ot:"
        $op = Read-Host ">"
    }
}
if(-not [double]::TryParse($y, [ref]$null)) {
    "y nem szám"
    while(-not [double]::TryParse($y, [ref]$null)){
        "Írj egy y-t:"
        $y = Read-Host ">"
    }
}

$x = [double]$x
$y = [double]$y
$eredmeny

switch($op) {
    "+"{$eredmeny = $x + $y}
    "-"{$eredmeny = $x - $y}
    "*"{$eredmeny = $x * $y}
    "/"{$eredmeny = $x / $y}
    "div"{$eredmeny = [Math]::Floor($x / $y)}
    "%"{$eredmeny = $x % $y}
    "sqrt"{$eredmeny = [Math]::Sqrt($x)}
    "^"{$eredmeny = [Math]::Pow($x, $y)}
    default{
        help
        exit
    }
}

"$x $op $y = $eredmeny"