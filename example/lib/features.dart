import 'package:flutter/material.dart';
import './features_single/single_main.dart';
import './features_multi/multi_main.dart';
import './features_tile/tile_main.dart';
import './features_option/option_main.dart';
import './features_modal/modal_main.dart';
import './features_choices/choices_main.dart';

class Features extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Smart Select'),
          bottom: TabBar(
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(text: 'Single Choice'),
              Tab(text: 'Multiple Choice'),
              Tab(text: 'Customize Tile'),
              Tab(text: 'Customize Option'),
              Tab(text: 'Customize Modal'),
              Tab(text: 'Customize Choices'),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.help_outline),
              onPressed: () => _about(context),
            )
          ],
        ),
        body: TabBarView(
          children: [
            FeaturesSingle(),
            FeaturesMulti(),
            FeaturesTile(),
            FeaturesOption(),
            FeaturesModal(),
            FeaturesChoices(),
          ],
        ),
      ),
    );
  }

  void _about(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(
                'smart_select',
                style: Theme.of(context).textTheme.headline.merge(TextStyle(color: Colors.black87)),
              ),
              subtitle: Text('by davigmacode'),
              trailing: IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Smart select allows you to easily convert your usual form selects to dynamic pages with grouped radio or checkbox inputs. This widget is inspired by Smart Select component from Framework7',
                      style: Theme.of(context).textTheme.body1.merge(TextStyle(color: Colors.black54)),
                    ),
                    Container(height: 15),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}