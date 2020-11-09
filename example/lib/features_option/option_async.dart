import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import 'package:dio/dio.dart';
import 'package:async/async.dart';

class FeaturesOptionAsync extends StatefulWidget {
  @override
  _FeaturesOptionAsyncState createState() => _FeaturesOptionAsyncState();
}

class _FeaturesOptionAsyncState extends State<FeaturesOptionAsync> {

  String _user;
  List<S2Choice<String>> _users = [];
  bool _usersIsLoading;

  List<String> _countries;
  final _countriesMemoizer = AsyncMemoizer<List<S2Choice<String>>>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 7),
        SmartSelect<String>.single(
          title: 'Admin',
          value: _user,
          onChange: (state) => setState(() => _user = state.value),
          modalFilter: true,
          choiceItems: _users,
          choiceType: S2ChoiceType.chips,
          choiceGrouped: true,
          choiceStyle: S2ChoiceStyle(
            brightness: Brightness.light,
            showCheckmark: true,
            highlightColor: Theme.of(context).primaryColor.withOpacity(.4)
          ),
          choiceActiveStyle: S2ChoiceStyle(
            brightness: Brightness.dark,
            highlightColor: Theme.of(context).accentColor.withOpacity(.4)
          ),
          choiceSecondaryBuilder: (context, choice, filterText) => CircleAvatar(
            backgroundImage: NetworkImage(choice.meta['picture']['thumbnail']),
          ),
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              isTwoLine: true,
              isLoading: _usersIsLoading,
              leading: Builder(
                builder: (context) {
                  String avatarUrl = state.valueObject != null
                    ? state.valueObject.meta['picture']['thumbnail']
                    : 'https://source.unsplash.com/8I-ht65iRww/100x100';
                  return CircleAvatar(
                    backgroundImage: NetworkImage(avatarUrl),
                  );
                },
              ),
            );
          },
        ),
        const Divider(indent: 20),
        FutureBuilder<List<S2Choice<String>>>(
          initialData: [],
          future: this._countriesMemoizer.runOnce(_getCountries),
          builder: (context, snapshot) {
            return SmartSelect<String>.multiple(
              title: 'Country',
              value: _countries,
              modalFilter: true,
              choiceItems: snapshot.data,
              choiceGrouped: true,
              choiceType: S2ChoiceType.checkboxes,
              onChange: (state) => setState(() => _countries = state.value),
              tileBuilder: (context, state) {
                return S2Tile.fromState(
                  state,
                  isTwoLine: true,
                  isLoading: snapshot.connectionState == ConnectionState.waiting,
                  leading: const SizedBox(
                    width: 40,
                    height: 40,
                    child: Icon(Icons.flag),
                  ),
                );
              },
            );
          },
        ),
        const SizedBox(height: 7),
      ],
    );
  }

  @override
  initState() {
    super.initState();

    _getUsers();
  }

  void _getUsers() async {
    try {
      setState(() => _usersIsLoading = true);
      String url = "https://randomuser.me/api/?inc=gender,name,nat,picture,email&results=25";
      Response res = await Dio().get(url);
      List<S2Choice> options = S2Choice.listFrom<String, dynamic>(
        source: res.data['results'],
        value: (index, item) => item['email'],
        title: (index, item) => item['name']['first'] + ' ' + item['name']['last'],
        subtitle: (index, item) => item['email'],
        group: (index, item) => item['gender'],
        meta: (index, item) => item,
      );
      setState(() => _users = options);
    } catch (e) {
      print(e);
    } finally {
      setState(() => _usersIsLoading = false);
    }
  }

  Future<List<S2Choice<String>>> _getCountries([String query]) async {
    String endpoint = query != null ? 'name/$query' : 'all';
    String url = "http://restcountries.eu/rest/v2/$endpoint?fields=name;capital;region;subregion";
    Response res = await Dio().get(url);
    return S2Choice.listFrom<String, dynamic>(
      source: res.data,
      value: (index, item) => item['subregion'] + ' - ' + item['name'],
      title: (index, item) => item['name'],
      subtitle: (index, item) => item['capital'],
      group: (index, item) => item['region'],
    );
  }
}