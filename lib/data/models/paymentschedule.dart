class PaymentSchedule {
  Data? data;

  PaymentSchedule({this.data});

  PaymentSchedule.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? loanId;
  int? clientId;
  String? clientName;
  String? clientGender;
  String? clientPhone;
  int? loanAmount;
  int? processFee;
  String? approveDate;
  String? purpose;
  int? duration;
  int? coId;
  String? coName;
  String? coPhone;
  List<Schedule>? schedule;

  Data(
      {this.loanId,
      this.clientId,
      this.clientName,
      this.clientGender,
      this.clientPhone,
      this.loanAmount,
      this.processFee,
      this.approveDate,
      this.purpose,
      this.duration,
      this.coId,
      this.coName,
      this.coPhone,
      this.schedule});

  Data.fromJson(Map<String, dynamic> json) {
    loanId = json['loan_id'];
    clientId = json['client_id'];
    clientName = json['client_name'];
    clientGender = json['client_gender'];
    clientPhone = json['client_phone'];
    loanAmount = json['loan_amount'];
    processFee = json['process_fee'];
    approveDate = json['approve_date'];
    purpose = json['purpose'];
    duration = json['duration'];
    coId = json['co_id'];
    coName = json['co_name'];
    coPhone = json['co_phone'];
    if (json['schedule'] != null) {
      schedule = <Schedule>[];
      json['schedule'].forEach((v) {
        schedule!.add(new Schedule.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loan_id'] = this.loanId;
    data['client_id'] = this.clientId;
    data['client_name'] = this.clientName;
    data['client_gender'] = this.clientGender;
    data['client_phone'] = this.clientPhone;
    data['loan_amount'] = this.loanAmount;
    data['process_fee'] = this.processFee;
    data['approve_date'] = this.approveDate;
    data['purpose'] = this.purpose;
    data['duration'] = this.duration;
    data['co_id'] = this.coId;
    data['co_name'] = this.coName;
    data['co_phone'] = this.coPhone;
    if (this.schedule != null) {
      data['schedule'] = this.schedule!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Schedule {
  int? id;
  int? scheduleNumber;
  String? paymentDate;
  int? dueAmount;
  int? penalty;
  int? total;
  int? paidAmount;
  int? totalOwe;
  String? staus;
  int? penaltypaid;

  Schedule(
      {this.id,
      this.scheduleNumber,
      this.paymentDate,
      this.dueAmount,
      this.penalty,
      this.total,
      this.paidAmount,
      this.totalOwe,
      this.staus,
      this.penaltypaid});

  Schedule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    scheduleNumber = json['schedule_number'];
    paymentDate = json['payment_date'];
    dueAmount = json['due_amount'];
    penalty = json['penalty'];
    total = json['total'];
    paidAmount = json['paid_amount'];
    totalOwe = json['total_owe'];
    staus = json['staus'];
    penaltypaid = json['penalty_paid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['schedule_number'] = this.scheduleNumber;
    data['payment_date'] = this.paymentDate;
    data['due_amount'] = this.dueAmount;
    data['penalty'] = this.penalty;
    data['total'] = this.total;
    data['paid_amount'] = this.paidAmount;
    data['total_owe'] = this.totalOwe;
    data['staus'] = this.staus;
    return data;
  }
}
