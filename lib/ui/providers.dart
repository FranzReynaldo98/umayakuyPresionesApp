import 'package:app/ui/provider_sesion.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
class Providers {
  static List<SingleChildWidget> providers(var globalKey) {
    return [
      ChangeNotifierProvider(create: (context) => ProviderSesion())
    ];
  }
}