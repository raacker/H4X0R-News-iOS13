//
//  NetworkManager.swift
//  H4X0R News
//
//  Created by Haven on 2022-04-16.
//

import Foundation

class NetworkManager: ObservableObject {
    @Published var posts = [Post]()
    
    let frontPageURL = "http://hn.algolia.com/api/v1/search?tags=front_page"
    
    func fetchFrontPage() {
        fetchData(url: frontPageURL)
    }
    
    func fetchData(url urlString: String) {
        guard let url = URL(string: urlString) else {
            print ("Cannot create URL Object")
            return
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let e = error {
                print ("Failed to fetch data from the url \(urlString)")
                return
            }
            
            guard let data = data else {
                print ("Wrong data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let results = try decoder.decode(Results.self, from: data)
                
                DispatchQueue.main.async {
                    self.posts = results.hits
                }
            } catch {
                print (error)
            }
        }
        
        task.resume()
    }
}
