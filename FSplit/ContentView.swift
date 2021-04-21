//
//  ContentView.swift
//  FSplit
//
//  Created by Максим Нуждин on 20.04.2021.
//

import SwiftUI

struct ContentView: View {
    
    let tipArray = [10, 15, 20, 25, 0]
    
    @State private var tipSelected = 0
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    
    var totalAmount: Double {
        guard let doubleCheckAmount = Double(checkAmount) else { return 0.0 }
        let convertedTipAmount = Double(tipArray[tipSelected]) / 100
        let tipAmount = doubleCheckAmount * convertedTipAmount
        
        let result = (doubleCheckAmount + tipAmount)
        return result
    }
    var totalAmountPerPerson: Double {
        guard let convertedNumberOfPeople = Double(numberOfPeople) else { return totalAmount }
        return totalAmount / convertedNumberOfPeople
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    
                    TextField("Check amount: ", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    TextField("Enter number of people", text: $numberOfPeople).keyboardType(.numberPad)
                }
                Section(header: Text("How much tip you want to leave?")) {
                    
                    Picker("tip percentage", selection: $tipSelected) {
                        ForEach(0..<tipArray.count) {
                            
                            Text("\(tipArray[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Total amount")) {
                    if tipArray[tipSelected] == 0{
                        Text("$\(totalAmount, specifier: "%.2f")").foregroundColor(.red)
                    } else {
                        Text("$\(totalAmount, specifier: "%.2f")")
                    }
                    
                }
                Section(header: Text("Amount per person")) {
                    
                    Text("$\(String(format: "%.2f", totalAmountPerPerson))")
                }
            }
            .navigationBarTitle("FSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
