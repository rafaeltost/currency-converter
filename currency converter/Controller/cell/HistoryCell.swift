//
//  HistoryCell.swift
//  currency converter
//
//  Created by Rafael Tosta on 21/01/23.
//

import UIKit

class HistoryCell: UITableViewCell {

    @IBOutlet weak var lblTitle:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    public func setTitle(title:String) {
        self.lblTitle.text = title
    }
}
