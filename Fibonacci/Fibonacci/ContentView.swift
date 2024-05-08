//
//  ContentView.swift
//  Fibonacci
//
//  Created by Ratcha Khongpetch on 8/5/2567 BE.
//

import SwiftUI

struct ContentView: View {
    
    @State private var viewModel = FibonacciViewmodel()
    let numbers = [1, 1, 2, 3, 5]
    @State private var showingBottomView = false
    
    var body: some View {
        NavigationView {
            ScrollViewReader { proxy in
                List {
                    ForEach(Array(viewModel.fibonacciList.enumerated()), id: \.offset) { index, element in
                        ZStack {
                            HStack {
                                Text("Index: \(String(element.index)), Number: \(String(element.fibonacciNumber))")
                                Spacer()
                                Image(systemName: element.symbol.rawValue)
                                    .imageScale(.large)
                                    .foregroundStyle(.gray)
                            }
                            Button("") {
                                viewModel.selectRow(index: index, completion: {
                                    showingBottomView.toggle()
                                })
                                
                            }
                        }
                        .listRowBackground(index == viewModel.unselectRow ? Color.red : .none)
                    }
                }
                .onLoad {
                    //Feel free to change number here. Make sure int variable can store it. Or it will crash.
                    viewModel.doFibonacci(total: 40)
                }.onChange(of: showingBottomView) {
                    if let unselectRow = viewModel.unselectRow, showingBottomView == false {
                        withAnimation {
                            proxy.scrollTo(unselectRow, anchor: .center)
                        }
                    }
                }
                .navigationTitle("Example")
                .navigationBarTitleDisplayMode(.inline)
            }
        }.sheet(isPresented: $showingBottomView) {
            ScrollViewReader { proxy1 in
                List {
                    ForEach(Array(viewModel.currentList.enumerated()), id: \.offset) { index, element in
                        ZStack {
                            HStack {
                                Text("Index: \(String(element.index)), Number: \(String(element.fibonacciNumber))")
                                Spacer()
                                Image(systemName: element.symbol.rawValue)
                                    .imageScale(.large)
                                    .foregroundStyle(.gray)
                            }
                            Button("") {
                                viewModel.unselectRow(index: index, completion: {
                                    showingBottomView.toggle()
                                    
                                })
                            }
                        }
                        .listRowBackground(index == viewModel.selectRow ? Color.green : .none)
                    }
                }
                .presentationDetents([.medium])
                .presentationContentInteraction(.scrolls)
                .onAppear {
                    withAnimation {
                        proxy1.scrollTo(viewModel.selectRow, anchor: .bottom)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

struct ViewDidLoadModifier: ViewModifier {

    @State private var didLoad = false
    private let action: (() -> Void)?

    init(perform action: (() -> Void)? = nil) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content.onAppear {
            if didLoad == false {
                didLoad = true
                action?()
            }
        }
    }

}

extension View {

    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(ViewDidLoadModifier(perform: action))
    }

}
