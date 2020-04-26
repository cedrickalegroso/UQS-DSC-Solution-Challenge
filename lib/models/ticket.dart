class Ticket {
  final num timestampDone;
  final num isEmailNotify;
  final String refNo;
  final String serviceUid;
  final num teller;
  final dynamic ticketNo;
  final String ticketOwnerUid;
  final num ticketRaw;
  final num trigger;
  final num ticketStatus;
  final num timestamp;
  final num alreadyNotified;

  Ticket(
      {this.timestampDone,
      this.isEmailNotify,
      this.refNo,
      this.serviceUid,
      this.teller,
      this.ticketNo,
      this.ticketOwnerUid,
      this.ticketRaw,
      this.trigger,
      this.ticketStatus,
      this.timestamp,
      this.alreadyNotified});
}

class Active {
  final num timestampDone;
  final num isEmailNotify;
  final String refNo;
  final String serviceUid;
  final num teller;
  final dynamic ticketNo;
  final String ticketOwnerUid;
  final num ticketRaw;
  final num trigger;
  final num ticketStatus;
  final num timestamp;
  final num alreadyNotified;

  Active(
      {this.timestampDone,
      this.isEmailNotify,
      this.refNo,
      this.serviceUid,
      this.teller,
      this.ticketNo,
      this.ticketOwnerUid,
      this.ticketRaw,
      this.trigger,
      this.ticketStatus,
      this.timestamp,
      this.alreadyNotified});
}

class Done {
  final num timestampDone;
  final num isEmailNotify;
  final String refNo;
  final String serviceUid;
  final num teller;
  final dynamic ticketNo;
  final String ticketOwnerUid;
  final num ticketRaw;
  final num trigger;
  final num ticketStatus;
  final num timestamp;
  final num alreadyNotified;

  Done(
      {this.timestampDone,
      this.isEmailNotify,
      this.refNo,
      this.serviceUid,
      this.teller,
      this.ticketNo,
      this.ticketOwnerUid,
      this.ticketRaw,
      this.trigger,
      this.ticketStatus,
      this.timestamp,
      this.alreadyNotified});
}

class Cancelled {
  final num isEmailNotify;
  final String refNo;
  final String serviceUid;
  final num teller;
  final dynamic ticketNo;
  final String ticketOwnerUid;
  final num ticketRaw;
  final num trigger;
  final num ticketStatus;
  final num timestamp;
  final num timestampDone;
  final num alreadyNotified;

  Cancelled(
      {this.isEmailNotify,
      this.refNo,
      this.serviceUid,
      this.teller,
      this.ticketNo,
      this.ticketOwnerUid,
      this.ticketRaw,
      this.trigger,
      this.ticketStatus,
      this.timestamp,
      this.timestampDone,
      this.alreadyNotified});
}
