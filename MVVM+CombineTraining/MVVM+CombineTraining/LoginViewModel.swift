//
//  LoginViewModel.swift
//  MVVM+CombineTraining
//
//  Created by 上別縄祐也 on 2022/05/27.
//

import Combine

final class LoginViewModel: ObservableObject {
    private let loginModel = LoginModel()
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var userId = ""
    @Published var password = ""
    
    @Published var loginButtonIsEnabled = false
    @Published var validLabelText = ""
    
    init() {
        loginModel.$isValid.assign(to: \.loginButtonIsEnabled, on: self)
            .store(in: &subscriptions)
        loginModel.$isValid.map{ isValid in
            isValid ? "Valid" : "Invalid"
        }.assign(to: \.validLabelText, on: self)
            .store(in: &subscriptions)
        
        $userId.sink { userId in
            self.loginModel.update(userId: userId,
                                   password:  self.password)
        }.store(in: &subscriptions)
        
        $password.sink { password in
            self.loginModel.update(userId: self.userId,
                                   password:  password)
        }.store(in: &subscriptions)
    }
    
    func loginButtonTap() {
        self.loginModel.login()
    }
}
