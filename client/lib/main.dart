import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'greeter.pbgrpc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String _result;

  late TextEditingController _nameController;

  @override
  void initState() {
    _result = 'Waiting...';
    _nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> sayHello() async {
    final channel = ClientChannel(
      'localhost',
      port: 50051,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    final stub = GreeterClient(channel);
    try {
      final response = await stub.sayHello(
        HelloRequest()..message = _nameController.text,
      );
      setState(() {
        _result = response.message;
      });
    } catch (e) {
      setState(() {
        _result = 'Error: $e';
      });
    } finally {
      await channel.shutdown();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter gRPC Demo')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          spacing: 20.0,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Your Name'),
            ),
            ElevatedButton(onPressed: sayHello, child: const Text('Say Hello')),
            Text(_result),
          ],
        ),
      ),
    );
  }
}
