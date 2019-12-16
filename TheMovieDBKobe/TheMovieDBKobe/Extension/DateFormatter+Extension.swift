//
//  DateFormatter+Extension.swift
//  TheMovieDBKobe
//
//  Created by Bruno Dorneles on 15/12/19.
//  Copyright © 2019 Bruno Dorneles. All rights reserved.
//

import UIKit

extension DateFormatter {
    static func formatFromAPI(string: String)->Date?{
        let dateFormatter = DateFormatter(withFormat: "yyyy-mm-dd", locale: "en-US")
       return dateFormatter.date(from: string)
    }
    static func formatToShow(date : Date?)->String{
        guard date != nil else {return "N/D"}
        
        let dateFormatter = DateFormatter(withFormat: "mm/dd/yy", locale: "en-US")
      return  dateFormatter.string(from: date!)
    }
}

extension UIScrollView {
    func  isNearBottomEdge(edgeOffset: CGFloat = 20.0) -> Bool {
        return self.contentOffset.y + self.frame.size.height + edgeOffset > self.contentSize.height
    }
}
