import 'package:flutter/material.dart';
import './features_single/single_main.dart';
import './features_multi/multi_main.dart';
import './features_tile/tile_main.dart';
import './features_option/option_main.dart';

class Features extends StatefulWidget {
  @override
  _FeaturesState createState() => _FeaturesState();
}

class _FeaturesState extends State<Features> with AutomaticKeepAliveClientMixin<Features> {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Smart Select Example'),
          bottom: TabBar(
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(text: 'Single Choice'),
              Tab(text: 'Multiple Choice'),
              Tab(text: 'Customize Tile'),
              Tab(text: 'Customize Option'),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.help_outline),
              onPressed: () => _about(),
            )
          ],
        ),
        body: TabBarView(
          children: [
            FeaturesSingle(),
            FeaturesMulti(),
            FeaturesTile(),
            FeaturesOption(),
          ],
        ),
      ),
    );
  }

  void _about() {
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
              subtitle: Text('version 1.0.1'),
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