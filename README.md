# Task 5 - Add history and persistence to your app

## Requirement:<br>
Your calculator could remember previous activities. Please create a separate screen "History" where the app records the previous calculations. A history line should include the calculation e.g "4 * 5 = 20" and the time of the calculation e.g. "2022-10-22 15:30".

The history has to be persisted in storage. You have two options: sharedPreferences and SQLite.

SharedPreferences implementation will give you up to 8 points, while SQLite is more complicated and will give you up to 10 points.

## Results

Created 1 other dart file in [lib:](https://github.com/mdkostom/MobileCalc/tree/Task-5-Add-history-and-persistence-to-your-app/lib)
- [history_screen.dart](https://github.com/mdkostom/MobileCalc/blob/Task-5-Add-history-and-persistence-to-your-app/lib/history_screen.dart) - Makes it possible to look at previous calculations
- Also adjusted INPUT area to show every input and added clear button "C" to clear results or current input.
