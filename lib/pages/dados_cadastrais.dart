import 'package:flutter/material.dart';
import 'package:lista_contatos/componentes/custom_app_bar.dart';
import 'package:lista_contatos/componentes/custom_text.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../repositories/via_cep_repository.dart';
import '../services/via_cep_service.dart';
import '../services/cadpessoa_service.dart';

class DadosCadastraisPage extends StatefulWidget {
  const DadosCadastraisPage({super.key});

  @override
  State<DadosCadastraisPage> createState() => _DadosCadastraisPageState();
}

class _DadosCadastraisPageState extends State<DadosCadastraisPage> {
  final ViaCepService viaCepService = ViaCepService();
  final CepService cepService = CepService();
  final CadPessoaService cadPessoaService = CadPessoaService();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _logradouroController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _localidadeController = TextEditingController();
  final TextEditingController _ufController = TextEditingController();

  List<ParseObject> _ceps = [];

  @override
  void initState() {
    super.initState();
    _fetchAllCeps();
  }

  Future<void> _fetchAllCeps() async {
    final ceps = await cepService.fetchAllCeps();
    if (mounted) {
      setState(() {
        _ceps = ceps;
      });
    }
  }

  Future<void> _addCep(String cep) async {
    final cepData = await viaCepService.fetchCep(cep);
    if (cepData != null && cepData['cep'] != null) {
      if (mounted) {
        setState(() {
          _logradouroController.text = cepData['logradouro'] as String;
          _bairroController.text = cepData['bairro'] as String;
          _localidadeController.text = cepData['localidade'] as String;
          _ufController.text = cepData['uf'] as String;
        });
      }

      final existingCep = await cepService.fetchCep(cepData['cep'] as String);
      if (existingCep == null) {
        await cepService.addCep({
          'cep': cepData['cep'] as String,
          'logradouro': cepData['logradouro'] as String,
          'bairro': cepData['bairro'] as String,
          'localidade': cepData['localidade'] as String,
          'uf': cepData['uf'] as String,
        });
        if (mounted) {
          _fetchAllCeps();
        }
      } else {
        // CEP já cadastrado
      }
    } else {
      // CEP não encontrado
      if (mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('CEP não encontrado'),
              content: const Text('O CEP informado não foi encontrado.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  Future<void> _savePessoa() async {
    final pessoaData = {
      'nome': _nomeController.text,
      'telefone': _telefoneController.text,
      'cep': _cepController.text,
      'logradouro': _logradouroController.text,
      'numero': _numeroController.text,
      'bairro': _bairroController.text,
      'cidade': _localidadeController.text,
      'uf': _ufController.text,
    };

    try {
      await cadPessoaService.addPessoa(pessoaData);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Dados salvos com sucesso!'),
      ));
      _clearFields();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Falha ao salvar dados: $e'),
      ));
    }
  }

  void _clearFields() {
    _nomeController.clear();
    _telefoneController.clear();
    _cepController.clear();
    _logradouroController.clear();
    _numeroController.clear();
    _bairroController.clear();
    _localidadeController.clear();
    _ufController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Dados Cadastrais"),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ListView(
          children: [
            const TextLabel(texto: "Nome"),
            TextField(controller: _nomeController),
            const TextLabel(texto: "Telefone"),
            TextField(controller: _telefoneController),
            const TextLabel(texto: "CEP"),
            TextField(
              controller: _cepController,
              onSubmitted: (value) {
                _addCep(value);
              },
            ),
            const TextLabel(texto: "Logradouro"),
            TextField(controller: _logradouroController),
            const TextLabel(texto: "Numero"),
            TextField(controller: _numeroController),
            const TextLabel(texto: "Bairro"),
            TextField(controller: _bairroController),
            const TextLabel(texto: "Cidade"),
            TextField(controller: _localidadeController),
            const TextLabel(texto: "UF"),
            TextField(controller: _ufController),
            const SizedBox(
                height: 20), // Adiciona um espaçamento antes do botão
            Center(
              child: TextButton(
                onPressed: _savePessoa,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  minimumSize: const Size(50, 50),
                  padding: const EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
