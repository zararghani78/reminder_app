import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CYCLESCOLL extends StatefulWidget {
  final int initialNumber;
  final int maxNumber;
  final Function(int) onNumberSelected;

  const CYCLESCOLL({
    required this.initialNumber,
    required this.maxNumber,
    required this.onNumberSelected,
  });

  @override
  _CYCLESCOLLState createState() => _CYCLESCOLLState();
}

class _CYCLESCOLLState extends State<CYCLESCOLL> {
  late FixedExtentScrollController _scrollController;
  late int selectedNumber;

  @override
  void initState() {
    super.initState();
    selectedNumber = widget.initialNumber;
    _scrollController = FixedExtentScrollController(initialItem: selectedNumber - 1);
    periodeduration(selectedNumber); // Store the initial number
    seedata();
  }

  Future<void> periodeduration(int number) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setInt('cycle_duration', number);
  }
void seedata()async{

  var seedata= await SharedPreferences.getInstance();

seedata.getInt('cycle_duration');
 
}
  @override
  Widget build(BuildContext context) {


    return CupertinoPicker(
      scrollController: _scrollController,
      itemExtent: 40.0,
      onSelectedItemChanged: (index) {
        setState(() {
          selectedNumber = index + 1;
          widget.onNumberSelected(selectedNumber);
          periodeduration(selectedNumber); // Store the number whenever it changes
        });
      },
      children: List<Widget>.generate(widget.maxNumber, (index) {
        return Center(
          child: Text(
            (index + 1).toString(),
            style: const TextStyle(fontSize: 20),
          ),
        );
      }),
    );
  }
}
