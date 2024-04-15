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
          backgroundColor: AppColors.success,
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Nome do usuário:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  _userName,
                  style: const TextStyle(
                    fontSize: 24,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _textEditingController,
                  cursorColor: AppColors.primary,
                  decoration: InputDecoration(
                    hintText: 'Digite o seu nome',
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primary.withOpacity(0.5),
                      ),
                    ),
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
                  child: const Text(
                    'Gravar nome',
                    style: TextStyle(
                      color: AppColors.whiteText,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
