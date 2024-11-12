//
//  ContentView.swift
//  Air Assignment
//
//  Created by Tiago Inácio on 11/11/2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var populationViewModel = PopulationViewModel()
    
    @State private var selectedTab: String = "nation"
    let segments: [String] = ["Nation", "States"]
    
    var body: some View {
        NavigationView {
            VStack{
                //Lists controlled by picker, prettier than tabs
                if selectedTab == "nation" {
                    NationPopulationView()
                } else if selectedTab == "state" {
                    StatePopulationView()
                }
                Spacer()
                VStack{
                    Text("Population Info by")
                        .font(.headline)
                    Picker("Population by", selection: $selectedTab) {
                        Text("Nation").tag("nation")
                        Text("State").tag("state")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .accessibilityIdentifier("populationPicker")
                }
                    .padding()
                    .background(Color("SelectorColor"))
                    .cornerRadius(8)
                    .shadow(radius: 5)
                    .padding()
            }
        }
        .navigationTitle("State Populations test")
        .navigationViewStyle(.stack)
    }
}


