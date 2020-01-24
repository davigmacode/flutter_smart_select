import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import 'package:dio/dio.dart';

class FeaturesOptionAsync extends StatefulWidget {
  @override
  _FeaturesOptionAsyncState createState() => _FeaturesOptionAsyncState();
}

class _FeaturesOptionAsyncState extends State<FeaturesOptionAsync> {

  String _user;
  List<SmartSelectOption<String>> _users = [];
  bool _usersIsLoading;

  List<String> _country;
  List<SmartSelectOption<String>> _countries = [];
  bool _countriesIsLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 7),
        SmartSelect<String>.single(
          title: 'Admin',
          value: _user,
          options: _users,
          modalConfig: SmartSelectModalConfig(useFilter: true),
          choiceType: SmartSelectChoiceType.chips,
          choiceConfig: SmartSelectChoiceConfig<String>(
            isGrouped: true,
            secondaryBuilder: (context, item) => CircleAvatar(
              backgroundImage: NetworkImage(item.meta['picture']['thumbnail']),
            ),
          ),
          builder: (context, state, showChoices) {
            return SmartSelectTile(
              title: state.title,
              value: state.valueDisplay,
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
              onTap: () => showChoices(context),
            );
          },
          onChange: (val) => setState(() => _user = val),
        ),
        Divider(indent: 20),
        SmartSelect<String>.multiple(
          title: 'Country',
          value: _country,
          isTwoLine: true,
          isLoading: _countriesIsLoading,
          options: _countries,
          modalConfig: SmartSelectModalConfig(useFilter: true),
          choiceConfig: SmartSelectChoiceConfig(isGrouped: true),
          choiceType: SmartSelectChoiceType.checkboxes,
          leading: Container(
            width: 40,
            height: 40,
            child: Icon(Icons.flag),
          ),
          onChange: (val) => setState(() => _country = val),
        ),
        Container(height: 7),
      ],
    );
  }

  @override
  initState() {
    super.initState();

    _getUsers();
    _getCountries();
  }

  void _getUsers() async {
    try {
      setState(() => _usersIsLoading = true);
      String url = "https://randomuser.me/api/?inc=gender,name,nat,picture,email&results=25";
      Response res = await Dio().get(url);
      List<SmartSelectOption> options = SmartSelectOption.listFrom<String, dynamic>(
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

  void _getCountries() async {
    try {
      setState(() => _countriesIsLoading = true);
      String url = "http://restcountries.eu/rest/v2/all?fields=name;capital;flag;region;subregion";
      Response res = await Dio().get(url);
      setState(() {
        _countries = SmartSelectOption.listFrom<String, dynamic>(
          source: res.data,
          value: (index, item) => item['subregion'] + ' - ' + item['name'],
          title: (index, item) => item['name'],
          subtitle: (index, item) => item['capital'],
          group: (index, item) => item['region'],
        );
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() => _countriesIsLoading = false);
    }
  }
}