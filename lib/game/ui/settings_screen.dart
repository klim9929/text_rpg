import 'package:flutter/material.dart';
import 'package:utils/optimization_settings.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Настройки')),
      body: ListView(
        children: [
          ListTile(
            title: Text('Уровень оптимизации'),
            trailing: FutureBuilder<String>(
              future: OptimizationSettings.getLevel(),
              builder: (context, snapshot) {
                return DropdownButton<String>(
                  value: snapshot.data,
                  items: OptimizationSettings.levels.map((level) {
                    return DropdownMenuItem(
                      value: level,
                      child: Text(
                        level == 'high'
                            ? 'Высокая производительность'
                            : level == 'medium'
                                ? 'Средний режим'
                                : 'Минимальные требования',
                      ),
                    );
                  }).toList(),
                  onChanged: (value) => OptimizationSettings.setLevel(value!),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
