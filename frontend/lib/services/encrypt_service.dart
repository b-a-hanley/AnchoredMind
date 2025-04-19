import 'package:encrypt/encrypt.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EncryptService {
  late Encrypter encrypter;

  EncryptService() {
    final key = Key.fromBase64(dotenv.env['ENCRYPTION_KEY']!);
    encrypter = Encrypter(AES(key));
    
  }

  String encrypt(String plaintext) {
    final iv = IV.fromSecureRandom(16); // random 16-byte IV
    final encrypted = encrypter.encrypt(plaintext, iv: iv);
    // Return IV + ciphertext together as Base64
    return '${iv.base64}:${encrypted.base64}';
  }

  String decrypt(String combined) {
    final parts = combined.split(':');
    if (parts.length != 2) throw Exception('Invalid encrypted format');
    final iv = IV.fromBase64(parts[0]);
    final encrypted = Encrypted.fromBase64(parts[1]);
    return encrypter.decrypt(encrypted, iv: iv);
  }

}