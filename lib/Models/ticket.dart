class Ticket {
  final String refNo;
  final String serviceUid;
  final String ticketNo;
  final String ticketOwnerUid;
  final int timestamp;

  Ticket(
      {this.refNo,
      this.serviceUid,
      this.ticketNo,
      this.ticketOwnerUid,
      this.timestamp});
}
