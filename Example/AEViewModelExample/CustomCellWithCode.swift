//
//  CustomCellWithCode.swift
//  AEViewModelExample
//
//  Created by Marko Tadić on 4/23/17.
//  Copyright © 2017 AE. All rights reserved.
//

import UIKit
import AEViewModel

class CustomCellWithCode: TableCell.Subtitle {
    
    // MARK: - TableCell
    
    override func customize() {
        textLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
        detailTextLabel?.font = UIFont.preferredFont(forTextStyle: .caption1)
    }
    
    override func update(with item: Item) {
        super.update(with: item)
        
        let url = URL(string: "https://avatars1.githubusercontent.com/u/2762374")!
        imageView?.setImage(from: url)
    }
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let width = imageView?.bounds.size.width ?? 0
        imageView?.layer.cornerRadius = width / 2
        imageView?.layer.masksToBounds = true
    }
    
}
