<?php

// $_POST = $_GET; // Web debugging mode only

$username = $_POST['username'];
$password = $_POST['password'];

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
