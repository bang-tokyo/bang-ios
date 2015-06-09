@objc(UserDto)
class UserDto: _UserDto {

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

    override func willSave() {
        super.willSave()
        setPrimitiveValue(NSDate(), forKey: "savedAt")
    }

    override func awakeFromFetch() {
        super.awakeFromFetch()
        gender = Gender.build(genderValue?.integerValue)
        status = UserStatus.build(statusValue?.integerValue)
    }

    func fill(user: APIResponse.User) {
        id = user.id
        facebookId = user.facebookId
        name = user.name
        birthday = user.birthday
        gender = user.gender
        status = user.status
        createdAt = user.createdAt
        updatedAt = user.updatedAt
    }
}
