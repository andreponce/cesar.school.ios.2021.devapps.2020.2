//
//  REST.swift
//  Carangas
//
//  Created by Douglas Frari on 9/3/21.
//  Copyright © 2021 Eric Brito. All rights reserved.
//

import Foundation
import Alamofire

enum CarError {
    case url
    case taskError(error: Error)
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJSON
}

enum RESTOperation {
    case save
    case update
    case delete
}

class REST {
    
    // URL + endpoint do get da lista de marcas
    private static let basePath = "https://carangas.herokuapp.com/cars"
    
    // baseada no servico: https://deividfortuna.github.io/fipe/
    private static let urlFipe = "https://parallelum.com.br/fipe/api/v1/carros/marcas"
    
    
    // session criada automaticamente e disponivel para reusar
    
    /*private static let session = URLSession(configuration: configuration)
    
    
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = true
        config.httpAdditionalHeaders = ["Content-Type":"application/json"]
        config.timeoutIntervalForRequest = 10.0
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()*/
    
    
    // o metodo pode retornar um array de nil se tiver algum erro
    static func loadBrands(onComplete: @escaping ([Brand]?) -> Void) {
        
        guard let url = URL(string: urlFipe) else {
            onComplete(nil)
            return
        }
        
        AF.request(url)
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseData{ response in
            
            if(response.data==nil){
                onComplete(nil)
                return
            }
            
            let networkResponse = response as? HTTPURLResponse
            
            switch response.result {
                case .success:
                    do {
                        let brands = try JSONDecoder().decode([Brand].self, from: response.data!)
                        onComplete(brands)
                        print("success", brands)
                    } catch {
                        onComplete(nil)
                    }
                case .failure:
                    if((networkResponse) != nil) {
                        onComplete(nil)
                    }else {
                        onComplete(nil)
                    }
                    print("failure", response.error)
            }
        }
        
        
        
        // tarefa criada, mas nao processada
        /*let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {
                    onComplete(nil)
                    return
                }
                if response.statusCode == 200 {
                    // obter o valor de data
                    guard let data = data else {
                        onComplete(nil)
                        return
                    }
                    do {
                        let brands = try JSONDecoder().decode([Brand].self, from: data)
                        onComplete(brands)
                    } catch {
                        // algum erro ocorreu com os dados
                        onComplete(nil)
                    }
                } else {
                    onComplete(nil)
                }
            } else {
                onComplete(nil)
            }
        }
        // start request
        dataTask.resume()*/
    }
    
    
    // retorno na closure o argumento onComplete para SUCESSO ou onError para falhas
    static func loadCars(onComplete: @escaping ([Car]) -> Void, onError: @escaping (CarError) -> Void) {
        
        guard let url = URL(string: basePath) else {
            onError(.url)
            return
        }
        
        AF.request(url)
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseData{ response in
            if(response.data==nil){
                onError(.noData)
                return
            }
            
            let networkResponse = response as? HTTPURLResponse
            
            switch response.result {
                case .success:
                    do {
                        let cars = try JSONDecoder().decode([Car].self, from: response.data!)
                        onComplete(cars)
                        print("success", cars)
                    } catch {
                        onError(.invalidJSON)
                    }                    
                case .failure:
                    if((networkResponse) != nil) {
                        onError(.responseStatusCode(code: networkResponse!.statusCode))
                    }else {
                        onError(.noResponse)
                    }
                    print("failure", response.error)
            }
        }
        
        
        
        // tarefa criada, mas nao processada
        /*let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            // 1
            if error == nil {
                
                // 2
                guard let response = response as? HTTPURLResponse else {
                    onError(.noResponse)
                    return
                }
                if response.statusCode == 200 {
                    
                    // servidor respondeu com sucesso :)
                    
                    // 3
                    // obter o valor de data
                    guard let data = data else {
                        onError(.noData)
                        return
                    }
                    
                    do {
                        let cars = try JSONDecoder().decode([Car].self, from: data)
                        onComplete(cars)
                    } catch {
                        onError(.invalidJSON)
                    }
                } else {
                    onError(.responseStatusCode(code: response.statusCode))
                }
                
            } else {
                onError(.taskError(error: error!))
            }
            
        }
        // start request
        dataTask.resume()*/
    }
    
    
    // retorno verdade se foi possivel salvar, false caso contrario
    static func save(car: Car, onComplete: @escaping (Bool) -> Void, onError: @escaping (CarError) -> Void ) {
        print("save")
        applyOperation(car: car, operation: .save, onComplete: onComplete, onError: onError)
    }
    
