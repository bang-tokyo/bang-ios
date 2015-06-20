@objc(UserBangDto)
class UserBangDto: _UserBangDto {

    override var description: String {
        return "id:\(id), fromUserId:\(fromUserId), status:\(status), updatedAt:\(updatedAt), createdAt:\(createdAt)"
    }

    var status: BangStatus = .Default {
        didSet {
            statusValue = status.rawValue
        }
    }

    func fill(userBang: APIResponse.UserBang) {
        id = userBang.id
        createdAt = userBang.createdAt
        updatedAt = userBang.updatedAt
        fromUserId = userBang.fromUserId
        status = userBang.status
    }
}

// MARK: - Class functions
extension UserBangDto {

    class func fetchAll(delegate: NSFetchedResultsControllerDelegate) -> NSFetchedResultsController? {
        let predicate = NSPredicate(format: "statusValue = %d", BangStatus.Default.rawValue)
        return MR_fetchAllSortedBy(UserBangDtoAttributes.updatedAt.rawValue, ascending: false, withPredicate: predicate, groupBy: nil, delegate: delegate)
    }

    class func deleteAllInActive(context: NSManagedObjectContext) {
        let predicate = NSPredicate(format: "statusValue != %d", BangStatus.Default.rawValue)
        MR_deleteAllMatchingPredicate(predicate, inContext: context)
    }

}
