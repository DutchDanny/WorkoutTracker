import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutSettingsWidget extends StatefulWidget {
  AboutSettingsWidget({Key? key}) : super(key: key);

  @override
  State createState() => _AboutSettingsState();
}
class _AboutSettingsState extends State<AboutSettingsWidget> {

  @override
  void initState() {
    super.initState();
  }

  void openLicense(){

  }

  Widget linkedUrl(String caption, String url){
    return Container(
      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
      child:GestureDetector(
        child: Text(
            caption,
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue
            )
        ),
        onTap: () async {
          if (await canLaunch(url)) launch(url);
        },
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                snap: false,
                floating: false,
                backgroundColor: Color.fromRGBO(0, 0, 0, 0.05),
                expandedHeight: 100.0,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(AppLocalizations.of(context)!.settings_about),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                    [
                      Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Text(AppLocalizations.of(context)!.settings_developer_info,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey
                            ),
                          )
                      ),
                      Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                          margin: EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Row(
                                    children: <Widget>[
                                      Text(AppLocalizations.of(context)!.name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey
                                        ),
                                      ),
                                      Spacer(),
                                      Text("Daniel Choi",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey
                                        ),
                                      ),
                                    ]
                                ),
                              ),
                              ListTile(
                                title: Row(
                                    children: <Widget>[
                                      Text(AppLocalizations.of(context)!.contact,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey
                                        ),
                                      ),
                                      Spacer(),
                                      Text("jerichoi224@gmail.com",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey
                                        ),
                                      ),
                                    ]
                                ),
                              )
                            ],
                          )
                      ),
                      Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Text(AppLocalizations.of(context)!.credits,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey
                            ),
                          )
                      ),
                      Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                          margin: EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                  alignment: Alignment.centerLeft,
                                  child: Text(AppLocalizations.of(context)!.image,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey
                                    ),
                                  )
                              ),
                              ListTile(
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      linkedUrl("Languages icons created by Freepik - Flaticon", 'https://www.flaticon.com/free-icons/languages'),
                                      linkedUrl("Gym icons created by Freepik - Flaticon", 'https://www.flaticon.com/free-icons/gym'),
                                    ],
                                  )
                              ),
                            ],
                          )
                      ),
                      Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Text(AppLocalizations.of(context)!.license,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey
                            ),
                          )
                      ),
                      Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                          margin: EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              InkWell(
                                borderRadius: BorderRadius.circular(8.0),
                                onTap: (){
                                  openLicense();
                                },
                                child: ListTile(
                                    title: new Row(
                                      children: <Widget>[
                                        new Text(AppLocalizations.of(context)!.settings_about_open_license),
                                      ],
                                    )
                                ),
                              ),
                            ],
                          )
                      ),
                    ]),
              ),
            ],
          ),
        )
    );
  }
}