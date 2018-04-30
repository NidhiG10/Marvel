//
//  UICollectionViewExtension.swift
//  Marvel
//
//  Created by Nidhi Goyal on 29/04/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func dequeueCell<T>(withClass class: T.Type, forIndexPath indexPath: IndexPath) -> T where T: UICollectionViewCell {
        let name = NSStringFromClass(T.self).components(separatedBy: ".").last ?? ""
        return self.dequeueReusableCell(withReuseIdentifier: name, for: indexPath) as! T
    }
    
}
