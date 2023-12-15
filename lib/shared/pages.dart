import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Page{
  final IconData icon;
  final String name;

  Page({
    required this.icon,
    required this.name
  });
}

abstract class Pages{
  static Page catalog = Page(
    icon: FontAwesomeIcons.clapperboard,
    name: "Catalog"
  );
  
  static Page planning = Page(
    icon: FontAwesomeIcons.film,
    name: "Planning"
  );
  
  static Page watched = Page(
    icon: FontAwesomeIcons.star,
    name: "Watched"
  );
  
  static Page profile = Page(
    icon: FontAwesomeIcons.user,
    name: "Profile"
  );
}