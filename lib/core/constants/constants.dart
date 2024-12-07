interface class Constant {
  //for ip address validation
  static final ipRgx = RegExp(
      r"^(?:(?:[0-9]{1,3}\.){3}[0-9]{1,3}|(?:[0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4})$");

  //for android method channel
  static const channel = "dns.configurator/channel";
  static const startMethod = "modify_dns";
  static const stopMethod = "STOP";
  //for linux dns command
  static const linuxCommand = "sudo";
  static linuxArg(String dns) =>
      ["nmcli", "dev", "modify", "ethO", "ipv4.dns", dns];
  //for mac dns command
  static const macCommand = "sudo";
  static macArg(String dns) => ["networksetup", "-setdnsservers", "Wi-Fi", dns];
  //for windows dns command
  static const windowCommand = "netsh";
  static windowArg(String dns) =>
      ["interface", "ipv4", "set", "dnsservers", "Ethernet", "static", dns];
}
