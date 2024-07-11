import 'package:applematch/features/discover/screens/discover_screen.dart';
import 'package:applematch/features/home/screens/home_screen.dart';
import 'package:applematch/features/matches/screens/matches_screen.dart';
import 'package:applematch/features/messages/screens/message_screen.dart';
import 'package:applematch/features/profile/screens/profile_screen.dart';
import 'package:flutter/material.dart';

const List<Widget> pages = [
  HomeScreen(),
  DiscoverScreen(),
  MatchesScreen(),
  MessageScreen(),
  ProfileScreen(),
];
