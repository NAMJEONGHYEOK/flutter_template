import 'package:flutter/material.dart';
import 'package:flutter_application_template/src/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  HomeWidgetState createState() => HomeWidgetState();
}

class HomeWidgetState extends State<HomeWidget> {
  String? _accessToken;
  String? _refreshToken;

  @override
  void initState() {
    super.initState();
    _loadTokens();
  }

  Future<void> _loadTokens() async {
    _accessToken = await context.read<AuthProvider>().getaccessToken();
    _refreshToken = await context.read<AuthProvider>().getRefreshToken();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Token Values"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Access Token: ${_accessToken ?? 'N/A'}"),
            Text("Refresh Token: ${_refreshToken ?? 'N/A'}"),
            ElevatedButton(
                onPressed: () async {
                  // if (await context
                  //         .read<AuthProvider>()
                  //         .logout(_refreshToken!) ==
                  //     true)

                  print(await context
                      .read<AuthProvider>()
                      .logout(_refreshToken!));

                  {
                    Navigator.pushNamed(context, 'login');
                  }
                  ;
                },
                child: Text("로그아웃"))
          ],
        ),
      ),
    );
  }
}
