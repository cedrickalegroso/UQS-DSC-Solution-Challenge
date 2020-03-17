class Ticket {
  final String refNo;
  final String serviceUid;
  final String ticketNo;
  final String ticketOwnerUid;
  final num ticketRaw;
  final num timestamp;

  Ticket(
      {this.refNo,
      this.serviceUid,
      this.ticketNo,
      this.ticketOwnerUid,
      this.ticketRaw,
      this.timestamp});
}
