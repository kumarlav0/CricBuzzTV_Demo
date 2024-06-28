//
//  ChatListHeaderView.swift
//  Textico
//
//  Created by Kumar Lav on 28/06/24.
//  Copyright © 2023 MacOS. All rights reserved.
//

import UIKit

protocol MovieListHeaderViewDelegate: AnyObject {
    func didClickedHeader(section: Int)
}

class MovieListHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var openCloseButton: UIButton!
    
    @IBOutlet weak var headerTitle: UILabel!
    
    weak var delegate: MovieListHeaderViewDelegate?
    
    var section: Int?
    
    func setData(title: String, section: Int, isExpand: Bool) {
        headerTitle.text = title
        self.section = section
        openCloseButton.setImage(UIImage(systemName: isExpand ? "chevron.up" : "chevron.down"), for: .normal)
    }
    
    @IBAction func didClickExpandAction(_ sender: Any) {
        guard let section = section else { return }
        delegate?.didClickedHeader(section: section)
    }
    
}
