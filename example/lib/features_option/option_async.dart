import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import 'package:dio/dio.dart';

class FeaturesOptionAsync extends StatefulWidget {
  @override
  _FeaturesOptionAsyncState createState() => _FeaturesOptionAsyncState();
}

class _FeaturesOptionAsyncState extends State<FeaturesOptionAsync> {

  String _user;
  List _users = [];
  bool _isLoading;

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
            value: (_item) => _item['email'],
            title: (_item) => _item['name']['first'] + ' ' + _item['name']['last'],
            subtitle: (_item) => _item['email'],
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
              isLoading: _isLoading,
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
        Container(height: 7),
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
      setState(() => _isLoading = true);
      String url = "https://randomuser.me/api/?inc=gender,name,nat,picture,email&results=25";
      Response res = await Dio().get(url);
      setState(() {
        _users = res.data['results'];
        _isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }
}