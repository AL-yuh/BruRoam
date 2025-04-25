class GroupEvent {
  final String location;
  final DateTime date; // Replace month with full date
  final String duration;
  final String description;
  int attendees;
  final int maxPax;
   final String chatRoomLink;

  GroupEvent({
    required this.location,
    required this.date, 
    required this.duration,
    required this.description,
    required this.attendees,
    required this.maxPax,
    required this.chatRoomLink,
  });
}