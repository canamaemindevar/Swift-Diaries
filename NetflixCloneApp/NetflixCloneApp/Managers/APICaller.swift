//
//  APICaller.swift
//  NetflixCloneApp
//
//  Created by Emincan on 8.06.2022.
//

import Foundation


struct Constants {
    static let API_KEY = "82507a71929ba8be31ab2904754381b9"
    static let baseURL = "https://api.themoviedb.org"
    static let YoutubeAPI_KEY = "AIzaSyDMDIjUtpyvRI2kbfUt-N5Dy_eVKtvhU3I"
    static let YoutubeBaseUrl = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum APIEror: Error{
    case failedToGetData
}

class APICaller {

  
    static let shared = APICaller()
    
    // MARK: for movies
    
    func getTrendMovies(complition: @escaping (Result<[Title], Error>) -> Void){
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                //  try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                complition(.success(results.results))
               // print(results.results[10].original_title)
                
            } catch {
                complition(.failure(APIEror.failedToGetData))
            }
        }
            task.resume()

    }
    
// MARK: For TV
    
    
    func getTrendingTvs(complition: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else {
                return
        }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                complition(.success(results.results))
            }
            catch{
                complition(.failure(APIEror.failedToGetData))
            }
           
        }
        task.resume()
    }
    
// MARK:  for Upcoming movies
     
    func getUpcomingMovies(complition: @escaping (Result<[Title], Error>) -> Void){
        
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
              do{
                  let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                  //JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                  complition(.success(results.results))
                }
            catch{
                complition(.failure(APIEror.failedToGetData))
            }

        }
        task.resume()
    }
    
    // MARK:  for Popular
    func getPopular(complition: @escaping (Result<[Title], Error>) -> Void){
        
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else {
                return
            }
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                complition(.success(results.results))
            }
            catch {
                complition(.failure(APIEror.failedToGetData))
            }

        }
        task.resume()
    }
    
    //MARK: for Top Rated
    func getTopRated(complition: @escaping (Result<[Title], Error>) -> Void){
        
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                //JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                //
                complition(.success(results.results))
            } catch {
                complition(.failure(APIEror.failedToGetData))
            }
        }
        task.resume()
        
    }
    
    
// MARK: for search page
    
    func getDiscoverMovies(complition: @escaping (Result<[Title], Error>) -> Void){
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return}
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                complition(.success(results.results))
            } catch {
                complition(.failure(APIEror.failedToGetData))
            }

            
            
        }
        task.resume()
        
        
    }
    
    //MARK: for search results
    
    func search(with query: String, complition: @escaping (Result<[Title], Error>) -> Void){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else{return}
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                complition(.success(results.results))
            } catch {
                complition(.failure(APIEror.failedToGetData))
            }

            
            
        }
        task.resume()
        
        
    }
    
    //MARK: youtube query
    
    func getMovie(with query: String,complition: @escaping (Result<VideoElement, Error>) -> Void){
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard  let url = URL(string: "\(Constants.YoutubeBaseUrl)q=\(query)&key=\(Constants.YoutubeAPI_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                complition(.success(results.items[0]))
            } catch {
                complition(.failure(error))
            }

            
            
        }
        task.resume()
    }
    
    
}

//
