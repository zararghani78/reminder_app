import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reminderapp/routes/routes_name.dart';
import 'package:reminderapp/ui/cycle_scrol.dart';
import 'package:reminderapp/ui/date_Scroll.dart';
import 'package:reminderapp/ui/number_Scroll.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MODELBOOTOMSHEET extends StatefulWidget {
  const MODELBOOTOMSHEET({super.key});

  @override
  State<MODELBOOTOMSHEET> createState() => _MODELBOOTOMSHEETState();
}

class _MODELBOOTOMSHEETState extends State<MODELBOOTOMSHEET> {
  String currentDate = DateFormat('EEEE, MMM d, yyyy').format(DateTime.now());
  String onlyDate = DateFormat('MMM d,').format(DateTime.now());
  DateTime? highlightedDay;
  final PageController _pageController = PageController();
  int selectedPeriodDuration = 0;
  int selectedCycleDuration = 0;
  DateTime? selectedStartDate;
  int currentPageIndex = 0; // Track the current page index

  @override
  void initState() {
    super.initState();
    _loadHighlightedDay();
    _pageController.addListener(() {
      setState(() {
        currentPageIndex = _pageController.page!.toInt();
      });
    });
  }

  Future<void> _loadHighlightedDay() async {
    final prefs = await SharedPreferences.getInstance();
    final savedDate = prefs.getString('selected_date');
    final periodDuration = prefs.getInt('period_duration') ?? 0;
    final cycleDuration = prefs.getInt('cycle_duration') ?? 0;

    if (periodDuration == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showModelBottomSheet(context);
      });
    } else if (savedDate != null) {
      setState(() {
        DateTime selectedDay = DateTime.parse(savedDate);
        highlightedDay = selectedDay.add(const Duration(days: 25));
        selectedPeriodDuration = periodDuration;
        selectedCycleDuration = cycleDuration;
      });
    }
  }

  void _showModelBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 400, // Adjusted height to accommodate more content
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: PageView(
                controller: _pageController,
                children: <Widget>[
                  _buildPage(context, 1),
                  _buildPage2(context, 2),
                  _buildPage3(context, 3),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 270,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue,
                    ),
                    child: InkWell(
                      onTap: () {
                        if (currentPageIndex == 2) {
                          _saveCurrentPageData();
                          Navigator.pushNamed(context, RoutesName.homescreen); // Close dialog after saving data
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        }
                      },
                      child: Text(
                        currentPageIndex == 2 ? "Done" : "Next",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 270,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context); // Close dialog without setting duration
                      },
                      child: const Text(
                        "Not sure",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _saveCurrentPageData() async {
    final prefs = await SharedPreferences.getInstance();

    if (selectedPeriodDuration > 0) {
      await prefs.setInt('period_duration', selectedPeriodDuration);
    }
    if (selectedCycleDuration > 0) {
      await prefs.setInt('cycle_duration', selectedCycleDuration);
    }
    if (selectedStartDate != null) {
      await prefs.setString('selected_date', selectedStartDate!.toIso8601String());
    }
  }

  Widget _buildPage(BuildContext context, int page) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 260,
            child: Text(
              "How many days does your cycle usually last?",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const SizedBox(
            width: 260,
            child: Text(
              "The duration between two periods typically ranges from 23 to 35 days",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 120,
                  width: 200,
                  child: CYCLESCOLL(
                    initialNumber: selectedPeriodDuration,
                    maxNumber: 35,
                    onNumberSelected: (number) {
                      setState(() {
                        selectedPeriodDuration = number;
                      });
                    },
                  ),
                ),
                const Text(
                  "days",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage3(BuildContext context, int page) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 260,
            child: Text(
              "When is the start date of your last period?",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40),
            child: DATESCROLL(
              startDate: DateTime.now().subtract(Duration(days: 30)),
              endDate: DateTime.now(),
              onDateSelected: (date) {
                setState(() {
                  selectedStartDate = date;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage2(BuildContext context, int page) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 260,
            child: Text(
              "How many days does your periode usually last?",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const SizedBox(
            width: 260,
            child: Text(
             "Bleeding usually lasts between 4-7 days", 
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 120,
                  width: 200,
                  child: NumberScroll(
                    initialNumberr: selectedCycleDuration,
                    maxNumberr: 7,

                    onNumberSelectedd: (number) {
                      setState(() {
                        selectedCycleDuration = number;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "days",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Model Bottom Sheet Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (highlightedDay != null)
              Text(
                'Highlighted Day: ${DateFormat('EEEE, MMM d, yyyy').format(highlightedDay!)}',
                style: TextStyle(fontSize: 16),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showModelBottomSheet(context),
              child: Text('Show Model Bottom Sheet'),
            ),
          ],
        ),
      ),
    );
  }
}








/*



class NumberScroll extends StatefulWidget {
  final int initialNumber;
  final int maxNumber;
  final Function(int) onNumberSelected;

  const NumberScroll({
    required this.initialNumber,
    required this.maxNumber,
    required this.onNumberSelected,
  });

  @override
  _NumberScrollState createState() => _NumberScrollState();
}

class _NumberScrollState extends State<NumberScroll> {
  late FixedExtentScrollController _scrollController;
  late int selectedNumber;

  @override
  void initState() {
    super.initState();
    selectedNumber = widget.initialNumber;
    _scrollController = FixedExtentScrollController(initialItem: selectedNumber - 1);
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

*/