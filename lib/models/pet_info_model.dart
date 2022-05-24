class PetItemModel {
  late int petId;
  late String petType;
  late String petImg;
  late String petName;
  late String petBreed;
  late String isSterilization;
  late String sex;
  late String birthday;
  late String adoptionDate;
  late String petKg;
  late bool isGuardian;
  late String age;
  late String isLoss;
  late String isPair;
  late String day;
  late int breedId;
  late String backgroundUrl;
  late String bindStatus;
  late List nearlyGrowPlanList;
  late String petAide;

  PetItemModel(
      {this.petId = 0,
      this.petType = '',
      this.petImg = '',
      this.petName = '',
      this.petBreed = '',
      this.isSterilization = '',
      this.sex = '',
      this.birthday = '',
      this.adoptionDate = '',
      this.petKg = '',
      this.isGuardian = false,
      this.age = '',
      this.isLoss = '',
      this.isPair = '',
      this.day = '',
      this.breedId = 0,
      this.backgroundUrl = '',
      this.bindStatus = '',
      required this.nearlyGrowPlanList,
      this.petAide = ''});

  PetItemModel.fromJson(Map<String, dynamic> json) {
    petId = json['petId'] ?? 0;
    petType = json['petType'] ?? '';
    petImg = json['petImg'] ?? '';
    petName = json['petName'] ?? '';
    petBreed = json['petBreed'] ?? '';
    isSterilization = json['isSterilization'] ?? '';
    sex = json['sex'] ?? '';
    birthday = json['birthday'] ?? '';
    adoptionDate = json['adoptionDate'] ?? '';
    petKg = json['petKg'] ?? '';
    isGuardian = json['isGuardian'] ?? '';
    age = json['age'] ?? '';
    isLoss = json['isLoss'] ?? '';
    isPair = json['isPair'] ?? '';
    day = json['day'] ?? '';
    breedId = json['breedId'] ?? 0;
    backgroundUrl = json['backgroundUrl'] ?? '';
    bindStatus = json['bindStatus'] ?? '';
    if (json['nearlyGrowPlanList'] != null) {
      nearlyGrowPlanList = [];
      json['nearlyGrowPlanList'].forEach((v) {
        nearlyGrowPlanList.add(v);
      });
    }
    petAide = json['petAide'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['petId'] = petId;
    data['petType'] = petType;
    data['petImg'] = petImg;
    data['petName'] = petName;
    data['petBreed'] = petBreed;
    data['isSterilization'] = isSterilization;
    data['sex'] = sex;
    data['birthday'] = birthday;
    data['adoptionDate'] = adoptionDate;
    data['petKg'] = petKg;
    data['isGuardian'] = isGuardian;
    data['age'] = age;
    data['isLoss'] = isLoss;
    data['isPair'] = isPair;
    data['day'] = day;
    data['breedId'] = breedId;
    data['backgroundUrl'] = backgroundUrl;
    data['bindStatus'] = bindStatus;
    data['nearlyGrowPlanList'] =
        nearlyGrowPlanList.map((v) => v.toJson()).toList();
    data['petAide'] = petAide;
    return data;
  }
}

class PetListModel {
  List<PetItemModel> list;
  PetListModel({
    required this.list
  });

  factory PetListModel.fromJson(List<dynamic> list) {
    return PetListModel(list: list.map((item) => PetItemModel.fromJson(item)).toList());
  }
}
