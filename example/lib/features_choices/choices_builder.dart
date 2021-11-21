import 'package:awesome_select/awesome_select.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../choices.dart' as choices;

class FeaturesChoicesBuilder extends StatefulWidget {
  @override
  _FeaturesChoicesBuilderState createState() => _FeaturesChoicesBuilderState();
}

class _FeaturesChoicesBuilderState extends State<FeaturesChoicesBuilder> {
  int? _commute;

  List<String>? _user;
  List<S2Choice<String>> _users = [];
  bool _usersIsLoading = false;

  ThemeData get theme => Theme.of(context);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 7),
        SmartSelect<int?>.single(
          title: 'Transportation',
          placeholder: 'Choose one',
          selectedValue: _commute,
          onChange: (selected) => setState(() => _commute = selected.value),
          modalType: S2ModalType.bottomSheet,
          modalHeader: false,
          choiceItems: S2Choice.listFrom<int, Map<String, String>>(
            source: choices.transports,
            value: (index, item) => index,
            title: (index, item) => item['title'] ?? '',
            subtitle: (index, item) => item['subtitle'] ?? '',
            meta: (index, item) => item,
          ),
          choiceLayout: S2ChoiceLayout.wrap,
          choiceDirection: Axis.horizontal,
          choiceBuilder: (context, state, choice) {
            return Card(
              margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              color: choice.selected ? theme.primaryColor : theme.cardColor,
              child: InkWell(
                onTap: () => choice.select?.call(true),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(choice.meta['image']),
                          child: choice.selected
                              ? Icon(
                                  Icons.check,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          choice.title ?? '',
                          style: TextStyle(
                            color: choice.selected ? Colors.white : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          tileBuilder: (context, state) {
            String avatar = (state.selected?.choice?.meta ?? {})['image'] ??
                'https://source.unsplash.com/3k5cAmxjXl4/100x100';
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
          title: 'Passengers',
          selectedValue: _user,
          onChange: (selected) => setState(() => _user = selected?.value),
          modalFilter: true,
          choiceItems: _users,
          choiceGrouped: true,
          choiceLayout: S2ChoiceLayout.grid,
          choiceGrid: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            crossAxisCount: 3,
          ),
          choiceBuilder: (context, state, choice) {
            return Card(
              color: choice.selected ? theme.primaryColor : theme.cardColor,
              child: InkWell(
                onTap: () => choice.select?.call(!choice.selected),
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
                          backgroundImage: NetworkImage(
                            choice.meta['picture']['thumbnail'],
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        choice.title ?? '',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: choice.selected ? Colors.white : null,
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
              isLoading: _usersIsLoading,
              hideValue: true,
              leading: CircleAvatar(
                backgroundColor: theme.primaryColor,
                child: Text(
                  state.selected?.value?.length.toString() ?? '0',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              body: S2TileChips(
                chipLength: state.selected?.length ?? 0,
                chipLabelBuilder: (context, i) {
                  return Text(state.selected?.choice?[i].title ?? '');
                },
                chipAvatarBuilder: (context, i) => CircleAvatar(
                  backgroundImage: NetworkImage(
                    state.selected?.choice?[i].meta['picture']['thumbnail'],
                  ),
                ),
                chipOnDelete: (i) {
                  setState(
                      () => _user?.remove(state.selected?.choice?[i].value));
                },
                chipColor: Theme.of(context).primaryColor,
                chipRaised: true,
                placeholder: Container(),
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
      String url =
          "https://randomuser.me/api/?inc=gender,name,nat,picture,email&results=25";
      Response res = await Dio().get(url);
      setState(() {
        _users = S2Choice.listFrom<String, dynamic>(
          source: res.data['results'],
          value: (index, item) => item['email'],
          title: (index, item) =>
              item['name']['first'] + ' ' + item['name']['last'],
          subtitle: (index, item) => item['email'],
          group: (index, item) => item['gender'],
          meta: (index, item) => item,
        );
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() => _usersIsLoading = false);
    }
  }
}
