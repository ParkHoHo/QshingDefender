//
//  NetworkController.swift
//  QshingDefender
//
//  Created by 박경호 on 11/13/23.
//

import Foundation

struct QRCodeData: Codable {
    var url: String
    var options: String
}

func sendQRCodeToServer(qrCode: QRCodeData, completion: @escaping (Bool) -> Void) {
    guard let url = URL(string: "http://IP주소/API/qr-generator") else {
        print("Invalid URL")
        completion(false)
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
        completion(false)
        return
    }

    URLSession.shared.dataTask(with: request) { data, response, error in
        guard error == nil else {
            print("Network error: \(error?.localizedDescription ?? "Unknown error")")
            completion(false)
            return
        }

        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
            // 성공적으로 전송
            completion(true)
        } else {
            // 실패
            completion(false)
        }
    }.resume()
}
