//
//  DefaultFetchedResultsControllerDelegate.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/06/20.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation

class DefaultFetchedResultsControllerDelegate: NSObject, NSFetchedResultsControllerDelegate {
    private weak var tableView: UITableView!

    init(_ tableView: UITableView) {
        self.tableView = tableView
    }

    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }

    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        case .Update:
            tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: .None)
        case .Move:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        }
    }

    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
}
