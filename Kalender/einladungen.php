<?php
require("includes/config.inc.php");
require("includes/conn.inc.php");
?>
<!DOCTYPE html>
<html lang="de">

<head>
    <meta charset="UTF-8">
    <title>Einladungen</title>
    <style>
        ul {
            list-style-type: none;
        }
    </style>
</head>

<body>
    <h1>Einladungen</h1>
    <!------- Menüpunkte ------->
    <ul>
        <li><a href="alletermine.php">Alle Termine</a></li>
        <li><a href="terminejeuser.php">Termine Je User</a></li>
        <li><a href="Startseite.php">Startseite</a></li>
    </ul>
</body>

</html>
<?php
// VON BIS
// Bezeichnung
// PLZ UND ORT
// STAAT 
// eingeladen sind
// ------- SQL -------
$sql = "
SELECT 
    tbl_termine.Beginn, tbl_termine.Ende, tbl_termine.Bezeichnung, 
    tbl_termine.PLZ, tbl_termine.Ort, tbl_staaten.Bezeichnung AS 'Staat', 
    tbl_kategorien.Farbcode, tbl_user.Nickname
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

// ------- Ausgabe Termine -------
$result = $conn->query($sql) or die("Fehler in der Query " . $conn->error . "<br>" . $sql);
while ($row = $result->fetch_assoc()) {
    echo "<ul style= 'border:#" . $row["Farbcode"] . "; border-width:1px; border-style:solid;'><li align='right'>" . $row["Nickname"] . "</li>";
    echo "<li>Von " . $row["Beginn"] . " Uhr Bis " . $row["Ende"] . " Uhr</li>";
    echo "<li>" . $row["Bezeichnung"] . "</li>";
    echo "<li>" . $row["PLZ"] . " " . $row["Ort"] . "</li>";
    echo "<li>" . $row["Staat"] . "</li>";
    echo "<li> Eingeladen sind:</li>";

    // nickname + status
    // ------- Ausgabe Einladungen -------
    $sql2 = "
        SELECT 
            tbl_termine_einladungen.FIDTermin, tbl_termine.Bezeichnung, tbl_user.Nickname, tbl_einladungsstati.Bezeichnung AS 'Status'
        FROM 
            tbl_termine_einladungen
        INNER JOIN 
            tbl_termine
        ON 
            tbl_termine_einladungen.FIDTermin = tbl_termine.IDTermin
        INNER JOIN 
            tbl_user
        ON 
            tbl_termine_einladungen.FIDUser = tbl_user.IDUser
        INNER JOIN 
            tbl_einladungsstati
        ON 
            tbl_termine_einladungen.FIDEinladungsstatus = tbl_einladungsstati.IDEinladungsstatus
        WHERE 
            tbl_termine.Bezeichnung = '" . $row["Bezeichnung"] . "';";

    $resultInvite = $conn->query($sql2) or die("Fehler in der Query " . $conn->error . "<br>" . $sql2);
    while ($row = $resultInvite->fetch_assoc()) {

        echo "<li>" . $row["Nickname"] . " : " . $row["Status"] . "</li>";
    }
    echo "</ul>";
}
?>