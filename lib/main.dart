import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app/config/firebase_configuration/firebase_config.dart';
import 'app/config/injection/di.dart';
import 'app/feature/home/domain/entities/scraped_article_entity.dart';
import 'app/newspaper_app.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseConfig.initialize();
  await dotenv.load(fileName: ".env");
  await Hive.initFlutter();
  Hive.registerAdapter(ScrapedArticleEntityAdapter());
  await setupLocator();
  runApp(const NewspaperApp());

}