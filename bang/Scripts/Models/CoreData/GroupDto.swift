@objc(GroupDto)
class GroupDto: _GroupDto {

    var status: GroupStatus = .Active {
        didSet {
            statusValue = status.rawValue
        }
    }

    // Custom logic goes here.
    func fill(group: APIResponse.Group) {
        id = group.id
        ownerUserId = group.ownerUserId
        name = group.name
        memo = group.memo
        regionId = group.regionId
        statusValue = group.statusValue
        createdAt = group.createdAt
        updatedAt = group.updatedAt
    }
}

// MARK: - Class functions
extension GroupDto {

    class func fetchAll(delegate: NSFetchedResultsControllerDelegate) -> NSFetchedResultsController? {
        let predicate = NSPredicate(format: "statusValue = %d", GroupStatus.Active.rawValue)
        return MR_fetchAllSortedBy(GroupDtoAttributes.updatedAt.rawValue, ascending: false, withPredicate: predicate, groupBy: nil, delegate: delegate)
    }

}
