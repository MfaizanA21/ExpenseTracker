import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:new_abc/theme/theme_notifier.dart';

class ThemeSettingsPage extends StatefulWidget {
  @override
  _ThemeSettingsPageState createState() => _ThemeSettingsPageState();
}

class _ThemeSettingsPageState extends State<ThemeSettingsPage> with TickerProviderStateMixin {
  Animation<Alignment>? _animation;
  AnimationController? _animationController;
  Duration _duration = Duration(milliseconds: 370);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: _duration);
    _animation = AlignmentTween(begin: Alignment.centerLeft, end: Alignment.centerRight).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn,
      ),
    );
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Settings'),
      ),
      body: Center(
        child: Consumer<ThemeNotifier>(
          builder: (context, themeNotifier, child) {
            bool isDarkMode = themeNotifier.isDarkMode;

            // Sync the switch animation with the theme mode
            if (isDarkMode && _animationController?.status != AnimationStatus.completed) {
              _animationController?.forward();
            } else if (!isDarkMode && _animationController?.status != AnimationStatus.dismissed) {
              _animationController?.reverse();
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Select Theme'),
                SizedBox(height: 20),
                AnimatedBuilder(
                  animation: _animationController!,
                  builder: (context, child) {
                    return Center(
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          if (isDarkMode) {
                            themeNotifier.toggleTheme();
                          } else {
                            themeNotifier.toggleTheme();
                          }
                        },
                        child: Container(
                          width: 100,
                          height: 50,
                          padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.green : Colors.red,
                            borderRadius: BorderRadius.all(Radius.circular(99)),
                            boxShadow: [
                              BoxShadow(
                                color: isDarkMode ? Colors.green.withOpacity(0.6) : Colors.red.withOpacity(0.6),
                                blurRadius: 15,
                                offset: Offset(0, 8),
                              )
                            ],
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: _animation!.value,
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                Text(isDarkMode ? 'Dark Mode' : 'Light Mode', style: TextStyle(fontSize: 18)),
              ],
            );
          },
        ),
      ),
    );
  }
}
