//
//  NationPopulationData.swift
//  Air Assignment
//
//  Created by Tiago Inácio on 11/11/2024.
//

import Foundation

struct NationPopulationData: Codable {
    let population: Int
    let nation: String
    let year: String
    let id_nation: String
    
    private enum CodingKeys : String, CodingKey {
        case population = "Population", nation = "Nation", year = "Year", id_nation = "ID Nation"
    }
}
