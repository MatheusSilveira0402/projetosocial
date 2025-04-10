import 'package:flutter_modular/flutter_modular.dart';
import 'package:projetosocial/app/modules/home/pages/campaign_details_page.dart';
import 'package:projetosocial/app/modules/home/pages/campaign_form_page.dart';
import 'package:projetosocial/app/modules/home/pages/home_page.dart';


class HomeModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const HomePage());
    r.child('/new', child: (_) => const CampaignFormPage());
    r.child('/details', child: (_) => const CampaignDetailsPage());
  }
}
