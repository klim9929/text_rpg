import 'package:flutter_llama/flutter_llama.dart';
import 'package:model_loader.dart';
import 'package:utils/optimization_settings.dart';

class StoryEngine {
  late final LLModel _llm;
  late final PixelModel _pixelModel;

  Future<void> reinit() async {
    final level = await OptimizationSettings.getLevel();
    _llm = await ModelLoader.loadLLM(level);
    _pixelModel = await ModelLoader.loadPixelModel(level);
  }

  Future<String> generateStory({required String className, required String context}) async {
    final prompt = '''Игровой генератор:
    Класс персонажа: $className
    Текущая локация: $context
    Генерируй краткое описание события с вариантами действий (3 опции)''';
    
    final maxTokens = level == 'low' ? 100 : level == 'medium' ? 150 : 200;
    return await _llm.generate(prompt, maxTokens: maxTokens);
  }

  Future<Uint8List> generatePixelArt(String description) async {
    return await _pixelModel.generate(
      prompt: description,
      width: 50,
      height: 50,
      quality: 80,
    );
  }
}
