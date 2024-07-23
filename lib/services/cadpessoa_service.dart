import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class CadPessoaService {
  Future<void> addPessoa(Map<String, dynamic> data) async {
    final pessoaObject = ParseObject('cadpessoa')
      ..set('nome', data['nome'] as String)
      ..set('telefone', data['telefone'] as String)
      ..set('cep', data['cep'] as String)
      ..set('logradouro', data['logradouro'] as String)
      ..set('numero', data['numero'] as String)
      ..set('bairro', data['bairro'] as String)
      ..set('cidade', data['cidade'] as String)
      ..set('uf', data['uf'] as String);

    final response = await pessoaObject.save();

    if (!response.success) {
      throw Exception('Failed to add pessoa');
    }
  }

  Future<List<ParseObject>> fetchAllPessoas() async {
    final query = QueryBuilder<ParseObject>(ParseObject('cadpessoa'));
    final response = await query.query();

    if (response.success && response.results != null) {
      return response.results as List<ParseObject>;
    } else {
      return [];
    }
  }

  Future<void> deletePessoa(ParseObject pessoaObject) async {
    final response = await pessoaObject.delete();
    if (!response.success) {
      throw Exception('Failed to delete pessoa');
    }
  }
}
