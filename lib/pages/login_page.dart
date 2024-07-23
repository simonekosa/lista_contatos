import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import './main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController(text: "");
  var senhaController = TextEditingController(text: "");
  bool esconderSenha = true;

  final Logger logger = Logger();

  @override
  void dispose() {
    emailController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 240, 218, 237),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 70,
                ),
                Row(
                  children: [
                    Expanded(child: Container()),
                    Expanded(
                      flex: 4,
                      child: Image.asset(
                        'lib/images/logo_login.png',
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                const Text(
                  'Já tem Cadastro?',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.pink),
                ),
                const Text(
                  'Faça seu login',
                  style: TextStyle(fontSize: 16, color: Colors.pinkAccent),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  height: 30,
                  alignment: Alignment.center,
                  child: TextField(
                    controller: emailController,
                    onChanged: (value) {},
                    style: const TextStyle(color: Colors.pinkAccent),
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 0),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.pinkAccent)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.pinkAccent)),
                        prefixIcon: Icon(Icons.email, color: Colors.pink),
                        hintText: "Email",
                        hintStyle:
                            TextStyle(color: Colors.pinkAccent, fontSize: 14)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  height: 30,
                  alignment: Alignment.center,
                  child: TextField(
                    controller: senhaController,
                    obscureText: esconderSenha,
                    onChanged: (value) {},
                    style: const TextStyle(color: Colors.pinkAccent),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(top: 0),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.pinkAccent)),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.pinkAccent)),
                      prefixIcon: const Icon(Icons.lock, color: Colors.pink),
                      hintText: "Senha",
                      hintStyle: const TextStyle(
                          color: Colors.pinkAccent, fontSize: 14),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            esconderSenha = !esconderSenha;
                          });
                        },
                        child: Icon(
                            esconderSenha
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.pink),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                        onPressed: () {
                          if (emailController.text ==
                                  "flutter@testedio.com.br" &&
                              senhaController.text == "senha123") {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Olá, Seja bem vindo!",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700)),
                              backgroundColor: Colors.pink,
                              shape: StadiumBorder(),
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(50),
                              elevation: 30,
                            ));

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => (const MainPage()),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Ops, usuário ou Senha inválidos!",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700)),
                              backgroundColor: Colors.pink,
                              shape: StadiumBorder(),
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(50),
                              elevation: 30,
                            ));
                          }
                          debugPrint(emailController.text);
                          debugPrint(senhaController.text);
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all(Colors.pinkAccent)),
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        )),
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  height: 30,
                  alignment: Alignment.center,
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                        color: Colors.pink, fontWeight: FontWeight.w200),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  height: 30,
                  alignment: Alignment.center,
                  child: const Text(
                    'Cadastre-se',
                    style: TextStyle(
                        color: Colors.pink, fontWeight: FontWeight.w400),
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
