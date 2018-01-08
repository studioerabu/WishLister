//
//  ItemCell.swift
//  WishLister
//
//  Created by Brandon Ha on 2018-01-09.
//  Copyright © 2018 Brandon Ha. All rights reserved.
//

import UIKit

internal class ItemCell: UITableViewCell {

    @IBOutlet internal weak var thumb: UIImageView!
    @IBOutlet internal weak var title: UILabel!
    @IBOutlet internal weak var price: UILabel!
    @IBOutlet internal weak var details: UILabel!
    
    internal func configureCell(item: Item) {
        title.text = item.title
        price.text = "\(item.price)"
        details.text = item.details
        thumb.image = item.toImage?.image as? UIImage
    }
}
