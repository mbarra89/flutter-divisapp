import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final Widget child;

  static const Map<String, int> _routeIndex = {
    '/': 0,
    '/convert': 1,
    '/profile': 2,
  };

  static const List<_NavItem> _navItems = [
    _NavItem(
      icon: Icons.bar_chart,
      label: 'Indicadores',
      route: '/',
    ),
    _NavItem(
      icon: Icons.currency_exchange,
      label: 'Conversor',
      route: '/convert',
    ),
    _NavItem(
      icon: Icons.person,
      label: 'Perfil',
      route: '/profile',
    ),
  ];

  const ScaffoldWithNavBar({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: child,
      bottomNavigationBar: _buildNavigationBar(context, isDarkMode),
    );
  }

  Widget _buildNavigationBar(BuildContext context, bool isDarkMode) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1A2636) : const Color(0xFF3B82F6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        items: _navItems.map((item) => item.toNavigationBarItem()).toList(),
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) => _onItemTapped(index, context),
        backgroundColor: Colors.transparent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.6),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    return _routeIndex[location] ?? 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    if (index < _navItems.length) {
      GoRouter.of(context).go(_navItems[index].route);
    }
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  final String route;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.route,
  });

  BottomNavigationBarItem toNavigationBarItem() {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
