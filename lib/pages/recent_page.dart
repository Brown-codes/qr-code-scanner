import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../services/history_service.dart';

class RecentPage extends StatefulWidget {
  const RecentPage({super.key});

  @override
  State<RecentPage> createState() => _RecentPageState();
}

class _RecentPageState extends State<RecentPage> {
  List<String> _history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final list = await HistoryService.getHistory();
    setState(() {
      _history = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recent scans"),
        actions: [
          IconButton(
            onPressed: () async {
              await HistoryService.clearHistory();
              _loadHistory();
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: _history.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 88, color: Colors.grey),
                  SizedBox(height: 16),
                  Text("No history yet!"),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _history.length,
              itemBuilder: (context, index) {
                final code = _history[index];

                return Dismissible(
                  key: Key(code),

                  direction: DismissDirection.endToStart,

                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),

                  onDismissed: (direction) async {
                    await HistoryService.deleteItem(code);

                    setState(() {
                      _history.removeAt(index);
                    });

                    // 3. Show confirmation
                    if (context.mounted) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Text("Deleted: $code"),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                await HistoryService.addToHistory(code);
                                _loadHistory();
                              },
                              child: Text("Undo"),
                            ),
                          ],
                        ),
                      );
                    }
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(
                    //     content: Text("Deleted: $code"),
                    //     action: SnackBarAction(
                    //       label: "UNDO",
                    //       onPressed: () async {
                    //         // Optional: Add it back if they click Undo
                    //         await HistoryService.addToHistory(code);
                    //         _loadHistory();
                    //       },
                    //     ),
                    //   ),
                    // );
                  },

                  // The actual card you see
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: ListTile(
                      leading: const Icon(
                        Icons.qr_code_2,
                        color: Colors.blueAccent,
                      ),
                      title: Text(
                        code,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: const Text("Tap to copy"),
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: code));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Copied to clipboard!")),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
