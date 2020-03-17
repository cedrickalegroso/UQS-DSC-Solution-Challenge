class Ticket {
  final String refNo;
  final String serviceUid;
  final num teller;
  final dynamic ticketNo;
  final String ticketOwnerUid;
  final num ticketRaw;
  final num ticketStatus;
  final num timestamp;

  Ticket(
      {this.refNo,
      this.serviceUid,
      this.teller,
      this.ticketNo,
      this.ticketOwnerUid,
      this.ticketRaw,
      this.ticketStatus,
      this.timestamp});
}
