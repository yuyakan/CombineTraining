//
//  LoginViewModel.swift
//  MVVM+Combine_Storyboard
//
//  Created by 上別縄祐也 on 2022/05/29.
//

import Combine

final class LoginViewModel {
    private var subscriptions = Set<AnyCancellable>()
    private let loginModel = LoginModel()
    
    let userId = CurrentValueSubject<String?, Never>(nil)
    let password = CurrentValueSubject<String?, Never>(nil)
    let loginButtonTap = PassthroughSubject<Void, Never>()
    let loginButtonIsEnabled: AnyPublisher<Bool, Never>
    let validLabelText: AnyPublisher<String?, Never>
    
    init() {
        loginButtonIsEnabled = loginModel.$isValid
            .map { $0 }
            .eraseToAnyPublisher()
        validLabelText = loginModel.$isValid
            .map { isValid in
                isValid ? "Valid" : "Invalid"
            }
            .eraseToAnyPublisher()
        userId.compactMap { $0 }
        .combineLatest(password.compactMap { $0 })
        .sink { userId, password in
            self.loginModel.update(userId: userId,
                                   password:  password)
        }.store(in: &subscriptions)
        loginButtonTap
            .sink {
                self.loginModel.login()
            }
            .store(in: &subscriptions)
    }
}

