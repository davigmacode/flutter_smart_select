import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeaturesOptionAsync extends StatefulWidget {
  @override
  _FeaturesOptionAsyncState createState() => _FeaturesOptionAsyncState();
}

class _FeaturesOptionAsyncState extends State<FeaturesOptionAsync> {

  String _user;
  List _users = [];
  bool _usersIsLoading;

  List _country;
  List _countries = [];
  bool _countriesIsLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 7),
        SmartSelect(
          title: 'Admin',
          value: _user,
          option: SmartSelectOptionConfig(
            _users,
            value: (data) => data['email'],
            title: (data) => data['name']['first'] + ' ' + data['name']['last'],
            subtitle: (data) => data['email'],
            groupBy: 'gender',
          ),
          modal: SmartSelectModalConfig(useFilter: true),
          choice: SmartSelectChoiceConfig(
            type: SmartSelectChoiceType.chips,
            secondaryBuilder: (context, item) => CircleAvatar(
              backgroundImage: NetworkImage(item.data['picture']['thumbnail']),
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
                    ? state.valueObject.data['picture']['thumbnail']
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
        SmartSelect(
          title: 'Country',
          value: _country,
          isTwoLine: true,
          isMultiChoice: true,
          option: SmartSelectOptionConfig(
            _countries,
            value: (data) => data['subregion'] + ' - ' + data['name'],
            title: (data) => data['name'],
            subtitle: ['capital'],
            groupBy: 'region',
          ),
          modal: SmartSelectModalConfig(useFilter: true),
          choice: SmartSelectChoiceConfig(
            type: SmartSelectChoiceType.checkboxes,
          ),
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
      setState(() =>_users = res.data['results'].cast<Map>());
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
      setState(() => _countries = res.data.cast<Map>());
    } catch (e) {
      print(e);
    } finally {
      setState(() => _countriesIsLoading = false);
    }
  }
}