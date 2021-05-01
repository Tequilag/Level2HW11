//
//  String+Level2HW11.swift
//  Level2HW11
//
//  Created by Andrey Buksha on 01.05.2021.
//

import Foundation

extension String {
    
    var isEmail: Bool {
        
        do {
            
            let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            return regex.firstMatch(in: self,
                                    options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                    range: NSRange(location: 0, length: count)) != nil
        }
        catch {
            
            return false
        }
    }
    
}
