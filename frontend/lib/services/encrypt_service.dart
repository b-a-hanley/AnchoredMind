import 'package:encrypt/encrypt.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EncryptService {
  late Encrypter encrypter;

  EncryptService() {
    //key generated from encryption key stored in .env
    final key = Key.fromBase64(dotenv.env['ENCRYPTION_KEY']!);
    //encrypter uses advanced encryption standard.
    encrypter = Encrypter(AES(key));
  }

  String encrypt(String plaintext) {
    // generates random 16-byte IV
    final iv = IV.fromSecureRandom(16); 
    final encrypted = encrypter.encrypt(plaintext, iv: iv);
    // return IV + ciphertext together as Base64
    return '${iv.base64}:${encrypted.base64}';
  }

  String decrypt(String combined) {
    //seperate iv and ciphertext
    final parts = combined.split(':');
    if (parts.length != 2) throw Exception('Invalid encrypted format');
    //decode iv an encrypted
    final iv = IV.fromBase64(parts[0]);
    final encrypted = Encrypted.fromBase64(parts[1]);
    //return decrypted text
    return encrypter.decrypt(encrypted, iv: iv);
  }

}