<!-- HTTP methodok: GET, POST, PUT, DELETE, PATCH, HEAD, OPTIONS -->
<!-- GET: Adatok lekérése -->
<!-- POST: Új adatok küldése -->
<!-- PUT: Létező adatok frissítése -->
<!-- DELETE: Adatok törlése -->
<!-- PATCH: Részleges adatfrissítés -->
<!-- HEAD: Fejlécek lekérése -->
<!-- OPTIONS: Támogatott HTTP metódusok listázása -->

<?php
$name = isset($_POST["username"]) ? $_POST["username"] : "";

var_dump($name);
?>
<form action="" method="post">
    <label for="name">Username:</label>
    <input type="text" name="username" id="name" value="<?= htmlspecialchars($name) ?>">
    <button type="submit">Send</button>
</form>