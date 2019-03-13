<?php

if (empty($_POST)) {
  $_POST = $_GET; // Enables web access
}

$data = json_decode(file_get_contents('php://input'), true);

$username = $data['username'];
$password = $data['password'];

if (!$username || !$password) {
  die("Invalid login credentials.");
}

$conn = new mysqli('127.0.0.1', 'root', '12345678', 'demo');

if (!$conn) {
  echo "Failed to connect";
}

$sql = "SELECT * FROM users WHERE username='" . $username . "';";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
  $userdata = $result->fetch_assoc();
  if ($userdata["password"] == $password) {
    echo json_encode($userdata);
  } else {
    echo "Invalid password.";
  }
} else {
  echo "No records found.";
}

?>
