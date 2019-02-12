//
//  ItemDetailsVC.swift
//  WishLister
//
//  Created by Brandon Ha on 2018-01-30.
//  Copyright © 2018 Brandon Ha. All rights reserved.
//

import UIKit
import CoreData

internal class ItemDetailsVC: UIViewController {

    @IBOutlet internal weak var storePicker: UIPickerView!
    @IBOutlet internal weak var titleField: CustomTextField!
    @IBOutlet internal weak var priceField: CustomTextField!
    @IBOutlet internal weak var detailsField: CustomTextField!
    @IBOutlet internal weak var saveItem: UIButton!
    
    @IBOutlet internal weak var thumpImg: UIImageView!
    
    internal var stores = [Store]()
    internal var itemToEdit: Item?
    internal var imagePicker: UIImagePickerController!
    
    internal override func viewDidLoad() {
        super.viewDidLoad()

        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        }
        
        storePicker.delegate = self
        storePicker.dataSource = self
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
      
        getStores()
        if stores.isEmpty {
            setStores()
            getStores()
        }

        if itemToEdit != nil {
            loadItemData();
        }
    }
    
    @IBAction internal func savePressed(_ sender: Any) {
        
        // let item = Item(context: context)
        var item: Item!
        
        let picture = Image(context: context)
        picture.image = thumpImg.image
       
        if itemToEdit == nil {
            item = Item(context: context)
        } else {
            item = itemToEdit
        }
        
        item.toImage = picture
        
        if let title = titleField.text {
            item.title = title
        }
        
        if let price = priceField.text {
            item.price = (price as NSString).doubleValue
        }
        
        if let details = detailsField.text {
            item.details = details
        }
        
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        ad.saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction internal func deletePressed(_ sender: UIBarButtonItem) {
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction internal func addImage(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    internal func loadItemData() {
        if let item = itemToEdit {
            titleField.text = item.title
            priceField.text = "\(item.price)"
            detailsField.text = item.details
            thumpImg.image = item.toImage?.image as? UIImage
            
            if let store = item.toStore {
                var index = 0
                
                repeat {
                    let s = stores[index]
                    if s.name == store.name {
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index += 1
                } while (index < stores.count)
            }
        }
    }
    
    // This is hard coded for testing. Feel free to
    // implement a feature that allows users to add/edit/remove stores.
    internal func setStores() {
        let store = Store(context: context)
        store.name = "Amazon"

        let store2 = Store(context: context)
        store2.name = "Best Buy"

        let store3 = Store(context: context)
        store3.name = "Wayfair"

        let store4 = Store(context: context)
        store4.name = "Alibaba"

        let store5 = Store(context: context)
        store5.name = "MEC"
        
        let store6 = Store(context: context)
        store6.name = "Apple"

        ad.saveContext()
    }
    
    internal func getStores() {
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        } catch {
            // Todo: handle error here.
        }
    }
}

// Helper function inserted by Swift 4.2 migrator.
private func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
private func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}

extension ItemDetailsVC: UIPickerViewDelegate {
    
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.name
    }
    
    internal func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    internal func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    /*
    internal func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }*/
}

extension ItemDetailsVC: UIPickerViewDataSource {
    
}

extension ItemDetailsVC: UIImagePickerControllerDelegate {
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        if let img = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
            thumpImg.image = img
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
}

extension ItemDetailsVC: UINavigationControllerDelegate {
    
}
