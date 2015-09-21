@objc(RegionDto)
class RegionDto: _RegionDto {

    override var description: String {
        return "id:\(id), message:\(name), conversationId:\(statusValue)"
    }

    func fill(region: APIResponse.Region) {
        id = region.id
        name = region.name
        statusValue = region.statusValue
    }
}

// MARK: - Class functions
extension RegionDto {
    class func fetchAll(delegate: NSFetchedResultsControllerDelegate) -> NSFetchedResultsController? {
        let predicate = NSPredicate(format: "statusValue = 1")
        return MR_fetchAllSortedBy(RegionDtoAttributes.id.rawValue, ascending: true, withPredicate: predicate, groupBy: nil, delegate: delegate)
    }
}
