//
//  WSWorkspaceListCell.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 14/08/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

enum WSWorkspaceListCellUIControlTag : Int {
    case nameLabel = 111
    case addressLabel = 112
    case descriptionTextView = 113
    case perDayLabel = 114
    case backgroundImageView = 2323
    case unknownType
}

class WSWorkspaceListCell : WSTableViewCell {
    override func awakeFromNib() {
        
    }
    
    func configureCell(_ workspace: WSWorkspace) {
        self.getLabel(WSWorkspaceListCellUIControlTag.nameLabel.rawValue).text = workspace.name
        self.getLabel(WSWorkspaceListCellUIControlTag.addressLabel.rawValue).text = workspace.address
        self.getLabel(WSWorkspaceListCellUIControlTag.perDayLabel.rawValue).text = "\(workspace.currency) \(workspace.dayPrice) / Day"

//      let textView = self.getView(WSWorkspaceListCellUIControlTag.descriptionTextView.rawValue) as! UITextView
//        textView.text = workspace.description
        let imageView = self.getView(WSWorkspaceListCellUIControlTag.backgroundImageView.rawValue) as! UIImageView
        imageView.kf.setImage(with: workspace.imageUrl, placeholder: Image.init(named: "placeholder-image"))
    }
}
