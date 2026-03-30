import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const JokenpohApp());
}

class JokenpohApp extends StatelessWidget {
  const JokenpohApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jokenpoh Atividade',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF1F1F1),
        primaryColor: const Color(0xFFFF4242),
      ),
      home: const JokenpohPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class JokenpohPage extends StatefulWidget {
  const JokenpohPage({super.key});

  @override
  State<JokenpohPage> createState() => _JokenpohPageState();
}

class _JokenpohPageState extends State<JokenpohPage> {
  bool _mostrarTelaResultado = false;
  String _escolhaUsuario = "padrao";
  String _escolhaApp = "padrao";
  String _textoResultado = "";
  String _iconeResultado = "assets/images/padrao.png";

  void _jogar(String escolhaUsuario) {
    final opcoes = ["pedra", "papel", "tesoura"];
    final escolhaAleatoria = opcoes[Random().nextInt(3)];

    String texto;
    String icone;

    if (escolhaUsuario == escolhaAleatoria) {
      texto = "Empate!";
      icone = "assets/images/icons8-aperto-de-mãos-100.png";
    } else if ((escolhaUsuario == "pedra" && escolhaAleatoria == "tesoura") ||
        (escolhaUsuario == "papel" && escolhaAleatoria == "pedra") ||
        (escolhaUsuario == "tesoura" && escolhaAleatoria == "papel")) {
      texto = "Você Venceu!";
      icone = "assets/images/icons8-vitória-48.png";
    } else {
      texto = "Você Perdeu!";
      icone = "assets/images/icons8-perder-48.png";
    }

    setState(() {
      _escolhaUsuario = escolhaUsuario;
      _escolhaApp = escolhaAleatoria;
      _textoResultado = texto;
      _iconeResultado = icone;
      _mostrarTelaResultado = true;
    });
  }

  Widget _buildAppBar() {
    return Container(
      color: const Color(0xFFFF4242),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: const Center(
        child: Text(
          'Pedra, Papel, Tesoura',
          style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildImageCircle({required String imagePath, required double size, bool canTap = false, String choiceKey = ""}) {
    return GestureDetector(
      onTap: canTap ? () => _jogar(choiceKey) : null,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), spreadRadius: 2, blurRadius: 5, offset: const Offset(0, 3))
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(imagePath, fit: BoxFit.contain),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: _mostrarTelaResultado ? _buildResultScreen() : _buildSelectionScreen(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(height: 20.0),
        Column(
          children: [
            _buildImageCircle(imagePath: "assets/images/padrao.png", size: 200.0),
            const SizedBox(height: 16.0),
            const Text('Escolha do APP', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black)),
          ],
        ),
        const SizedBox(height: 60.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildImageCircle(imagePath: "assets/images/pedra.png", size: 80.0, canTap: true, choiceKey: "pedra"),
            _buildImageCircle(imagePath: "assets/images/papel.png", size: 80.0, canTap: true, choiceKey: "papel"),
            _buildImageCircle(imagePath: "assets/images/tesoura.png", size: 80.0, canTap: true, choiceKey: "tesoura"),
          ],
        ),
        const SizedBox(height: 32.0),
      ],
    );
  }

  Widget _buildResultScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            _buildImageCircle(imagePath: "assets/images/$_escolhaApp.png", size: 160.0),
            const SizedBox(height: 12.0),
            const Text('Escolha do APP', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black87)),
          ],
        ),
        const SizedBox(height: 20.0),
        Column(
          children: [
            _buildImageCircle(imagePath: "assets/images/$_escolhaUsuario.png", size: 160.0),
            const SizedBox(height: 12.0),
            const Text('Sua Escolha', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black87)),
          ],
        ),
        const SizedBox(height: 20.0),
        Column(
          children: [
            Container(
              height: 120.0,
              width: 120.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), spreadRadius: 2, blurRadius: 5, offset: const Offset(0, 3))
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(_iconeResultado, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
                _textoResultado,
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: _textoResultado == "Você Perdeu!" ? Colors.red : Colors.black
                )
            ),
          ],
        ),
        const SizedBox(height: 30.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _mostrarTelaResultado = false;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF4242),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              minimumSize: const Size(double.infinity, 60.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              elevation: 4,
            ),
            child: const Text('Jogar novamente', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}