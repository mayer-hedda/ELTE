<!-- php -S localhost:8000 -->


<!-- <h1>Hello World!</h1> -->
<?php
//* Lehetséges kiiratási módok
// print("Kiscica");
// print "alma";
// echo("kutya");
// echo "macska";


//* Változók
$name = "Foo";
// print("Hello $name!");


//* Ciklusok
$fruits = ["alma", "körte", "banán"];
foreach ($fruits as $fruit) {
    $name = $name . ", " . $fruit;      // összefűzés
}


//* Hibák kezelése
$name = "User";
$creditCardNumber = "ABC-123";  // hibás kártyaszám
// $creditCardNumber = "1234-1234-1234-1234";  // helyes kártyaszám
$errors = [];

// var_dump(!preg_match("/^[0-9-]+$/", $creditCardNumber));

if (!preg_match("/^[0-9-]+$/", $creditCardNumber)) {
    $errors[] = "A kártyaszám csak számokat és kötőjeleket tartalmazhat!";
}

$parts = explode("-", $creditCardNumber);
if (count($parts) !== 4) {
    $errors[] = "A kártyaszámnak 4 részből kell állnia!";
}


//* Objektumok
$transactions = [
    ["vendor" => "Amazon", "amount" => -1000],
    ["vendor" => "Apple", "amount" => -2000],
    ["vendor" => "Microsoft", "amount" => -3000]
];


//* Osztályok
class Transaction
{
    public $vendor;
    public $amount;
    private $currency;

    public function __construct(string $vendor, int $amount, string $currency)
    {
        $this->vendor = $vendor;
        $this->amount = $amount;
        $this->currency = $currency;
    }

    public function getAmount(): string
    {
        return $this->amount . " " . $this->currency;
    }
}

$newTransactions = [
    new Transaction("Amazon", -1000, "USD"),
    new Transaction("Apple", -2000, "USD"),
    new Transaction("Microsoft", -3000, "USD")
];
?>

<!-- KIIRATÁS -->
<!DOCTYPE html>
<html lang="hu">

<head>
    <link rel="stylesheet" href="style.css">
</head>

<body>
    <h1>Hello <?= $name; ?>!</h1> <!-- A kiiratás rövidített formája -->
    <?php
    if (count($errors)): ?>
        <ul>
            <?php foreach ($errors as $error): ?>
                <li class="error"><?= $error; ?></li>
            <?php endforeach; ?>
        </ul>
    <?php else: ?>
        <p class="success">A kártyaszám helyes!</p>
    <?php endif; ?>

    <table>
        <thead>
            <tr>
                <th>Vendor</th>
                <th>Amount</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($transactions as $transaction): ?>
                <tr>
                    <td><?= $transaction["vendor"]; ?></td>
                    <td><?= $transaction["amount"]; ?></td>
                </tr>
            <?php endforeach; ?>
        </tbody>
    </table>

    <table>
        <thead>
            <tr>
                <th>Vendor</th>
                <th>Amount</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($newTransactions as $transaction): ?>
                <tr>
                    <td><?= $transaction->vendor; ?></td>
                    <td><?= $transaction->getAmount(); ?></td>
                </tr>
            <?php endforeach; ?>
        </tbody>
</body>

</html>