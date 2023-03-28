//
//  ContentView.swift
//  iConvert
//
//  Created by luis armendariz on 3/27/23.
//

import SwiftUI

struct ContentView: View {
    @State private var input = ""
    @State private var inputUnit: LengthType = .feet
    @State private var outputUnit: LengthType = .feet
    @State private var lengthFeet = Measurement(value: 1, unit: UnitLength.feet)
    @State private var lengthYard = Measurement(value: 1, unit: UnitLength.yards)
    @State private var lengthMiles = Measurement(value: 1, unit: UnitLength.miles)
    @State private var lengthMeters = Measurement(value: 1, unit: UnitLength.meters)
    @State private var lengthKiloMeters = Measurement(value: 1, unit: UnitLength.kilometers)
    
    enum LengthType: String,CaseIterable{
        case feet = "Feet"
        case yards = "Yards"
        case miles = "Miles"
        case meters = "Meters"
        case kilometers = "Kilometers"
    }
    
    var conversion: Double {
        guard let inputAmount = Double(input) else { return 0}
        var conversionInput = 0.0
        var conversionResult = 0.0
        
        switch inputUnit {
        case .feet:
            conversionInput = inputAmount
        case .yards:
            conversionInput = inputAmount / 3
        case .miles:
            conversionInput = inputAmount / 0.000189
        case .meters:
            conversionInput = inputAmount / 0.304
        case .kilometers:
            conversionInput = inputAmount / 0.000305
        }
        
        switch outputUnit {
        case .feet:
            conversionResult = conversionInput
        case .yards:
            conversionResult = conversionInput / 3
        case .miles:
            conversionResult = conversionInput / 5280
        case .meters:
            conversionResult = conversionInput / 3.28084
        case .kilometers:
            conversionResult = conversionInput / 3280.84
        }
        
        return conversionResult
    }
    
    var body: some View {
        VStack {
            NavigationStack {
                Form {
                    Section {
                        TextField("Enter Amount", text: $input)
                        
                        Picker("Input Amount", selection: $inputUnit) {
                            ForEach(LengthType.allCases, id: \.self){
                                Text($0.rawValue)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                    }header: {
                        Text("Enter value")
                    }
                    
                    
                    Section {
                        Picker("Input Amount", selection: $outputUnit){
                            ForEach(LengthType.allCases, id: \.self){
                                Text($0.rawValue)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        Text("\(conversion, specifier: "%.2f")")
                    }header: {
                        Text("Result")
                    }
                    
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
