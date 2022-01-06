import 'package:app_controle_serie/database/dao/serie_dao.dart';
import 'package:app_controle_serie/models/serie.dart';
import 'package:flutter/material.dart';

class ItemEpsodio extends StatelessWidget {
  final Serie _serie;
  final Function onTap;
  final Function onRemove;
  final SerieDao _serieDao = SerieDao();

  ItemEpsodio(this._serie, {required this.onTap, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.movie),
        trailing: PopupMenuButton(
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: Row(
                  children: const [
                    Icon(Icons.edit),
                    SizedBox(width: 5),
                    Text("Editar")
                  ],
                ),
                value: 1,
              ),
              PopupMenuItem(
                child: Row(
                  children: const [
                    Icon(Icons.remove_circle),
                    SizedBox(width: 5),
                    Text("Remover")
                  ],
                ),
                value: 2,
              ),
            ];
          },
          onSelected: (int select) {
            if (select == 1) {
              onTap();
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text("Deseja Remover Série?"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancela'),
                    ),
                    TextButton(
                      onPressed: () {
                        onRemove();
                        Navigator.pop(context, 'ok');
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            }
          },
        ),
        title: Text(_serie.nome.toString()),
        subtitle: Text(
            "Temp.: ${_serie.numero_temporada} Ep.: ${_serie.numero_epsodio}"),
        onTap: () => onTap(),
      ),
    );
  }
}
