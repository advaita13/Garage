//
//  SafariExtensionViewController.swift
//  GoJIRA Extension
//
//  Created by Pandya, Advaita | Adi | RP on 2020/02/13.
//  Copyright © 2020 AdiPadi. All rights reserved.
//

import SafariServices

class SafariExtensionViewController: SFSafariExtensionViewController {
    
    static let shared: SafariExtensionViewController = {
        let shared = SafariExtensionViewController()
        shared.preferredContentSize = NSSize(width:320, height:240)
        return shared
    }()

}
