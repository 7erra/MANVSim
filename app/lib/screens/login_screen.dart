import 'package:flutter/material.dart';
import 'package:manvsim/screens/qr_screen.dart';

import 'name_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();


}

class _LoginScreenState extends State<LoginScreen> {

  String _url = '';
  String _tan = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: TextEditingController(text: _tan),
                decoration: const InputDecoration(
                  labelText: 'TAN',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: TextEditingController(text: _url),
                decoration: const InputDecoration(
                  labelText: 'Server URL',
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.qr_code_scanner),
                      label: const Text('Scan QR Code'),
                      onPressed: () async {

                        final scannedText = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QRScreen(),
                          ),
                        );
                        if (scannedText != null) {

                          final url = scannedText.split('/').sublist(0, scannedText.split('/').length - 1).join('/');
                          final tan = scannedText.split('/').last;

                          setState(() {
                            _url = url;
                            _tan = tan;
                          });
                        }

                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.login),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NameScreen()));
                      },
                      label: const Text('Login'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}