<?php
require("includes/config.inc.php");
require("includes/conn.inc.php");
?>
<!DOCTYPE html>
<html lang="de">

<head>
    <meta charset="UTF-8">
    <title>Termine</title>
    <style>
        ul {
            list-style-type: none;
        }
    </style>
</head>

<body>
    <h1>Alle Termine</h1>
    <!------- Menüpunkte ------->
    <ul>
        <li><a href="Startseite.php">Startseite</a></li>
        <li><a href="terminejeuser.php">Termine Je User</a></li>
        <li><a href="einladungen.php">Einaldungen</a></li>
    </ul><br>
    <!------- Formular ------->
    <form action="alletermine.php" method="post">
        <label for=>Terminkategorie:</label><br>
        <input type="text" name="kat"> <br>
        <label for=>Terminbezeichnung:</label><br>
        <input type="text" name="bez"> <br>
        <label for=>Nickname/Emailadresse:</label><br>
        <input type="text" name="nickmail"> <br>
        <label for=>Datum</label><br>
        <label for=>Von</label><br>
        <input type="datetime-local" name="von"> <br>
        <label for=>Bis</label><br>
        <input type="datetime-local" name="bis"> <br>
        <button>Suchen</button>
    </form>

</body>

</html>
<?php
// ------- Filter -------
if (count($_POST) > 0) {
    if (strlen($_POST["kat"]) > 0) {
        $arr[] = "tbl_termine.Bezeichnung = '" . $_POST["kat"] . "'";
    }
    if (strlen($_POST["bez"]) > 0) {
        $arr[] = "tbl_kategorien.Bezeichnung = '" . $_POST["bez"] . "'";
    }
    if (strlen($_POST["nickmail"]) > 0) {
        if (str_contains($_POST["nickmail"], "@")) {
            $arr[] = "tbl_user.Emailadresse = '" . $_POST["nickmail"] . "'";
        } else {
            $arr[] = "tbl_user.Nickname = '" . $_POST["nickmail"] . "'";
        }
    }
    if (strlen($_POST["von"]) > 0) {
        $arr[] = "tbl_termine.Beginn = '" . $_POST["von"] . "'";
    }
    if (strlen($_POST["bis"]) > 0) {
        $arr[] = "tbl_termine.Ende = '" . $_POST["bis"] . "'";
    }
    // ------- implode(string $separator, array $array): string -------
    $sql = "
    SELECT 
        tbl_termine.Beginn, tbl_termine.Ende, tbl_termine.Bezeichnung, 
        tbl_termine.PLZ, tbl_termine.Ort, tbl_staaten.Bezeichnung AS 'Staat', tbl_kategorien.Bezeichnung AS 'Kat',
        tbl_kategorien.Farbcode, tbl_user.Nickname, tbl_user.Emailadresse, tbl_termine.Adresse
    FROM 
        tbl_termine
    INNER JOIN 
        tbl_user
    ON 
        tbl_termine.FIDUser = tbl_user.IDUser
    INNER JOIN 
        tbl_staaten
    ON 
        tbl_termine.FIDStaat = tbl_staaten.IDStaat
    INNER JOIN 
        tbl_kategorien 
    ON 
        tbl_termine.FIDKategorie = tbl_kategorien.IDKategorie
    WHERE(
        " . implode(" AND ", $arr) . "
    )";
} else {
    // ------- ohne Filter -------
    $sql = "
        SELECT 
            tbl_termine.Beginn, tbl_termine.Ende, tbl_termine.Bezeichnung, 
            tbl_termine.PLZ, tbl_termine.Ort, tbl_staaten.Bezeichnung AS 'Staat', tbl_kategorien.Bezeichnung AS 'Kat',
            tbl_kategorien.Farbcode, tbl_user.Nickname, tbl_termine.Adresse
        FROM 
            tbl_termine
        INNER JOIN 
            tbl_user
        ON 
            tbl_termine.FIDUser = tbl_user.IDUser
        INNER JOIN 
            tbl_staaten
        ON 
            tbl_termine.FIDStaat = tbl_staaten.IDStaat
        INNER JOIN 
            tbl_kategorien 
        ON 
            tbl_termine.FIDKategorie = tbl_kategorien.IDKategorie;";
}
// Ausgabe
// ------- or die : Wenn kein Verbindung dann beenden und nicht weitermachen -------
$result = $conn->query($sql) or die("Fehler in der Query " . $conn->error . "<br>" . $sql);
while ($row = $result->fetch_assoc()) {
    echo "<ul style= 'border:#" . $row["Farbcode"] . "; border-width:1px; border-style:solid;'><li align='right'>" . $row["Nickname"] . "</li>";
    echo "<li>Von " . $row["Beginn"] . " Uhr Bis " . $row["Ende"] . " Uhr</li>";
    echo "<li>" . $row["Bezeichnung"] . "</li>";
    echo "<li>" . $row["Kat"] . "</li>";
    echo "<li>" . $row["Adresse"] . "</li>";
    echo "<li>" . $row["PLZ"] . " " . $row["Ort"] . "</li>";
    echo "<li>" . $row["Staat"] . "</li></ul>";
}

?>