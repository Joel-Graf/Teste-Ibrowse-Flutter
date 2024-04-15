import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:app/app_colors.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  String _userName = '';
  late File _userFile;

  @override
  void initState() {
    super.initState();
    _initFileAndReadUserName();
  }

  _initFileAndReadUserName() async {
    await _initFile();
    _readUserName();
  }

  _initFile() async {
    final directory = await getApplicationDocumentsDirectory();
    _userFile = File('${directory.path}/nome_usuario.txt');
  }

  _readUserName() async {
    try {
      if (_userFile.existsSync()) {
        setState(() {
          _userName = _userFile.readAsStringSync();
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro ao ler o nome do usuário'),
          backgroundColor: AppColors.error,
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  _writeUserName(String name) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      await _userFile.writeAsString(name);
      setState(() {
        _userName = name;
      });
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text('Nome do usuário gravado com sucesso'),
          backgroundColor: AppColors.primary,
          duration: Duration(seconds: 1),
        ),
      );
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text('Erro ao gravar o nome do usuário'),
          backgroundColor: AppColors.error,
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Segunda tela'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Nome do Usuário:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              _userName,
              style: const TextStyle(
                fontSize: 24,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                hintText: 'Digite o seu nome',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _writeUserName(_textEditingController.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              child: const Text('Gravar Nome'),
            ),
          ],
        ),
      ),
    );
  }
}
