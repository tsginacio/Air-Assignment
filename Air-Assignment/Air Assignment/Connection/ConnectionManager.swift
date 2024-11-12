//
//  NetworkManager.swift
//  Air Assignment
//
//  Created by Tiago Inácio on 11/11/2024.
//

import Foundation

class ConnectionManager{
    private let session: URLSession
        
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    //Get data by State
    func fetchStatePopulationData(for year: String?, completion: @escaping (Result<StatePopulationResponseData, Error>) -> Void) {
        
        //show info from lastest year if is not defined
        var urlString = "https://datausa.io/api/data?drilldowns=State&measures=Population&year=latest"
        if let year = year {
            urlString = "https://datausa.io/api/data?drilldowns=State&measures=Population&year=\(year)"
        }
        
        guard let url = URL( string: urlString) else {
            completion(.failure(ConnectionManagerError.invalidUrl))
            return
        }
        
        let sessionTask = session.dataTask(with: url){ data, response, error in
            if let _ = error {
                completion(.failure(ConnectionManagerError.internetConnectionError))
                return
            }
            
            // Check for valid HTTP response
            if let httpResponse = response as? HTTPURLResponse {
                if !(200...299).contains(httpResponse.statusCode) {
                    completion(.failure(ConnectionManagerError.serverError(statusCode: httpResponse.statusCode)))
                    return
                }
            }
            
            guard let populationResponseData = data else {
                completion(.failure(ConnectionManagerError.noResponseData))
                return
            }
            
            do {
                let decodedPopulationData = try JSONDecoder().decode(StatePopulationResponseData.self, from: populationResponseData)
                completion(.success(decodedPopulationData))
                
            }catch {
                print("catch")
                completion(.failure(ConnectionManagerError.errorOnDecodingResponse))
            }
        }
        sessionTask.resume()
    }
    
    //Get data by Nation
    func fetchNationPopulationData(for year: String?, completion: @escaping (Result<NationPopulationResponseData, Error>) -> Void) {
        //show info from lastest year if is not defined
        var urlString = "https://datausa.io/api/data?drilldowns=Nation&measures=Population&year=latest"
        if let year = year {
            urlString = "https://datausa.io/api/data?drilldowns=Nation&measures=Population&year=\(year)"
        }
        
        guard let url = URL( string: urlString) else {
            completion(.failure(ConnectionManagerError.invalidUrl))
            return
        }
        
        let sessionTask = session.dataTask(with: url){ data, response, error in
            if let _ = error {
                completion(.failure(ConnectionManagerError.internetConnectionError))
                return
            }
            
            // Check for valid HTTP response
            if let httpResponse = response as? HTTPURLResponse {
                if !(200...299).contains(httpResponse.statusCode) {
                    completion(.failure(ConnectionManagerError.serverError(statusCode: httpResponse.statusCode)))
                    return
                }
            }
            
            guard let populationResponseData = data else {
                completion(.failure(ConnectionManagerError.noResponseData))
                return
            }
            
            do {
                let decodedPopulationData = try JSONDecoder().decode(NationPopulationResponseData.self, from: populationResponseData)
                completion(.success(decodedPopulationData))
                
            }catch {
                completion(.failure(ConnectionManagerError.errorOnDecodingResponse))
            }
        }
        sessionTask.resume()
    }
}


