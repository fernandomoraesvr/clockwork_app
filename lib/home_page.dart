import 'package:clockwork_app/clockwork_response.dart';
import 'package:clockwork_app/clockwork_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final ClockworkService clockworkService;

  const HomePage({super.key, required this.clockworkService});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controller = TextEditingController();

  ClockworkResponse? clockworkResponse;

  bool isRequesting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const Text('Tarefa: '),
              TextFormField(
                textCapitalization: TextCapitalization.characters,
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Digite a tarefa',
                ),
              ),
              const SizedBox(height: 24),
              MaterialButton(
                onPressed: () async {
                  try {
                    if (isRequesting) return;

                    setState(() {
                      isRequesting = true;
                    });

                    final response = await widget.clockworkService
                        .startTimer(controller.text);

                    setState(() {
                      clockworkResponse = response;
                    });
                  } catch (ex) {
                    clockworkResponse = ClockworkResponse.fromJson({
                      "messages": [
                        {
                          "title": "Erro",
                          "body": "Erro ao iniciar o timer",
                          "type": "error",
                        }
                      ]
                    });
                  } finally {
                    setState(() {
                      isRequesting = false;
                    });
                  }
                },
                child: const Text('START'),
              ),
              const SizedBox(height: 24),
              MaterialButton(
                onPressed: () async {
                  try {
                    if (isRequesting) return;

                    setState(() {
                      isRequesting = true;
                    });

                    final response = await widget.clockworkService
                        .stopTimer(controller.text);

                    setState(() {
                      clockworkResponse = response;
                    });
                  } catch (ex) {
                    clockworkResponse = ClockworkResponse.fromJson({
                      "messages": [
                        {
                          "title": "Erro",
                          "body": "Erro ao parar o timer",
                          "type": "error",
                        }
                      ]
                    });
                  } finally {
                    setState(() {
                      isRequesting = false;
                    });
                  }
                },
                child: const Text('STOP'),
              ),
              const SizedBox(height: 24),
              !isRequesting && clockworkResponse != null
                  ? Expanded(
                      child: ListView.builder(
                          itemCount: clockworkResponse?.messages.length,
                          itemBuilder: (ctx, index) => Column(
                                children: [
                                  Text(clockworkResponse
                                          ?.messages[index].title ??
                                      ''),
                                  Text(
                                      clockworkResponse?.messages[index].body ??
                                          ''),
                                ],
                              )),
                    )
                  : Container(),
              isRequesting ? const CircularProgressIndicator() : Container()
            ],
          )),
    );
  }
}
