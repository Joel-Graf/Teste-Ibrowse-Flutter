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
    final directory = await getApplicationDocumentsDirectory();
    final userFilePath = '${directory.path}/nome_usuario.txt';
    _userFile = File(userFilePath);

    if (_userFile.existsSync()) {
      setState(() {
        _userName = _userFile.readAsStringSync();
      });
    } else {
      _showSnackBar('Erro ao ler o nome do usuário', AppColors.error);
    }
  }

  _writeUserName(String name) async {
    try {
      await _userFile.writeAsString(name);
      setState(() {
        _userName = name;
      });
      _showSnackBar('Nome do usuário gravado com sucesso', AppColors.success);
    } catch (e) {
      _showSnackBar('Erro ao gravar o nome do usuário', AppColors.error);
    }
  }

  void _showSnackBar(String message, Color color) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 1),
      ),
    );
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
