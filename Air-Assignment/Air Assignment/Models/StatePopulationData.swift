//
//  PopulationData.swift
//  Air Assignment
//
//  Created by Tiago Inácio on 11/11/2024.
//

import Foundation

struct StatePopulationData: Codable {
    let population: Int
    let state: String
    let year: String
    let id_state: String
    
    private enum CodingKeys : String, CodingKey {
        case population = "Population", state = "State", year = "Year", id_state = "ID State"
    }
    
}
