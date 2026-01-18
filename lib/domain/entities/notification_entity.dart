class NotificationEntity {
  final String id;
  final String title;
  final String message;
  final String type; // stock, insight, payment, alert, opportunity
  final bool isRead;
  final DateTime createdAt;

  NotificationEntity({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    this.isRead = false,
    required this.createdAt,
  });
}
