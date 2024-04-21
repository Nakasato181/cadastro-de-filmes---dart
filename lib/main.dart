//Alunos João Pedro Nakasato e Lucas Martins
import 'package:flutter/material.dart';

void main() {
  runApp(CadastroFilmesApp());
}

class Filme {
  final String titulo;
  final String diretor;
  final int ano;
  final String genero;
  final String sinopse;
  final String classificacao;
  final String imagemUrl;

  Filme({
    required this.titulo,
    required this.diretor,
    required this.ano,
    required this.genero,
    required this.sinopse,
    required this.classificacao,
    required this.imagemUrl,
  });
}

class CadastroFilmesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cadastro de Filmes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue, // background
            onPrimary: Colors.white, // foreground
          ),
        ),
      ),
      home: CadastroFilmesScreen(),
    );
  }
}

class CadastroFilmesScreen extends StatefulWidget {
  @override
  _CadastroFilmesScreenState createState() => _CadastroFilmesScreenState();
}

class _CadastroFilmesScreenState extends State<CadastroFilmesScreen> {
  final List<Filme> _filmes = [];

  @override
  void initState() {
    super.initState();
    _adicionarFilmesExemplo();
  }

  void _adicionarFilmesExemplo() {
    Filme filme1 = Filme(
      titulo: "Titanic",
      diretor: "James Cameron",
      ano: 1997,
      genero: "Romance",
      sinopse: "Uma história de amor épica...",
      classificacao: "PG-13",
      imagemUrl: "https://imgs.search.brave.com/7Q1B2IpXOcwBQvesRj3WDpcSgahCZXWxJYfKO7Lxwfo/rs:fit:500:0:0/g:ce/aHR0cHM6Ly91cGxv/YWQud2lraW1lZGlh/Lm9yZy93aWtpcGVk/aWEvY29tbW9ucy90/aHVtYi9mL2ZkL1JN/U19UaXRhbmljXzMu/anBnLzUxMnB4LVJN/U19UaXRhbmljXzMu/anBn",
    );

    Filme filme2 = Filme(
      titulo: "O Poderoso Chefão",
      diretor: "Francis Ford Coppola",
      ano: 1972,
      genero: "Crime",
      sinopse: "A saga da família mafiosa...",
      classificacao: "R",
      imagemUrl: "https://imgs.search.brave.com/4gY0DAluGKvXS5dXZUe-QVJdVeSswSP0HDF3KLT-f1U/rs:fit:500:0:0/g:ce/aHR0cHM6Ly91cGxv/YWQud2lraW1lZGlh/Lm9yZy93aWtpcGVk/aWEvY29tbW9ucy90/aHVtYi9hL2FkL1Ro/ZV9Hb2RmYXRoZXJf/bG9nby5zdmcvMjIw/cHgtVGhlX0dvZGZh/dGhlcl9sb2dvLnN2/Zy5wbmc",
    );

    Filme filme3 = Filme(
      titulo: "Interestelar",
      diretor: "Christopher Nolan",
      ano: 2014,
      genero: "Ficção Científica",
      sinopse: "Uma equipe de exploradores viaja através de um buraco de minhoca no espaço...",
      classificacao: "PG-13",
      imagemUrl: "https://imgs.search.brave.com/nnoAYQazukzbZlZf82eINx6OVTNHv-j3ceXemoKtI_A/rs:fit:500:0:0/g:ce/aHR0cHM6Ly91cGxv/YWQud2lraW1lZGlh/Lm9yZy93aWtpcGVk/aWEvcHQvdGh1bWIv/My8zYS9JbnRlcnN0/ZWxsYXJfRmlsbWUu/cG5nLzUxMnB4LUlu/dGVyc3RlbGxhcl9G/aWxtZS5wbmc",
    );

    setState(() {
      _filmes.addAll([filme1, filme2, filme3]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Filmes'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _filmes.length,
              itemBuilder: (context, index) {
                final filme = _filmes[index];
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    leading: Image.network(
                      filme.imagemUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(filme.titulo),
                    subtitle: Text(filme.diretor),
                    onTap: () => _mostrarDetalhesFilme(context, filme),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => _adicionarFilme(context),
              child: Text('Adicionar Filme'),
            ),
          ),
        ],
      ),
    );
  }

