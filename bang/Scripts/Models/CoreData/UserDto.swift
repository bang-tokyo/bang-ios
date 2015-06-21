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
    }

    override var description: String {
        return "id:\(id), facebookId:\(facebookId), name:\(name), birthday:\(birthday), gender:\(gender), status:\(status), updatedAt:\(updatedAt), createdAt:\(createdAt)"
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
