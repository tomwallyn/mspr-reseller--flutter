import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mspr/core/providers/global_provider_binding.dart';
import 'package:mspr/core/widgets/loading_indicator_widget.dart';
import 'package:mspr/core/widgets/loading_widget.dart';
import 'package:mspr/core/widgets/qr_reader_widget.dart';
import 'package:mspr/modules/authentication/authentication_binding.dart';
import 'package:mspr/modules/home/presentation/home_page.dart';

class AuthenticationPage extends HookConsumerWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _usernameController =
        useTextEditingController();
    final TextEditingController _passwordController =
        useTextEditingController();

    ref.listen(authenticationControllerProvider, (_, next) {
      next.when(
          data: (data) {
            ref.read(userProvider.notifier).setAuthUser(data!);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          loading: () => const LoadingIndicatorWidget(),
          error: (Object error, StackTrace? stackTrace) {
            showDialog<void>(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Erreur'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: const <Widget>[
                        Text('Utilisateur ou mot de passe incorrect.'),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Fermer'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          });
    });

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/graphic/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(),
            Container(
              padding: const EdgeInsets.only(left: 35, top: 130),
              child: Text(
                ref.read(environmentConfigServiceProvider).backendApiKey ??
                    "Test",
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextField(
                            style: const TextStyle(color: Colors.black),
                            controller: _usernameController,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Nom d'utilisateur",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextField(
                            style: TextStyle(),
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Mot de passe",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Connexion',
                                style: TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.w700),
                              ),
                              IconButton(
                                  color: Colors.black38,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              QrReaderWidget()),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.qr_code_scanner_sharp,
                                  )),
                              ref
                                  .watch(authenticationControllerProvider)
                                  .maybeMap(
                                    loading: (loading) => const LoadingWidget(),
                                    orElse: () => CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Color(0xff4c505b),
                                      child: IconButton(
                                          color: Colors.white,
                                          onPressed: () async {
                                            ref
                                                .read(
                                                    authenticationControllerProvider
                                                        .notifier)
                                                .checkUser(
                                                    username:
                                                        _usernameController
                                                            .text,
                                                    password:
                                                        _passwordController
                                                            .text);
                                          },
                                          icon: const Icon(
                                            Icons.arrow_forward,
                                          )),
                                    ),
                                  )
                              // CircleAvatar(
                              //   radius: 30,
                              //   backgroundColor: Color(0xff4c505b),
                              //   child: IconButton(
                              //       color: Colors.white,
                              //       onPressed: () async {
                              //         ref.read(authenticationControllerProvider.notifier).checkUser(
                              //             username: _usernameController.text, password: _passwordController.text);
                              //       },
                              //       icon: const Icon(
                              //         Icons.arrow_forward,
                              //       )),
                              // ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
