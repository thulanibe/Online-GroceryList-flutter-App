import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: const BudgetPage(),
    theme: ThemeData(
      primaryColor: Colors.green, // Set the primary color to green
    ),
  ));
}

class BudgetPage extends StatefulWidget {
  const BudgetPage({Key? key}) : super(key: key);

  @override
  _BudgetPageState createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  double budgetLimit = 0.0;
  double totalSpent = 0.0; // Initialize total spent to 0
  TextEditingController itemController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController budgetLimitController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Grocery Budget',
          style: TextStyle(
            color: Colors.white, // Set the title text color to white
          ),
        ),
        backgroundColor:
            Colors.green, // Set the app bar background color to green
      ),
      backgroundColor:
          Colors.white, // Set the background color of the page to white
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Budget Limit: R${budgetLimit.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.green, // Set the text color to green
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Total Spent: R${totalSpent.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.green, // Set the text color to green
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    controller: itemController,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.green, // Set the text color to green
                    ),
                    decoration: InputDecoration(
                      labelText: 'Item',
                      labelStyle: const TextStyle(
                        color:
                            Colors.green, // Set the label text color to green
                      ),
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.green, // Set the icon color to green
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: priceController,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.green, // Set the text color to green
                    ),
                    decoration: InputDecoration(
                      labelText: 'Price (R)',
                      labelStyle: const TextStyle(
                        color:
                            Colors.green, // Set the label text color to green
                      ),
                      icon: const Icon(
                        Icons.attach_money,
                        color: Colors.green, // Set the icon color to green
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final price = double.tryParse(priceController.text);
                final itemName = itemController.text;
                if (itemName.isNotEmpty && price != null) {
                  if (totalSpent + price <= budgetLimit) {
                    setState(() {
                      // Update total spent
                      totalSpent += price;
                    });
                    // Add your item here
                    priceController.clear();
                    itemController.clear();
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Exceeded Budget Limit'),
                          content: const Text(
                              'The item cost exceeds the budget limit.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              child: const Text('Add Item'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Set Budget Limit'),
                      content: TextField(
                        controller: budgetLimitController,
                        style: const TextStyle(
                          color: Colors.green, // Set the text color to green
                        ),
                        decoration: InputDecoration(
                          labelText: 'Budget Limit (R)',
                          labelStyle: const TextStyle(
                            color: Colors
                                .green, // Set the label text color to green
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            final limit =
                                double.tryParse(budgetLimitController.text);
                            if (limit != null) {
                              setState(() {
                                budgetLimit = limit;
                                // Ensure total spent is within budget after changing the budget limit
                                if (totalSpent > budgetLimit) {
                                  totalSpent = budgetLimit;
                                }
                              });
                              budgetLimitController.clear();
                            }
                            Navigator.of(context).pop();
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              child: const Text('Set Budget Limit'),
            ),
          ],
        ),
      ),
    );
  }
}
