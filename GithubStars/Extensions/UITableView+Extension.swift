//
//  UITableView+Extension.swift
//  GithubStars
//
//  Created by Jaafar Barek on 4/5/19.
//  Copyright © 2019 Jaafar Barek. All rights reserved.
//

import UIKit

extension UITableView {
    
    func scroll(by: CGFloat, up: Bool = false) {
        var offset = contentOffset
        offset.y += by * (up ? -1 : 1)
        setContentOffset(offset, animated: true)
    }
    
    func isIndexPath(_ indexPath: IndexPath, isInPreloadingDistance distance: Int) -> Bool {
        let currentRow = indexPath.row
        let lastRow = numberOfRows(inSection: 0) - 1
        
        // Check if we are on the last row or on a row of a given distance. It's one or the other depending
        if (currentRow == lastRow && currentRow + distance > lastRow) || currentRow > lastRow - distance {
            return true
        }
        
        return false
    }
    
}

