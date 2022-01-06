import 'package:app_controle_serie/database/dao/serie_dao.dart';
import 'package:app_controle_serie/views/form.dart';
import 'package:flutter/material.dart';

import 'item_epsodio.dart';

class ListSereies extends StatefulWidget {
  const ListSereies({Key? key}) : super(key: key);

  @override
  _ListSereiesState createState() => _ListSereiesState();
}

class _ListSereiesState extends State<ListSereies> {
  final SerieDao _serieDao = SerieDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Controle de Episódios'),
      ),
      body: FutureBuilder(
        future: _serieDao.findAll(),
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ItemEpsodio(
                    snapshot.data[index],
                    onTap: () => {
                      Navigator.of(context)
                          .push(
                            MaterialPageRoute(
                                builder: (context) => FomularioSerie(
                                      serie: snapshot.data[index],
                                    )),
                          )
                          .then(
                            (value) => setState(() {}),
                          )
                    },
                    onRemove: () => {
                      _serieDao
                          .delete(snapshot.data[index].id)
                          .then((value) => setState(() {}))
                    },
                  );
                },
                itemCount: snapshot.data!.length,
              );
          }
          return const Text('Unkown error');
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        onPressed: () => {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                    builder: (context) => FomularioSerie(
                          serie: null,
                        )),
              )
              .then(
                (value) => setState(() {}),
              )
        },
      ),
    );
  }
}
