import 'package:flutter/material.dart';

class CustomTabSwitch extends StatelessWidget {
  final bool showOnlyFavorites;
  final Function(bool) onToggle;

  const CustomTabSwitch({
    super.key,
    required this.showOnlyFavorites,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Color(0xFF87A1FA).withOpacity(0.3)),
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: showOnlyFavorites ? MediaQuery.of(context).size.width * 0.5 - 16 : 4,
            top: 4,
            bottom: 4,
            width: MediaQuery.of(context).size.width * 0.5 - 20,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF87A1FA),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF87A1FA).withOpacity(0.3),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
          
          // Botões
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onToggle(false),
                  child: Container(
                    height: 48,
                    child: Center(
                      child: Text(
                        'Todos',
                        style: TextStyle(
                          color: !showOnlyFavorites ? Colors.white : Colors.grey[400],
                          fontSize: 14,
                          fontWeight: !showOnlyFavorites ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onToggle(true),
                  child: Container(
                    height: 48,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite,
                            color: showOnlyFavorites ? Colors.white : Colors.grey[400],
                            size: 16,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Favoritos',
                            style: TextStyle(
                              color: showOnlyFavorites ? Colors.white : Colors.grey[400],
                              fontSize: 14,
                              fontWeight: showOnlyFavorites ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}