part of 'services.dart';

class SendEmailService {
  static Future<http.Response> sendEmail(String mail) {
    return http.post(
        Uri.https("gavinthan.com", "/Week5/index.php/api/Mahasiswa/sendmail"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': mail,
        }));
  }
}
