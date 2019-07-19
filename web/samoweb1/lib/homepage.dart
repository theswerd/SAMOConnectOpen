import 'package:flutter_web/material.dart';


class homePage extends StatelessWidget {
  static Color baseColor = Colors.indigoAccent[700];

  @override
  Widget build(BuildContext context) {
    
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text("SAMO Connect"),
        backgroundColor: baseColor,
        actions: <Widget>[
          Icon(Icons.info_outline)
        ],
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                color: baseColor,
              ),
            ],
          ),
          Center(
            child: Card(
              elevation: 2.0,
              child: Container(
                padding: EdgeInsets.all(42),
                width: MediaQuery.of(context).size.width / 2.5,
                height: MediaQuery.of(context).size.height / 1.5,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 62.0),
                    Center(
                        child: Text(
                      "Admin Material",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    SizedBox(height: 48.0),
                    TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.white
                      ),
                      ),
                    SizedBox(height: 8.0),
                    TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.white
                      ),
                      ),
                    SizedBox(height: 24.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: false,
                              onChanged: (value) {
                                
                              },
                            ),
                            Text("Remember Me")
                          ],
                        ), 
                        Text("Forgot?"),
                      ],
                    ),
                    SizedBox(height: 18.0),
                    RaisedButton(
                      child: Text("Login"),
                      onPressed: (){

                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
