import 'package:flutter/material.dart';


Widget InputText(String label, TextInputType type,
    TextEditingController controller, String prefix) {
  return Theme(
    data: ThemeData(
      primaryColor: Colors.redAccent,
      primaryColorDark: Colors.red,
    ),
    child: TextField(
      maxLength: 15,
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        counterText: "",
          labelText: label,
          prefixText: prefix,
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFEB5757))),
          suffixIcon: GestureDetector(
            onTap: () {
              controller.clear();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: const Icon(Icons.cancel, size: 20, color: Color(0xFF8E8E93),)
            ),
          )),
    ),
  );
}

class InputPass extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  const InputPass({Key? key, required this.controller, required this.label}) : super(key: key);

  @override
  _InputPassState createState() => _InputPassState();
}

class _InputPassState extends State<InputPass> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Theme(
        data: ThemeData(
          primaryColor: Colors.redAccent,
          primaryColorDark: Colors.red,
        ),
        child: TextField(
          controller: widget.controller,
          enableSuggestions: false,
          autocorrect: false,
          keyboardType: TextInputType.visiblePassword,
          obscureText: !_isVisible,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF8E8E93)),
            ),
            labelText: widget.label,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFEB5757)),
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _isVisible = !_isVisible;
                });
              },
              child: Icon(
                _isVisible ? Icons.visibility : Icons.visibility_off,
                color: Color(0xFF8E8E93),
              ),
            ),
          ),
        ),
      ),
    );
  }
}