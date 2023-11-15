//
//  ResponseController.swift
//  QshingDefender
//
//  Created by 박경호 on 11/14/23.
//

import Foundation

struct ServerResponse: Codable {
    var certificate_verification: Bool
    var detected_sum: Int
}

func sendQRCodeToServer(qrCode: QRCodeData, completion: @escaping (ServerResponse?) -> Void) {
    guard let url = URL(string: "http://IP주소/API/qr-generator") else {
        print("Invalid URL")
        completion(nil)
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    do {
        let jsonData = try JSONEncoder().encode(qrCode)
        request.httpBody = jsonData
    } catch {
        print("Error encoding data: \(error)")
        completion(nil)
        return
    }

    URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            print("Network error: \(error?.localizedDescription ?? "Unknown error")")
            completion(nil)
            return
        }

        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
            do {
                let serverResponse = try JSONDecoder().decode(ServerResponse.self, from: data)
                completion(serverResponse)
            } catch {
                print("Error decoding response: \(error)")
                completion(nil)
            }
        } else {
            // 서버 응답이 200 OK가 아닌 경우
            completion(nil)
        }
    }.resume()
}
