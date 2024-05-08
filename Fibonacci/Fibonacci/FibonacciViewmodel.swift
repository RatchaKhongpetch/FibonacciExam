//
//  FibonacciViewmodel.swift
//  Fibonacci
//
//  Created by Ratcha Khongpetch on 8/5/2567 BE.
//

import Foundation

@Observable
class FibonacciViewmodel {
    var fibonacciList: [FibonacciModel] = []
    private var circleList: [FibonacciModel] = []
    private var crossList: [FibonacciModel] = []
    private var squareList: [FibonacciModel] = []
    var currentList: [FibonacciModel] = [] //Use to show in bottom sheet
    var selectRow: Int = 0
    var unselectRow: Int?
    
    func doFibonacci(total: Int = 40) {
        var prev1 = 1
        var prev2 = 0
        
        for i in 0...total-1 {
            let randomSymbol = SymbolType.allCases.randomElement() ?? SymbolType.circle
            if i == 0 {
                fibonacciList.append(FibonacciModel(index: i, fibonacciNumber: 0, symbol: randomSymbol))
            } else if i == 1 {
                fibonacciList.append(FibonacciModel(index: i, fibonacciNumber: 1, symbol: randomSymbol))
            } else {
                let temp = prev1
                prev1 = prev2 + prev1
                prev2 = temp
                fibonacciList.append(FibonacciModel(index: i, fibonacciNumber: prev1, symbol: randomSymbol))
            }
        }
    }
    
    func selectRow(index: Int, completion: @escaping()->Void) {
        unselectRow = nil
        switch fibonacciList[index].symbol {
        case .circle:
            if let index1 = circleList.firstIndex(where: {$0.index > fibonacciList[index].index}) {
                circleList.insert(fibonacciList[index], at: index1)
                selectRow = index1
            } else {
                circleList.append(fibonacciList[index])
                selectRow = circleList.count - 1
            }
            currentList = circleList
        case .square:
            if let index1 = squareList.firstIndex(where: {$0.index > fibonacciList[index].index}) {
                squareList.insert(fibonacciList[index], at: index1)
                selectRow = index1
            } else {
                squareList.append(fibonacciList[index])
                selectRow = squareList.count - 1
            }
            currentList = squareList
        case .cross:
            if let index1 = crossList.firstIndex(where: {$0.index > fibonacciList[index].index}) {
                crossList.insert(fibonacciList[index], at: index1)
                selectRow = index1
            } else {
                crossList.append(fibonacciList[index])
                selectRow = crossList.count - 1
            }
            currentList = crossList
        }
        fibonacciList.remove(at: index)
        completion()
    }
    
    func unselectRow(index: Int, completion: @escaping()->Void) {
        if let index1 = fibonacciList.firstIndex(where: {$0.index > currentList[index].index}) {
            fibonacciList.insert(currentList[index], at: index1)
            unselectRow = index1
        } else {
            fibonacciList.append(currentList[index])
            unselectRow = fibonacciList.count - 1
        }
        currentList.remove(at: index)
        completion()
    }
}
