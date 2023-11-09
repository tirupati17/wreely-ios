//
//  WSWorkspaceCollectionCell.swift
//  WreelySocial
//
//  Created by Tirupati Balan on 21/08/18.
//  Copyright © 2018 Celerstudio. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

enum WSWorkspaceCollectionCellUIControlTag : Int {
    case nameLabel = 111
    case awayLabel = 112
    case perDayLabel = 113
    case directionButton = 114
    case priceLabel = 115
    case backgroundImageView = 2323
    case unknownType
}

class WSWorkspaceCollectionCell : WSCollectionViewCell {
    
    override func awakeFromNib() {
        
    }
    
    func configureCell(_ workspace: WSWorkspace) {

        self.getLabel(WSWorkspaceCollectionCellUIControlTag.nameLabel.rawValue).text = workspace.name
        self.getLabel(WSWorkspaceCollectionCellUIControlTag.awayLabel.rawValue).text = workspace.address
        self.getLabel(WSWorkspaceCollectionCellUIControlTag.priceLabel.rawValue).text = "\(workspace.currency) \(workspace.dayPrice) / Day"
        let imageView = self.getView(WSWorkspaceCollectionCellUIControlTag.backgroundImageView.rawValue) as! UIImageView
        imageView.kf.setImage(with: workspace.imageUrl, placeholder: Image.init(named: "placeholder-image"))
    }
}
