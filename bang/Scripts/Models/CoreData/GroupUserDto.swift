@objc(GroupUserDto)
class GroupUserDto: _GroupUserDto {

    var status: GroupUserStatus = .Active {
        didSet {
            statusValue = status.rawValue
        }
    }

    override func awakeFromFetch() {
        super.awakeFromFetch()
        status = GroupUserStatus.build(statusValue?.integerValue)
    }

    func fill(groupUser: APIResponse.GroupUser) {
        facebookId = groupUser.facebookId
        groupId = groupUser.groupId
        userId = groupUser.userId
        status = groupUser.status
        ownerFlg = groupUser.ownerFlg
    }
}
