//
//  String+localized.swift
//  CampaignBrowser
//
//  Created by keisyrzk on 11.09.2017.
//  Copyright © 2017 Westwing GmbH. All rights reserved.
//

import Foundation

extension String {
    
    public enum TranslationKey: Int {
    
        case alert_error_title
        case alert_no_internet_connection_message
        case alert_retry_button_title
    }
    
    public static func localized(key: TranslationKey, defaultValue: String = "") -> String {
        let localizedString = NSLocalizedString("\(key)", bundle: Bundle.main, value: defaultValue, comment: "\(key)")
        return localizedString
    }
}
