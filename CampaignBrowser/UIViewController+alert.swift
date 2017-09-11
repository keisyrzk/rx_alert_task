//
//  UIViewController+alert.swift
//  CampaignBrowser
//
//  Created by keisyrzk on 11.09.2017.
//  Copyright © 2017 Westwing GmbH. All rights reserved.
//

import UIKit
import RxSwift


extension UIViewController {
    
        // we can easily add as many different actions as we want
    enum ActionType {
        case Retry
    }
    
    private func addActions(alertVC: UIAlertController, observer: AnyObserver<ActionType>, actions: [ActionType])
    {
        for action in actions
        {
            switch action
            {
            case .Retry:
                alertVC.addAction(UIAlertAction(title: String.localized(key: .alert_retry_button_title), style: .default, handler: {_ in
                    observer.onNext(.Retry)
                }))
                
                    //here we can add handlings for all our actions
            }
        }
    }
    
    func alert(title: String, text: String?, actions: [ActionType]) -> Observable<ActionType> {
        return Observable.create { [weak self] observer in
            
            let alertVC = UIAlertController(title: title, message: text, preferredStyle: .alert)
            self?.addActions(alertVC: alertVC, observer: observer, actions: actions)
            self?.present(alertVC, animated: true, completion: nil)
            
            return Disposables.create {}
        }
    }
}
