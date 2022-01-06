import 'package:app_controle_serie/database/dao/serie_dao.dart';
import 'package:app_controle_serie/models/serie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FomularioSerie extends StatefulWidget {
  final Serie? serie;

  FomularioSerie({Key? key, required this.serie}) : super(key: key);

  @override
  _FomularioSerieState createState() => _FomularioSerieState();
}

class _FomularioSerieState extends State<FomularioSerie> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerSerie = TextEditingController();
  final TextEditingController _controllerTemporada = TextEditingController();
  final TextEditingController _controllerEpsodio = TextEditingController();
  final SerieDao _serieDao = SerieDao();

  @override
  Widget build(BuildContext context) {
    final bool novo = widget.serie == null;
    if (!novo) {
      PreencherDados(widget.serie);
    }
    return Scaffold(
      appBar: AppBar(title: Text(novo ? 'Nova Serie' : 'Editar Serie')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) return 'Campo Série/Anime obrigatório!';
                  return null;
                },
                controller: _controllerSerie,
                decoration: const InputDecoration(
                  labelText: "Série/Anime",
                  hintText: 'Ex.: Naruto',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) return 'Campo Temporada obrigatório!';
                  return null;
                },
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                controller: _controllerTemporada,
                decoration: const InputDecoration(
                  labelText: "Temporada",
                  hintText: 'Ex.: 1',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) return 'Campo Episódio obrigatório!';
                  return null;
                },
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                controller: _controllerEpsodio,
                decoration: const InputDecoration(
                  labelText: "Episódio",
                  hintText: 'Ex.: 55',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final String nome = _controllerSerie.text;
                    final int numero_epsodio =
                        int.parse(_controllerEpsodio.text);
                    final int numero_temporada =
                        int.parse(_controllerEpsodio.text);
                    await _setDados(
                        novo, nome, numero_epsodio, numero_temporada);
                    Navigator.pop(context);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(Icons.done),
                    Text('Salvar'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _setDados(
      bool novo, String nome, int numero_epsodio, int numero_temporada) async {
    final Serie obj = Serie(
        novo ? 0 : widget.serie!.id, nome, numero_epsodio, numero_temporada);
    if (novo) {
      await _serieDao.save(obj);
    } else {
      await _serieDao.update(obj);
    }
  }

  void PreencherDados(Serie? serie) {
    _controllerSerie.text = serie!.nome;
    _controllerTemporada.text = serie.numero_temporada.toString();
    _controllerEpsodio.text = serie.numero_epsodio.toString();
  }
}
