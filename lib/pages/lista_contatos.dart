import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:lista_contatos/componentes/custom_app_bar.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../services/cadpessoa_service.dart';

class ListaContatosPage extends StatefulWidget {
  const ListaContatosPage({super.key});

  @override
  State<ListaContatosPage> createState() => _ListaContatosPageState();
}

class _ListaContatosPageState extends State<ListaContatosPage> {
  final CadPessoaService cadPessoaService = CadPessoaService();
  List<ParseObject> _pessoas = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAllPessoas();
  }

  Future<void> _fetchAllPessoas() async {
    try {
      final pessoas = await cadPessoaService.fetchAllPessoas();
      if (mounted) {
        setState(() {
          _pessoas = pessoas;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Falha ao carregar os dados: $e'),
      ));
    }
  }

  Future<void> _deletePessoa(ParseObject pessoa) async {
    try {
      await cadPessoaService.deletePessoa(pessoa);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Usuário deletado com sucesso!'),
      ));
      _fetchAllPessoas(); // Atualiza a lista após deletar
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Falha ao deletar usuário: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Lista de Contatos"),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: _pessoas.length,
                itemBuilder: (context, index) {
                  final pessoa = _pessoas[index];
                  final telefoneController = MaskedTextController(
                      mask: '(00) 00000-0000',
                      text: pessoa.get<String>('telefone') ?? '');
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(pessoa.get<String>('nome') ?? ''),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Telefone: ${telefoneController.text}'),
                          Text('CEP: ${pessoa.get<String>('cep') ?? ''}'),
                          Text(
                              'Logradouro: ${pessoa.get<String>('logradouro') ?? ''}'),
                          Text('Número: ${pessoa.get<String>('numero') ?? ''}'),
                          Text('Bairro: ${pessoa.get<String>('bairro') ?? ''}'),
                          Text('Cidade: ${pessoa.get<String>('cidade') ?? ''}'),
                          Text('UF: ${pessoa.get<String>('uf') ?? ''}'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              // Implementar edição
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deletePessoa(pessoa);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
