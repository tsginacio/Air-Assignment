//
//  PopulationViewModel.swift
//  Air Assignment
//
//  Created by Tiago Inácio on 11/11/2024.
//

import Foundation

class PopulationViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var statePopulationData : [StatePopulationData] = []
    @Published var nationPopulationData : [NationPopulationData] = []
    @Published var searchText = ""
    
    func fetchStatePopulationData(year: String?){
        isLoading = true
        
        ConnectionManager().fetchStatePopulationData(for: year) { result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let data):
                        self.statePopulationData = data.data
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                }
                self.isLoading = false
            }
        }
    }
    
    func fetchNationPopulationData(year: String?){
        isLoading = true
        
        ConnectionManager().fetchNationPopulationData(for: year) { result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let data):
                        self.nationPopulationData = data.data
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                }
                self.isLoading = false
            }
        }
    }
    
    
}
