{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.isak = {
    isNormalUser = true;
    description = "Isak";
    extraGroups = ["networkmanager" "wheel"];
  };
}
