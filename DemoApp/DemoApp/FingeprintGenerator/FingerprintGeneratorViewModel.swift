//
//  FingerprintGeneratorViewModel.swift
//  DemoApp
//
//  Created by Petr Palata on 22.03.2022.
//

import Combine
import FingerprintKit

class FingerprintGeneratorViewModel: ObservableObject {
    private let fingerprinter = FingerprinterFactory.getInstance()
    
    @Published var loading: Bool = false
    @Published var fingerprintTree: FingerprintTree? = nil
    
    func generateTree() async {
        loading = true
        fingerprintTree = await fingerprinter.getFingerprintTree()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            self.loading = false
        }
    }
    
}
