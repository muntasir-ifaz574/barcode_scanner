//
//  ContentView.swift
//  BarcodeScanner
//
//  Created by Muntasir Efaz on 7/6/24.
//

import SwiftUI
import CodeScanner

struct BarcodeScannerView: View {
    @State var isScanned = false
    @State private var scannedCode: String? = "Something wrong!"
    
    var body: some View {
        NavigationStack {
            VStack {
                if isScanned{
                    CodeScannerView(
                        codeTypes: [.qr, .ean13, .ean8, .code128],
                        simulatedData: "484938484",
                        completion: handleScan
                    )
                    .frame(maxWidth: .infinity, maxHeight:  300)
                } else {
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 300)
                }
                
                Spacer().frame(height: 50)
                Button(action: {
                    isScanned.toggle()
                }) {
                    Label("Scanned Barcode", systemImage: "barcode.viewfinder")
                        .font(.title)
                }
                Text(scannedCode ?? "Not Scanned Yet")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(isScanned ? .green : .red)
                    .padding(.top, 10)
            }
            .navigationTitle("Barcode Scanner")
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
            switch result {
            case .success(let code):
                self.scannedCode = code.string
                self.isScanned = false
            case .failure(let error):
                self.scannedCode = "Scanning failed: \(error.localizedDescription)"
                self.isScanned = false
            }
        }
}

#Preview {
    BarcodeScannerView()
}