    // retorno verdade se foi possivel salvar, false caso contrario
    static func update(car: Car, onComplete: @escaping (Bool) -> Void, onError: @escaping (CarError) -> Void ) {
        print("update")
        applyOperation(car: car, operation: .update, onComplete: onComplete, onError: onError)
    }
    
    static func delete(car: Car, onComplete: @escaping (Bool) -> Void, onError: @escaping (CarError) -> Void ) {
        print("delete")
        applyOperation(car: car, operation: .delete, onComplete: onComplete, onError: onError)
    }
    
    
    private static func applyOperation(car: Car, operation: RESTOperation , onComplete: @escaping (Bool) -> Void, onError: @escaping (CarError) -> Void ) {
        
        /*guard let json = try? JSONEncoder().encode(car) as? [String: Any] else {
            print("erro json encode")
            onComplete(false)
            return
        }
        
        // o endpoint do servidor para update é: URL/id
        let urlString = basePath + "/" + (car._id ?? "")
        
        guard let url = URL(string: urlString) else {
            print("erro url")
            onComplete(false)
            return
        }
        
        var httpMethod: HTTPMethod? = nil
        
        switch operation {
            case .delete:
                httpMethod = .delete
            case .save:
                httpMethod = .post
            case .update:
                httpMethod = .put
        }
        print(url)
        AF.request(url, method: httpMethod ?? .get, parameters: json, encoding: JSONEncoding.default, headers: nil)
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .responseData{ response in
            switch response.result {
                case .success:
                    print("success")
                    onComplete(true)
                case .failure:
                    onComplete(false)
                    print("failure", response.error, response.response?.statusCode)
            }
        }*/
        
        
        let urlString = basePath + "/" + (car._id ?? "")

        guard let url = URL(string: urlString) else {
            onComplete(false)
            return
        }

        var request = URLRequest(url: url)

        switch operation {
        case .delete:
            request.httpMethod = HTTPMethod.delete.rawValue
        case .save:
            request.httpMethod = HTTPMethod.post.rawValue
        case .update:
            request.httpMethod = HTTPMethod.put.rawValue
        }

        // transformar objeto para um JSON, processo contrario do decoder -> Encoder
        guard let json = try? JSONEncoder().encode(car) else {
            onComplete(false)
            return
        }

        request.httpBody = json
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        AF.request(request).validate().responseJSON{ response in
            guard let responseFinal = response.response else {
                onError(.noResponse)
                return
            }
            
            if responseFinal.statusCode == 200 {
                onComplete(true)
            }else{
                onError(.responseStatusCode(code: response.response!.statusCode))
            }
        }
        
        
        /*var request = URLRequest(url: url)
        var httpMethod: String = ""
        
        switch operation {
            case .delete:
                httpMethod = "DELETE"
            case .save:
                httpMethod = "POST"
            case .update:
                httpMethod = "PUT"
        }
        request.httpMethod = httpMethod
        
        // transformar objeto para um JSON, processo contrario do decoder -> Encoder
        guard let json = try? JSONEncoder().encode(car) else {
            onComplete(false)
            return
        }
        request.httpBody = json
        
        let dataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                // verificar e desembrulhar em uma unica vez
                guard let response = response as? HTTPURLResponse, response.statusCode == 200, let _ = data else {
                    onComplete(false)
                    return
                }
                
                // ok
                onComplete(true)
                
            } else {
                onComplete(false)
            }
        }
        
        dataTask.resume()*/
    }
    
} // fim da classe REST
