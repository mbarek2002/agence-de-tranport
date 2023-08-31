class checklistData {
  final String name;
  final bool state;

  checklistData({required this.name, required this.state});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'state': state,
    };
  }
}
