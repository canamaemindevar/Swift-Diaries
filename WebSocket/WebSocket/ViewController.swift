//
//  ViewController.swift
//  WebSocket
//
//  Created by Emincan on 10.10.2022.
//

import UIKit

protocol webSocketable {
    func ping()
    func close()
    func send()
    func recieve()
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?)
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?)
}

class ViewController: UIViewController, URLSessionWebSocketDelegate,webSocketable {

    private var webSocket: URLSessionWebSocketTask?

    override func viewDidLoad() {
        super.viewDidLoad()
      
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        let url = URL(string: "wss://demo.piesocket.com/v3/channel_1?api_key=VCXCEuvhGcBDP7XhiJJUDvR1e1D3eiVjgZ9VRiaV&notify_self")
        webSocket = session.webSocketTask(with: url!)
        webSocket?.resume()
        
    }

    func ping() {
        webSocket?.sendPing(pongReceiveHandler: { error in
            if let error = error {
                print("Ping error\(error)")
            }
        })
    }
    
    func close() {
        webSocket?.cancel(with: .goingAway, reason: "Demo ended".data(using: .utf8))
    }
    
    func send() {
        
        DispatchQueue.global().asyncAfter(deadline: .now()+1){
            self.send()
            self.webSocket?.send(.string("Who are u?\(Int.random(in: 0...1000))"), completionHandler: { error in
                if let error = error {
                    print("Send error: \(error)")
                }
            })
        }
    }
    
    func recieve() {
        webSocket?.receive(completionHandler: { [weak self]result in
            switch result {
            case .success(let message):
                switch message {
                case .data(let data):
                    print("Data:\(data)")
                case .string(let string):
                    print("String: \(string)")
                @unknown default:
                    break
                }
         
            case .failure(let error):
            print("Recieve error: \(error)")
            }
            self?.recieve()
        })
    }
    
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print("Did connect to socket!")
        ping()
        recieve()
        send()
    }
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("Did close connection!")
    }
    

}

