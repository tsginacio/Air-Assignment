//
//  NationPopulationView.swift
//  Air Assignment
//
//  Created by Tiago Inácio on 11/11/2024.
//

import SwiftUI

struct NationPopulationView: View {
    
    @StateObject private var populationViewModel = PopulationViewModel()
        
    var body: some View {
        VStack {
            if populationViewModel.isLoading {
                VStack(alignment: .center) {
                    ProgressView("Loading Data...")
                        .progressViewStyle(CircularProgressViewStyle())
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center) 
                
            } else if let errorMessage = populationViewModel.errorMessage {
                //Popup red for errors
                VStack {
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.white)
                            .padding(.leading, 10)

                        VStack(alignment: .leading) {
                            Text("Something went wrong")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text(errorMessage)
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                        .padding(.leading, 10)
                    }
                    .padding()
                    .background(Color.red) // Error background color
                    .cornerRadius(8)
                    .shadow(radius: 5)
                    .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top) // Position at the top of the screen
                
            } else {
                List(populationViewModel.nationPopulationData, id: \.id_nation) { data in
                    VStack(alignment: .leading) {
                        HStack{
                            Text(data.nation)
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            //last update year
                            Text("\(data.year)")
                                .font(.subheadline)
                                .foregroundColor(.orange)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                
                        }
                        Text("Population: \(data.population) people")
                    }
                }
                
                
            }
        }
        .navigationTitle("Nations")
        .onAppear {
            populationViewModel.fetchNationPopulationData(year: nil)
        }
    }
}
