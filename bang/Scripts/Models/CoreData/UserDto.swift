@objc(UserDto)
class UserDto: _UserDto {

    // MARK: - Class functions
    override func willSave() {
        super.willSave()
        setPrimitiveValue(NSDate(), forKey: "savedAt")
    }

    override func awakeFromFetch() {
        super.awakeFromFetch()
        gender = Gender.build(genderValue?.integerValue)
        status = UserStatus.build(statusValue?.integerValue)
        bloodType = BloodType.build(bloodTypeValue?.integerValue)
    }

    override var description: String {
        return "id:\(id), facebookId:\(facebookId), name:\(name), birthday:\(birthday), gender:\(gender), status:\(status), bloodType:\(bloodType), regionId:\(regionId), region:\(region), selfIntroduction:\(selfIntroduction), selfIntroductionLong:\(selfIntroductionLong), profileImage0:\(profileImage0), profileImagePath0:\(profileImagePath0), updatedAt:\(updatedAt), createdAt:\(createdAt)"
    }

    // MARK: - Instance valuables and functions
    var gender: Gender = .Transgender {
        didSet {
            genderValue = gender.rawValue
        }
    }

    var status: UserStatus = .Unknown {
        didSet {
            statusValue = status.rawValue
        }
    }

    var bloodType: BloodType = .Unknown {
        didSet {
            bloodTypeValue = bloodType.rawValue
        }
    }

    func profileImageIdBy(index: Int) -> NSNumber? {
        return index == 1 ? profileImage1
            : index == 2 ? profileImage2
            : index == 3 ? profileImage3
            : index == 4 ? profileImage4
            : index == 5 ? profileImage5
            : profileImage0
    }

    func profileImagePathBy(index: Int) -> String? {
        return index == 1 ? profileImagePath1
            : index == 2 ? profileImagePath2
            : index == 3 ? profileImagePath3
            : index == 4 ? profileImagePath4
            : index == 5 ? profileImagePath5
            : profileImagePath0
    }

    func isMine() -> Bool {
        return MyAccount.sharedInstance.userId == id
    }

    func fill(user: APIResponse.User) {
        id = user.id
        facebookId = user.facebookId
        name = user.name
        birthday = user.birthday
        gender = user.gender
        status = user.status
        bloodType = user.bloodType
        region = user.region
        regionId = user.regionId
        selfIntroduction = user.selfIntroduction
        selfIntroductionLong = user.selfIntroductionLong
        profileImage0 = user.profileImage0
        profileImage1 = user.profileImage1
        profileImage2 = user.profileImage2
        profileImage3 = user.profileImage3
        profileImage4 = user.profileImage4
        profileImage5 = user.profileImage5
        profileImagePath0 = user.profileImagePath0
        profileImagePath1 = user.profileImagePath1
        profileImagePath2 = user.profileImagePath2
        profileImagePath3 = user.profileImagePath3
        profileImagePath4 = user.profileImagePath4
        profileImagePath5 = user.profileImagePath5
        createdAt = user.createdAt
        updatedAt = user.updatedAt
    }
}
