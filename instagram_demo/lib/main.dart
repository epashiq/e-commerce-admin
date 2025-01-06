import 'package:flutter/material.dart';
import 'package:instagram_demo/features/app_roots/presentation/view/app_roots.dart';
import 'package:instagram_demo/features/comment/data/i_comment_facade.dart';
import 'package:instagram_demo/features/comment/presentation/provider/comment_provider.dart';
import 'package:instagram_demo/features/home/data/i_person_facade.dart';
import 'package:instagram_demo/features/home/presentation/provider/person_provider.dart';
import 'package:instagram_demo/general/di/injection.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependency();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => PersonProvider(iPersonFacade: sl<IPersonFacade>())),
        ChangeNotifierProvider(
            create: (_) =>
                CommentProvider(iCommentFacade: sl<ICommentFacade>()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const AppRoot(),
      ),
    );
  }
}
