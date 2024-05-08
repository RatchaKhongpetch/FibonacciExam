//
//  FibonacciModel.swift
//  Fibonacci
//
//  Created by Ratcha Khongpetch on 8/5/2567 BE.
//

import Foundation

struct FibonacciModel {
    let index: Int
    let fibonacciNumber: Int
    let symbol: SymbolType
    
    init(index: Int, fibonacciNumber: Int, symbol: SymbolType) {
        self.index = index
        self.fibonacciNumber = fibonacciNumber
        self.symbol = symbol
    }
}

enum SymbolType: String, CaseIterable {
    case square = "square"
    case cross = "xmark"
    case circle = "circle.fill"
}
