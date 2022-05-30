//
//  ViewController.swift
//  MVVM+Combine_Storyboard
//
//  Created by 上別縄祐也 on 2022/05/29.
//

import Combine
import CombineCocoa
import UIKit

class LoginViewController: UIViewController {
    private var subscriptions = Set<AnyCancellable>()
    private var viewModel = LoginViewModel()

    //ji
    @IBOutlet private var userIdTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var loginButton: UIButton!
    @IBOutlet private var validLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userIdTextField.textPublisher
            .sink(receiveValue:  viewModel.userId.send)
            .store(in: &subscriptions)
        passwordTextField.textPublisher
            .sink(receiveValue: viewModel.password.send)
            .store(in: &subscriptions)
        loginButton.tapPublisher
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink(receiveValue: viewModel.loginButtonTap.send)
            .store(in: &subscriptions)
        
        viewModel.loginButtonIsEnabled
            .assign(to: \.isEnabled, on: loginButton)
            .store(in: &subscriptions)
        viewModel.validLabelText
            .assign(to: \.text, on: validLabel)
            .store(in: &subscriptions)
    }
}

