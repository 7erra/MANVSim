import 'package:flutter/material.dart';
import 'package:manvsim/screens/qr_screen.dart';
import 'package:manvsim/widgets/logout_button.dart';

class TanScreen extends StatefulWidget {
  const TanScreen({super.key});

  @override
  _TanScreenState createState() => _TanScreenState();

}

class _TanScreenState extends State<TanScreen> {

  String _tan = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Home'),
        actions: const <Widget>[LogoutButton()],
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
              ElevatedButton.icon(
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

                    setState(() {
                      _tan = scannedText;
                    });
                  }

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
