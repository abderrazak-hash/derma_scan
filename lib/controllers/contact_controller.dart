import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class ContactController extends ChangeNotifier {
  final String recipientEmail = 'geekgeniusr@gmail.com';
  late TextEditingController subjectController, emailController, bodyController;

  ContactController() {
    emailController = TextEditingController();
    subjectController = TextEditingController();
    bodyController = TextEditingController();
  }

  Future<void> sendEmail() async {
    final Email email = Email(
      body: bodyController.text,
      subject: subjectController.text,
      recipients: [recipientEmail],
      cc: [],
      bcc: [],
      attachmentPaths: [],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }
}