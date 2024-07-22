import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:manvsim/appframe.dart';
import 'package:manvsim/models/types.dart';
import 'package:manvsim/services/api_service.dart';
import 'package:manvsim/widgets/api_future_builder.dart';
import 'package:manvsim/widgets/logout_button.dart';
import 'package:manvsim/widgets/timer_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WaitScreen extends StatefulWidget {
  const WaitScreen({super.key});

  @override
  State<StatefulWidget> createState() => _WaitScreenState();
}

class _WaitScreenState extends State<WaitScreen> {
  late Future<StartTimes?> futureStartTimes;

  @override
  void initState() {
    ApiService apiService = GetIt.instance.get<ApiService>();
    futureStartTimes = apiService.getStartTimes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const <Widget>[LogoutButton()],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppLocalizations.of(context)!.waitText),
      ),
      body: Center(
          child: ApiFutureBuilder<StartTimes>(
        future: futureStartTimes,
        builder: (context, startTimes) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TimerWidget(
                duration: getWaitDuration(startTimes),
                onTimerComplete: goToHome),
            const SizedBox(height: 64),
            ElevatedButton.icon(
              icon: const Icon(Icons.skip_next),
              onPressed: goToHome,
              label: Text(AppLocalizations.of(context)!.waitSkip),
            ),
          ],
        ),
      )),
    );
  }

  void goToHome() {
    ApiService apiService = GetIt.instance.get<ApiService>();
    apiService.api
        .runLocationLeavePost()
        .whenComplete(() => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const AppFrame()),
              (Route<dynamic> route) => false, // Removes previous routes
            ));
  }

  Duration getWaitDuration(StartTimes startTimes) {
    var now = DateTime.now();
    var waitTill = startTimes.arrivalTime != null
        ? startTimes.arrivalTime!
        : startTimes.startTime;
    var difference = waitTill.difference(now);
    return difference.isNegative ? Duration.zero : difference;
  }
}
