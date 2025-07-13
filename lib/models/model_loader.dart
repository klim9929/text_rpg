import 'package:flutter_llama/flutter_llama.dart';

class ModelLoader {
  static Future<LLModel> loadLLM(String level) async {
    switch (level) {
      case 'low':
        return LLModel.fromFile('assets/models/tiny-llama-7b.gguf');
      case 'medium':
        return LLModel.fromFile('assets/models/Qwen3-0.6B-UD-IQ1_S.gguf');
      default:
        return LLModel.fromFile('assets/models/Qwen3-0.6B-UD-IQ1_S.gguf');
    }
  }

  static Future<PixelModel> loadPixelModel(String level) async {
    switch (level) {
      case 'low':
        return PixelModel.fromFile('assets/models/sd-tiny-1bit.gguf');
      case 'medium':
        return PixelModel.fromFile('assets/models/sd-tiny-1bit.gguf');
      default:
        return PixelModel.fromFile('assets/models/sd-1.5.gguf');
    }
  }
}