  void _adicionarFilme(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AdicionarFilmeScreen()),
    );
    if (result != null) {
      setState(() {
        _filmes.add(result as Filme);
      });
    }
  }

  void _mostrarDetalhesFilme(BuildContext context, Filme filme) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Detalhes do Filme'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                filme.imagemUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              Text('Título: ${filme.titulo}'),
              Text('Diretor: ${filme.diretor}'),
              Text('Ano: ${filme.ano}'),
              Text('Gênero: ${filme.genero}'),
              Text('Sinopse: ${filme.sinopse}'),
              Text('Classificação: ${filme.classificacao}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Fechar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _excluirFilme(context, filme);
              },
              child: Text('Excluir'),
            ),
            TextButton(
              onPressed: () => _editarFilme(context, filme),
              child: Text('Editar'),
            ),
          ],
        );
      },
    );
  }

  void _editarFilme(BuildContext context, Filme filme) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditarFilmeScreen(filme: filme)),
    );
    if (result != null) {
      setState(() {
        _filmes[_filmes.indexOf(filme)] = result as Filme;
      });
    }
  }

  void _excluirFilme(BuildContext context, Filme filme) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Excluir Filme'),
          content: Text('Tem certeza de que deseja excluir este filme?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _filmes.remove(filme);
                });
                Navigator.pop(context);
              },
              child: Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }
}

class AdicionarFilmeScreen extends StatelessWidget {
  final _tituloController = TextEditingController();
  final _diretorController = TextEditingController();
  final _anoController = TextEditingController();
  final _generoController = TextEditingController();
  final _sinopseController = TextEditingController();
  final _classificacaoController = TextEditingController();
  final _imagemUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Filme'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _tituloController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _diretorController,
              decoration: InputDecoration(labelText: 'Diretor'),
            ),
            TextField(
              controller: _anoController,
              decoration: InputDecoration(labelText: 'Ano'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _generoController,
              decoration: InputDecoration(labelText: 'Gênero'),
            ),
            TextField(
              controller: _sinopseController,
              decoration: InputDecoration(labelText: 'Sinopse'),
              maxLines: 3,
            ),
            TextField(
              controller: _classificacaoController,
              decoration: InputDecoration(labelText: 'Classificação'),
            ),
            TextField(
              controller: _imagemUrlController,
              decoration: InputDecoration(labelText: 'URL da Imagem'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final filme = Filme(
                  titulo: _tituloController.text,
                  diretor: _diretorController.text,
                  ano: int.tryParse(_anoController.text) ?? 0,
                  genero: _generoController.text,
                  sinopse: _sinopseController.text,
                  classificacao: _classificacaoController.text,
                  imagemUrl: _imagemUrlController.text,
                );
                Navigator.pop(context, filme);
              },
              child: Text('Adicionar'),
            ),
          ],
        ),
      ),
    );
  }
}

class EditarFilmeScreen extends StatefulWidget {
  final Filme filme;

  EditarFilmeScreen({required this.filme});

  @override
  _EditarFilmeScreenState createState() => _EditarFilmeScreenState();
}

class _EditarFilmeScreenState extends State<EditarFilmeScreen> {
  late TextEditingController _tituloController;
  late TextEditingController _diretorController;
  late TextEditingController _anoController;
  late TextEditingController _generoController;
  late TextEditingController _sinopseController;
  late TextEditingController _classificacaoController;
  late TextEditingController _imagemUrlController;

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(text: widget.filme.titulo);
    _diretorController = TextEditingController(text: widget.filme.diretor);
    _anoController = TextEditingController(text: widget.filme.ano.toString());
    _generoController = TextEditingController(text: widget.filme.genero);
    _sinopseController = TextEditingController(text: widget.filme.sinopse);
    _classificacaoController = TextEditingController(text: widget.filme.classificacao);
    _imagemUrlController = TextEditingController(text: widget.filme.imagemUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Filme'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _tituloController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _diretorController,
              decoration: InputDecoration(labelText: 'Diretor'),
            ),
            TextField(
              controller: _anoController,
              decoration: InputDecoration(labelText: 'Ano'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _generoController,
              decoration: InputDecoration(labelText: 'Gênero'),
            ),
            TextField(
              controller: _sinopseController,
              decoration: InputDecoration(labelText: 'Sinopse'),
              maxLines: 3,
            ),
            TextField(
              controller: _classificacaoController,
              decoration: InputDecoration(labelText: 'Classificação'),
            ),
            TextField(
              controller: _imagemUrlController,
              decoration: InputDecoration(labelText: 'URL da Imagem'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final filme = Filme(
                  titulo: _tituloController.text,
                  diretor: _diretorController.text,
                  ano: int.tryParse(_anoController.text) ?? 0,
                  genero: _generoController.text,
                  sinopse: _sinopseController.text,
                  classificacao: _classificacaoController.text,
                  imagemUrl: _imagemUrlController.text,
                );
                Navigator.pop(context, filme);
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
