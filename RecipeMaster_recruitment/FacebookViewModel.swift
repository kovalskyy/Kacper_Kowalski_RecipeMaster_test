//
//  FacebookViewModel.swift
//  RecipeMaster_recruitment
//
//  Created by Moodup on 21.11.2017.
//  Copyright © 2017 Kacper Kowalski. All rights reserved.
//

import Foundation
import RxSwift
import FBSDKLoginKit

protocol FacebookSignInViewModelDelegate: class {
    func didClose()
}

final class FacebookViewModel: ViewModel {
    
    let operationInProgress = Variable(false)
    let errorMessage = PublishSubject<String>()
    
    weak var delegate: FacebookSignInViewModelDelegate!
    
    func facebookHandler(_ loginResult: FBSDKLoginManagerLoginResult?, _ error: Error?) {
        if let error = error {
            log.error(error.localizedDescription)
            errorMessage.onNext(error.localizedDescription)
            return
        }
        
        if loginResult?.isCancelled ?? false {
            log.debug("Facebook login canceled")
            return
        }
    }
}
