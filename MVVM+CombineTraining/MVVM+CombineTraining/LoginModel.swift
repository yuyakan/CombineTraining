//
//  LoginModel.swift
//  MVVM+CombineTraining
//
//  Created by 上別縄祐也 on 2022/05/27.
//

import Combine

final class LoginModel {
    private(set) var userId = ""
    private(set) var password = ""
    @Published private(set) var isValid = false
    
    func update(userId: String, password: String) {
        self.userId = userId
        self.password = password
        isValid = userId.count >= 4 && password.count >= 4
    }
    
    func login() {
        print("login userId: \(userId) password:\(password)")
    }
}
