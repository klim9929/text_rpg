import 'package:flutter/material.dart';
import 'package:flutter_llama/flutter_llama.dart';
import 'package:provider/provider.dart';
import 'package:story_engine.dart';
import 'package:player.dart';
import 'package:utils/constants.dart';
import 'package:services/cache_manager.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();

  @override
  void didUpdateWidget(covariant GameScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Перезагрузка моделей при изменении настроек
    Provider.of<StoryEngine>(context, listen: false).reinit();
  }
}

class _GameScreenState extends State<GameScreen> {
  Player player = Warrior();
  String _storyText = '';
  Uint8List _pixelArt = Uint8List(0);
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final storyEngine = Provider.of<StoryEngine>(context);
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Пиксель-арт
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
              ),
              child: _pixelArt.isEmpty
                  ? CircularProgressIndicator()
                  : Image.memory(_pixelArt),
            ),

            // Статы игрока
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('HP: ${player.hp}', style: TextStyle(color: Colors.green)),
                Text('MP: ${player.mp}', style: TextStyle(color: Colors.blue)),
                Text('Золото: ${player.gold}',
                    style: TextStyle(color: Colors.yellow)),
              ],
            ),

            // Текст
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _storyText,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            // Динамические кнопки
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: _getActionButtons(),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getActionButtons() {
    return [
      ElevatedButton(
        onPressed: _isLoading ? null : () => _handleAction('Идти в лес'),
        child: Text('Идти в лес'),
      ),
      ElevatedButton(
        onPressed: _isLoading ? null : () => _handleAction('Поговорить с жителем'),
        child: Text('Поговорить'),
      ),
    ];
  }

  Future<void> _handleAction(String action) async {
    setState(() => _isLoading = true);

    try {
      final newStory = await storyEngine.generateStory(
        className: player.className,
        context: player.currentLocation,
      );

      final artDescription = 'Пейзаж ${action.split(' ').last}';
      _pixelArt = await storyEngine.generatePixelArt(artDescription);

      setState(() {
        _storyText = newStory;
        player.currentLocation = action.split(' ').last;
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
