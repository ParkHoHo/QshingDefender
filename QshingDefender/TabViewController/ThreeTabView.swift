//
//  TabView.swift
//  QshingDefender
//
//  Created by 박경호 on 11/13/23.
//

import SwiftUI

struct ThreeTabView: View {
    @AppStorage("_isFirstLaunching") var isFirstLaunching: Bool = true
    @State private var scannedCode: String?
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var openURL = false
    
    var body: some View {
        TabView {
            
            //MARK: - Home 화면
            
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
             
            //MARK: - QRCODE Scanner 화면
            VStack(alignment: .center) {
                if let scannedCode = scannedCode {
                    
                    HStack {
                        Button(action: {
                            self.scannedCode = nil
                            
                        }) {
                            Image(systemName: "arrowshape.backward")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                        }
                        Spacer() // 버튼을 왼쪽으로 정렬
                    }
                    .padding(.leading) // 왼쪽 패딩 추가
                    
                    

                    Text("Scanned Code: \(scannedCode)")
                        .padding(.top) // 텍스트와 버튼 사이의 상단 패딩

                    Spacer()
                        .frame(height: 30)
                    Button("서버에 전송") {
                        sendQRCodeData(scannedCode)
                    }
                    Spacer()
                        .frame(height: 30)
                   
                } else {
                    QRCodeScannerView(scannedCode: $scannedCode)
                        .edgesIgnoringSafeArea(.all)
                }
                
            }
            .onChange(of: scannedCode) { newValue in
                if let newCode = newValue {
                    passQRcertificate(newCode)
                }
            }
            .tabItem {
                Image(systemName: "qrcode")
                Text("QRCode Scanner")
            }
            
            //MARK: - Settings 화면
            SettingView()
        }
        
        .font(.headline)
        .fullScreenCover(isPresented: $isFirstLaunching) {
            OnboardingTabView(isFirstLaunching: $isFirstLaunching)
            
        }
        
        
        .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text(alertMessage),
                        dismissButton: .default(Text("확인")) {
                            // 여기서 URL 열기 로직 추가
                            if openURL, let url = URL(string: scannedCode ?? ""), UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.open(url)
                            }
                            openURL = false // 상태 변수 초기화
                        }
                    )
                }
    }
    
    private func passQRcertificate(_ scannedCode : String) {
        // 특정 IP로 시작하는지 확인할 패턴 (예: "192.168.0.")
            let ourQRIpPrefix = "IP주소"

            // scannedCode에서 URL을 생성
            if let url = URL(string: scannedCode), let host = url.host {
                print(host)
                // 호스트 IP가 우리 QR IP로 시작하는지 확인
                if host.hasPrefix(ourQRIpPrefix) {
                    // 우리 QR IP로 시작하면 검증을 건너뛰고 바로 URL로 이동
                    
                    
                    openURL = true
                    showAlert = true
                
                }
            }
        
        print(openURL)
        
        if openURL {
            alertMessage = "우리 QR 코드로 인증됨, URL로 바로 이동합니다."
            showAlert = true
        }

    }
    
    private func sendQRCodeData(_ scannedCode: String) {
        // 먼저 QR 코드가 우리가 정의한 IP로 시작하는지 확인합니다.
        

        // 만약 openURL이 true로 설정되었다면, URL로 바로 이동합니다.
        if openURL {
            alertMessage = "우리 QR 코드로 인증됨, URL로 바로 이동합니다."
            showAlert = true
        } else {
            // 우리가 정의한 QR 코드가 아닐 경우, 서버로 데이터를 전송합니다.
            let qrData = QRCodeData(url: scannedCode, options: "only_verify")
            sendQRCodeToServer(qrCode: qrData) { response in
                DispatchQueue.main.async {
                    guard let response = response else {
                        alertMessage = "응답 처리에 실패했습니다"
                        showAlert = true
                        return
                    }
                    
                    setupAlertMessage(response: response)
                }
            }
        }
    }


    private func setupAlertMessage(response: ServerResponse) {
        var messageParts: [String] = []

        if response.certificate_verification {
            messageParts.append("안전한 인증서가 발급된 사이트입니다\n")
        } else {
            messageParts.append("미인증된 인증서가 발급된 사이트입니다\n")
        }

        if response.detected_sum > 0 {
            messageParts.append("악성 링크로 탐지되었습니다")
        } else {
            messageParts.append("악성 링크로 탐지되지 않았습니다")
        }

        alertMessage = messageParts.joined(separator: "\n")
        openURL = response.certificate_verification && response.detected_sum == 0
        showAlert = true
    }

}
