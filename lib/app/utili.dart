import 'dart:io';

Future<String?> getIP() async {
  for (var interface in await NetworkInterface.list()) {
    for (var addr in interface.addresses) {
      if (addr.type == InternetAddressType.IPv4 &&
          !addr.isLoopback &&
          (addr.address.startsWith('192.168') ||
              addr.address.startsWith('10.'))) {
        return addr.address;
      }
    }
  }
  return null;
}