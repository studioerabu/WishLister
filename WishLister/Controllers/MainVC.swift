//
//  MainVC.swift
//  WishLister
//
//  Created by Brandon Ha on 2019-01-07.
//  Copyright © 2019 Brandon Ha. All rights reserved.
//

import UIKit
import CoreData

internal class MainVC: UIViewController {
    
    @IBOutlet internal weak var tableView: UITableView!
    @IBOutlet internal weak var segment: UISegmentedControl!
    
    internal var controller: NSFetchedResultsController<Item>!
    
    override internal func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        attemptFetch()
    }
    
    @IBAction internal func segmentChanged(_ sender: UISegmentedControl) {
        attemptFetch()
        tableView.reloadData()
    }
    
    internal func configureCell(cell: ItemCell, indexPath: NSIndexPath) {
        let item = controller.object(at: indexPath as IndexPath)
        cell.configureCell(item: item)
    }
    
    override internal func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "itemDetailsVC" {
            if let destination = segue.destination as? ItemDetailsVC {
                if let item = sender as? Item {
                    destination.itemToEdit = item
                }
            }
        }
    }
    
    internal func attemptFetch() {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        let priceSort = NSSortDescriptor(key: "price", ascending: true)
        let titleSort = NSSortDescriptor(key: "title", ascending: true)
        
        if segment.selectedSegmentIndex == 0 {
            fetchRequest.sortDescriptors = [dateSort]
        } else if segment.selectedSegmentIndex == 1 {
            fetchRequest.sortDescriptors = [priceSort]
        } else if segment.selectedSegmentIndex == 2 {
            fetchRequest.sortDescriptors = [titleSort]
        }
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self
        
        self.controller = controller
        
        do {
            try controller.performFetch()
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }

    internal func generateTestDate() {
        let item = Item(context: context)
        item.title = "MacBook Pro"
        item.price = 3800
        item.details = "I can't wait until Sept event, I hope they release new MBPs"
        
        let item2 = Item(context: context)
        item2.title = "Bose Headphones"
        item2.price = 300
        item2.details = "Noise cancelling tech."
        
        let item3 = Item(context: context)
        item3.title = "iMac 5K"
        item3.price = 6800
        item3.details = "Oh man this is a beautifut Mac."
        
        ad.saveContext()
    }
}

extension MainVC: UITableViewDelegate {
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let objs = controller.fetchedObjects, objs.count >= 1 {
            let item = objs[indexPath.row]
            performSegue(withIdentifier: "itemDetailsVC", sender: item)
        }
    }
    
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension MainVC: UITableViewDataSource {
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemCell
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller.sections {
            return sections.count;
        }
        return 0
    }
}

extension MainVC: NSFetchedResultsControllerDelegate {
    
    internal func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    internal func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    internal func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                             didChange anObject: Any, at indexPath: IndexPath?,
                             for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch(type) {
            
        case.insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            
        case.delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
        case.update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! ItemCell
                
                // update the cell data
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            }
            
        case.move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
        }
    }
}
