import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import 'package:dio/dio.dart';
import '../options.dart' as options;

class FeaturesChoicesBuilder extends StatefulWidget {
  @override
  _FeaturesChoicesBuilderState createState() => _FeaturesChoicesBuilderState();
}

class _FeaturesChoicesBuilderState extends State<FeaturesChoicesBuilder> {

  int _commute;

  List<String> _user;
  List<S2Option<String>> _users = [];
  bool _usersIsLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 7),
        SmartSelect<int>.single(
          title: 'Commuter',
          placeholder: 'Choose one',
          value: _commute,
          options: S2Option.listFrom<int, Map<String, dynamic>>(
            source: options.transports,
            value: (index, item) => index,
            title: (index, item) => item['title'],
            subtitle: (index, item) => item['subtitle'],
            meta: (index, item) => item,
          ),
          onChange: (state) => setState(() => _commute = state.value),
          modalType: S2ModalType.bottomSheet,
          modalHeader: false,
          choiceLayout: S2ChoiceLayout.wrap,
          choiceDirection: Axis.horizontal,
          choiceBuilder: (context, choice, query) {
            return Card(
              margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              color: choice.selected ? Colors.blue : Colors.white,
              child: InkWell(
                onTap: () => choice.select(true),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(choice.data.meta['image']),
                          child: choice.selected ? Icon(
                            Icons.check,
                            color: Colors.white,
                          ) : null,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          choice.data.title,
                          style: TextStyle(
                            color: choice.selected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );

            // return ListTile(
            //   title: Text(choice.data.title),
            //   subtitle: Text(choice.data.subtitle),
            //   onTap: () => choice.select(true),
            //   leading: CircleAvatar(
            //     backgroundImage: NetworkImage(choice.data.meta['image']),
            //     child: choice.selected ? Icon(
            //       Icons.check,
            //       color: Colors.white,
            //     ) : null,
            //   ),
            // );
          },
          tileBuilder: (context, state) {
            String avatar = (state.valueObject?.meta ?? {})['image'] ?? 'https://source.unsplash.com/yeVtxxPxzbw/100x100';
            return S2Tile.fromState(
              state,
              isTwoLine: true,
              leading: CircleAvatar(
                backgroundImage: NetworkImage(avatar),
              ),
            );
          },
        ),
        const Divider(indent: 20),
        SmartSelect<String>.multiple(
          title: 'Admin',
          value: _user,
          options: _users,
          onChange: (state) => setState(() => _user = state.value),
          modalFilter: true,
          choiceGrouped: true,
          choiceLayout: S2ChoiceLayout.grid,
          choiceGrid: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            crossAxisCount: 3
          ),
          choiceBuilder: (context, choice, query) {
            return Card(
              color: choice.selected ? Colors.green : Colors.white,
              child: InkWell(
                onTap: () => choice.select(!choice.selected),
                child: Container(
                  padding: const EdgeInsets.all(7),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(choice.data.meta['picture']['thumbnail']),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        choice.data.title,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: choice.selected ? Colors.white : Colors.black87,
                          height: 1,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              isTwoLine: true,
              isLoading: _usersIsLoading,
              leading: const CircleAvatar(
                backgroundImage: NetworkImage('https://source.unsplash.com/8I-ht65iRww/100x100'),
              ),
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
      setState(() => _users = S2Option.listFrom<String, dynamic>(
        source: res.data['results'],
        value: (index, item) => item['email'],
        title: (index, item) => item['name']['first'] + ' ' + item['name']['last'],
        subtitle: (index, item) => item['email'],
        group: (index, item) => item['gender'],
        meta: (index, item) => item,
      ));
    } catch (e) {
      print(e);
    } finally {
      setState(() => _usersIsLoading = false);
    }
  }
}