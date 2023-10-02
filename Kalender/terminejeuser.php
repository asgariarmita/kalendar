<?php
require("includes/config.inc.php");
require("includes/conn.inc.php");
?>
<!DOCTYPE html>
<html lang="de">

<head>
    <meta charset="UTF-8">
    <title>Termin je User</title>
    <style>
        ul {
            list-style-type: none;
        }
    </style>
</head>

<body>
    <h1>Termin je User</h1>
    <!------- Menüpunkte ------->
    <ul>
        <li><a href="alletermine.php">Alle Termine</a></li>
        <li><a href="Startseite.php">Startseite</a></li>
        <li><a href="einladungen.php">Einaldungen</a></li>
    </ul>
</body>

</html>
<?php
// Alle Termine je user anzeigen (alphabetisch) 

// Nickname + (email)
// Vorname
// Notiz 

$sql = "SELECT tbl_user.Nickname, tbl_user.Emailadresse,tbl_user.Vorname, tbl_user.Notiz
FROM tbl_user";

$result = $conn->query($sql) or die("Fehler in der Query " . $conn->error . "<br>" . $sql);
while ($row = $result->fetch_assoc()) {
    echo $row["Nickname"] . "(<a href='" . $row["Emailadresse"] . "'>" . $row["Emailadresse"] . " </a>" . ")<br>";
    echo $row["Vorname"] . "<br>";
    echo $row["Notiz"] . "<br>";

    // Von Bis
    // Termin Name
    // plz, Ort
    // Staat
    // Farbcode (db)

    if ($row["Nickname"] != "") {
        $sql2 = "SELECT tbl_termine.Beginn, tbl_termine.Ende, tbl_termine.Bezeichnung, tbl_termine.PLZ, tbl_termine.Ort, tbl_staaten.Bezeichnung as Staat, tbl_kategorien.Farbcode, tbl_user.Nickname
        FROM tbl_termine
        INNER JOIN tbl_staaten
        ON tbl_termine.FIDStaat = tbl_staaten.IDStaat
        INNER JOIN tbl_kategorien 
        ON tbl_termine.FIDKategorie = tbl_kategorien.IDKategorie
        INNER JOIN tbl_user
        ON tbl_termine.FIDUser = tbl_user.IDUser
        WHERE tbl_user.Nickname = '" . $row["Nickname"] . "';";

        $resultTermine = $conn->query($sql2) or die("Fehler in der Query " . $conn->error . "<br>" . $sql2);
        while ($row = $resultTermine->fetch_assoc()) {
            echo "<ul style= 'border:#" . $row["Farbcode"] . "; border-width:1px; border-style:solid;'><li>Von " . $row["Beginn"] . " Uhr Bis " . $row["Ende"] . " Uhr</li>";
            echo "<li>" . $row["Bezeichnung"] . "</li>";
            echo "<li>" . $row["PLZ"] . " " . $row["Ort"] . "</li>";
            echo "<li>" . $row["Staat"] . "</li></ul>";
        }
    }
}

?>