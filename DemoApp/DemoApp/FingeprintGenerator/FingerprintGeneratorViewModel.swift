//
//  FingerprintGeneratorViewModel.swift
//  DemoApp
//
//  Created by Petr Palata on 22.03.2022.
//

import Combine
import FingerprintJS

enum FingerprintGeneratorState {
    case notGenerated
    case generating
    case fingerprintReady(FingerprintTree)
}

class FingerprintGeneratorViewModel: ObservableObject {
    private let fingerprinter = FingerprinterFactory.getInstance()
    
    @Published var state: FingerprintGeneratorState = .notGenerated
    @Published var loading: Bool = false
    @Published var fingerprintTree: FingerprintTree? = nil
    
    func generateTree() async {
        state = .generating
        fingerprintTree = await fingerprinter.getFingerprintTree()
        if let fingerprintTree = fingerprintTree {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) { [weak self] in
                self?.state = .fingerprintReady(fingerprintTree)
            }
        } else {
            state = .notGenerated
        }
    }
    
}
