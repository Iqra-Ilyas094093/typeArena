import 'package:flutter/material.dart';

class CodeTypingTest extends StatefulWidget {
  @override
  _CodeTypingTestState createState() => _CodeTypingTestState();
}

class _CodeTypingTestState extends State<CodeTypingTest> {
  TextEditingController _controller = TextEditingController();
  String _targetCode = '''
function hello() {
  if (true) {
    console.log("Hello World");
    for (let i = 0; i < 5; i++) {
      print(i);
    }
  }
}
''';
  int _currentLine = 0;
  int _currentIndent = 0;

  void _handleTyping(String text) {
    String newText = _controller.text;

    // Auto-closing brackets
    Map<String, String> autoClose = {'(': ')', '[': ']', '{': '}', '"': '"', "'": "'"};
    String lastChar = text.isNotEmpty ? text[text.length - 1] : '';

    if (autoClose.containsKey(lastChar)) {
      newText += autoClose[lastChar]!;
      _controller.text = newText;
      _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length - 1)
      );
    }

    // Auto-indentation on new line
    if (text.contains('\n')) {
      String indent = '  ' * _currentIndent;
      newText += indent;
      _controller.text = newText;
    }

    // Adjust indentation based on brackets
    _currentIndent = newText.split('{').length - newText.split('}').length - 1;
    _currentIndent = _currentIndent.clamp(0, 10);

    // Calculate current line
    _currentLine = '\n'.allMatches(newText).length + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Code Typing Test')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _controller,
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: _targetCode,
                  ),
                  onChanged: _handleTyping,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text('Line: $_currentLine | Indent: $_currentIndent'),
          ],
        ),
      ),
    );
  }
}