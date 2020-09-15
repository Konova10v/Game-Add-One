//
//  String.swift
//  AddOne
//
//  Created by Кирилл Коновалов on 10.09.2020.
//  Copyright © 2020 Кирилл Коновалов. All rights reserved.
//

import Foundation
extension String {
    static func randomNumber(length: Int) -> String {
        var result = ""
        
        for _ in 0..<length {
            let digit = Int.random(in: 0...9)
            result += "\(digit)"
        }
        return result
    }
    
    func integer(n: Int) -> Int {
        let index = self.index(self.startIndex, offsetBy: n)
        return self[index].wholeNumberValue ?? 0
    }
}
