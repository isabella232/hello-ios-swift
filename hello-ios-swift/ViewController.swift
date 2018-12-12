//
//  ViewController.swift
//  LaunchDarklyHelloWorld
//
//  Created by Korhan Bircan on 3/24/17.
//  Copyright © 2017 Korhan Bircan. All rights reserved.
//

import UIKit
import LaunchDarkly

class ViewController: UIViewController {
    @IBOutlet weak var featureFlagLabel: UILabel!

    // Enter your feature flag name here.
    fileprivate let featureFlagKey = "my-flag-key"

    override func viewDidLoad() {
        super.viewDidLoad()

        LDClient.shared.observe(key: featureFlagKey, owner: self) { [weak self] (changedFlag) in
            self?.featureFlagDidUpdate(changedFlag.key)
        }
        checkFeatureValue()
    }

    fileprivate func checkFeatureValue() {
        let featureFlagValue = LDClient.shared.variation(forKey: featureFlagKey, fallback: false)
        updateLabel(value: featureFlagValue)
    }

    fileprivate func updateLabel(value: Bool) {
        featureFlagLabel.text = "\(featureFlagKey): \(value)"
    }

    func featureFlagDidUpdate(_ key: LDFlagKey) {
        if key == featureFlagKey {
            checkFeatureValue()
        }
    }
}
