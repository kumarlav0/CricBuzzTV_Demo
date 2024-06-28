//
//  TableView+Extension.swift
//  CricBuzzTV
//
//  Created by Kumar Lav on 28/06/24.
//

import UIKit

extension UITableView {
    func registerCell(with nibName: String, identifier: String) {
        register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    func registerHeaderView(with nibName: String, identifier: String) {
        register(UINib(nibName: nibName, bundle: nil), forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    func reloadDataInMainQueue() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}

extension NSObject {
    
    class var nameOfClass: String {
        return String(describing: self)
    }
    
    var nameOfClass: String {
        return type(of: self).nameOfClass
    }
    
}
