import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:test_supabase/data/models/email_model.dart';

abstract class EmailService {
  Future<void> sendEmails(List<EmailDataModel> emailDataList);
}

class EmailServiceImpl implements EmailService {
  static const String _apiPath = 'https://api.resend.com/emails';

  @override
  Future<void> sendEmails(List<EmailDataModel> emailDataList) async {
    try {
      final emailDataLista = [
        EmailDataModel(
            email: 'test@gmail.com',
            firstName: 'Testname',
            lastName: 'Testsurname')
      ];
      final futures = emailDataLista.map((element) {
        return _sendEmail(element);
      }).toList();

      final responses = await Future.wait(futures);
      for (var response in responses) {
        if (response.statusCode == 200) {
          log('Email sent!');
        } else {
          log('Failed to send email: ${response.body}');
        }
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  Future<Response> _sendEmail(EmailDataModel emailData) {
    return http.post(
      Uri.parse(_apiPath),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${dotenv.env['API_KEY']}',
      },
      body: json.encode({
        "from": "onboarding@resend.dev",
        "to": emailData.email,
        "subject": "${emailData.firstName} ${emailData.lastName}",
        "html": "<p>Hello! ${emailData.firstName} ${emailData.lastName}</p>"
      }),
    );
  }
}
