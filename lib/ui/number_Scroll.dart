import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NumberScroll extends StatefulWidget {
  final int initialNumberr;
  final int maxNumberr;
  final Function(int) onNumberSelectedd;

  const NumberScroll({
    required this.initialNumberr,
    required this.maxNumberr,
    required this.onNumberSelectedd,
  });

  @override
  _NumberScrollState createState() => _NumberScrollState();
}

class _NumberScrollState extends State<NumberScroll> {
  late FixedExtentScrollController _scrollControllerr;
  late int selectedNumberr;

  @override
  void initState() {
    super.initState();
    selectedNumberr = widget.initialNumberr;
    _scrollControllerr = FixedExtentScrollController(initialItem: selectedNumberr - 1);
    periodeduration(selectedNumberr); // Store the initial number
    seedata();
  }

  Future<void> periodeduration(int number) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setInt('period_duration', number);
  }
void seedata()async{

  var seedata= await SharedPreferences.getInstance();

seedata.getInt('period_duration');
 
}
  @override
  Widget build(BuildContext context) {


    return CupertinoPicker(
      scrollController: _scrollControllerr,
      itemExtent: 40.0,
      onSelectedItemChanged: (index) {
        setState(() {
          selectedNumberr = index + 1;
          widget.onNumberSelectedd(selectedNumberr);
          periodeduration(selectedNumberr); // Store the number whenever it changes
        });
      },
      children: List<Widget>.generate(widget.maxNumberr, (index) {
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
