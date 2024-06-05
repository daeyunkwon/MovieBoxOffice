//
//  ReuseIdentifierProtocol.swift
//  MovieBoxOffice
//
//  Created by 권대윤 on 6/6/24.
//

import UIKit

protocol ReuseIdentifierProtocol {
    static var identifier: String {get}
}

extension UITableViewCell: ReuseIdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
