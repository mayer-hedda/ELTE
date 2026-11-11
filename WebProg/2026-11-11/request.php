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
$errors = [];
$inputs = [];

$inputs['creditCardNumber'] = isset($_GET['creditcard']) ? $_GET['creditcard'] : NULL;

// var_dump(!preg_match("/^[0-9-]+$/", $creditCardNumber));
if (!is_null($inputs['creditCardNumber'])) {
    if (!preg_match("/^[0-9-]+$/", $inputs['creditCardNumber'])) {
        $errors[] = "A kártyaszám csak számokat és kötőjeleket tartalmazhat!";
    }

    $parts = explode("-", $inputs['creditCardNumber']);
    if (count($parts) !== 4) {
        $errors[] = "A kártyaszámnak 4 részből kell állnia!";
    }
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

    <form action="request.php" method="get">
        <input type="text" name="creditcard"
            value="<?php echo isset($inputs['creditCardNumber']) ? $inputs['creditCardNumber'] : ''; ?>">
        <button type="submit">Search</button>
    </form>

    <?php if (!is_null($inputs["creditCardNumber"])): ?>
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
    </table>
</body>

</html>