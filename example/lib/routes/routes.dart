import 'package:fluwe/fluwe.dart';

import '../page/index/test_file_page.dart';
import '../page/index/test_router_page.dart';
class Routes {
  static List<RouteOptions> config = [
    RouteOptions(
      url: '/test_router',
      page: (args) {
        int id = args['id'];
        return TestRouterPage(
          pageCount: id
        );
      }
    ),
    RouteOptions(
      url: '/test_file',
      page: (args) {
        return TestFilePage(
        );
      }
    )
  ];
}