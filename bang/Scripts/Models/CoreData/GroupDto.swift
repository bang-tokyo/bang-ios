@objc(GroupDto)
class GroupDto: _GroupDto {

    var status: GroupStatus = .Active {
        didSet {
            statusValue = status.rawValue
        }
    }

    override func awakeFromFetch() {
        super.awakeFromFetch()
        status = GroupStatus.build(statusValue?.integerValue)
    }

    func fill(group: APIResponse.Group) {
        id = group.id
        name = group.name
        memo = group.memo
        regionId = group.regionId
        status = group.status
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
