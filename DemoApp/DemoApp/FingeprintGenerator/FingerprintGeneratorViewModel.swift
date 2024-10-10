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

@MainActor
final class FingerprintGeneratorViewModel: ObservableObject {

    private let fingerprinter = FingerprinterFactory.getInstance()

    @Published private(set) var state: FingerprintGeneratorState = .notGenerated

    func generateTree() async {
        state = .generating
        let fingerprintTree = await fingerprinter.getFingerprintTree()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.state = .fingerprintReady(fingerprintTree)
        }
    }
}
