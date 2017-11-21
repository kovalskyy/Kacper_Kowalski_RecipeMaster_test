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
        // TODO: token
//        guard let token = loginResult?.token.tokenString else { return }
        //authenticateWithFacebook(accessToken: token)
    
    
    //protocol FacebookSignInViewModelDelegate: class {
    //    func didClose()
    //}
    
//    private func authenticateWithFacebook(accessToken token: String) {
//        operationInProgress.value = true
//
//        let onNext: (Account) -> Void = { [weak self] _ in
//            self?.delegate.didClose()
//        }
//
//        let onError: (Swift.Error) -> Void = { [weak self] error in
//            log.error(error)
//            self?.operationInProgress.value = false
//            self?.errorMessage.onNext(error.localizedDescription)
//        }
//    }
//        authenticateWithFacebook(accessToken: token)
//            .subscribe(onNext: onNext, onError: onError)
//            .disposed(by: disposeBag)
//    }
 
}
