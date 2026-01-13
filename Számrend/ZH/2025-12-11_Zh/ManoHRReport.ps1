param (
    [string]$Search,
    [string]$Filter,
    [switch]$Help,
    [switch]$h
)

function help () {
    ""
}

if ($Help -or $h) {
    help
    exit
}