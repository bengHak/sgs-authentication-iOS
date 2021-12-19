//
//  SignUpViewController.swift
//  Personal-project
//
//  Created by bhakko-MN on 2021/12/17.
//

import UIKit
import SnapKit
import Then
import RxSwift

class SignUpViewController: UIViewController {

    // MARK: - UI Properties
    private let labelSignup = UILabel().then {
        $0.text = "회원가입 뷰"
        $0.font = .systemFont(ofSize: 40)
    }

    // email 입력 필드
    private let textFieldEmail = UITextField().then {
        $0.placeholder = "이메일을 입력하세요"
        $0.borderStyle = .roundedRect
        $0.keyboardType = .emailAddress
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
    }

    // username 입력 필드
    private let textFieldUsername = UITextField().then {
        $0.placeholder = "유저네임을 입력하세요"
        $0.borderStyle = .roundedRect
    }

    // password 입력 필드
    private let textFieldPassword = UITextField().then {
        $0.placeholder = "비밀번호를 입력하세요"
        $0.borderStyle = .roundedRect
        $0.isSecureTextEntry = true
    }

    // password 확인 입력 필드
    private let textFieldPasswordConfirm = UITextField().then {
        $0.placeholder = "비밀번호를 한번 더 입력하세요"
        $0.borderStyle = .roundedRect
        $0.isSecureTextEntry = true
    }

    // password 불일치 에러 문구
    private let labelPasswordError = UILabel().then {
        $0.text = "비밀번호가 일치하지 않습니다"
        $0.textColor = .red
        $0.isHidden = true
    }

    // 회원가입 버튼
    private let buttonSignup = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.layer.cornerRadius = 10
    }

    // MARK: - Properties
    var bag = DisposeBag()
    var viewModel = SignUpViewModel()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        configureView()
        bind()
    }

}

extension SignUpViewController {
    func configureView() {
        view.addSubview(labelSignup)
        view.addSubview(textFieldEmail)
        view.addSubview(textFieldUsername)
        view.addSubview(textFieldPassword)
        view.addSubview(textFieldPasswordConfirm)
        view.addSubview(labelPasswordError)
        view.addSubview(buttonSignup)
        
        labelSignup.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            $0.centerX.equalToSuperview()
        }

        textFieldEmail.snp.makeConstraints {
            $0.top.equalTo(labelSignup.snp.bottom).offset(100)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        textFieldUsername.snp.makeConstraints {
            $0.top.equalTo(textFieldEmail.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        textFieldPassword.snp.makeConstraints {
            $0.top.equalTo(textFieldUsername.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        textFieldPasswordConfirm.snp.makeConstraints {
            $0.top.equalTo(textFieldPassword.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        labelPasswordError.snp.makeConstraints {
            $0.top.equalTo(textFieldPasswordConfirm.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        buttonSignup.snp.makeConstraints {
            $0.top.equalTo(textFieldPasswordConfirm.snp.bottom).offset(100)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
    }
}

extension SignUpViewController {
    func bind() {
        bindTextField()
        bindButton()
        bindViewModel()
    }

    func bindTextField() {
        textFieldEmail.rx.text.orEmpty
            .subscribe(onNext: { [weak self] email in
                self?.viewModel.input.email = email
            })
            .disposed(by: bag)

        textFieldUsername.rx.text.orEmpty
            .subscribe(onNext: { [weak self] username in
                self?.viewModel.input.username = username
            })
            .disposed(by: bag)

        textFieldPassword.rx.text.orEmpty
            .subscribe(onNext: { [weak self] password in
                self?.viewModel.input.password = password
            })
            .disposed(by: bag)

        textFieldPasswordConfirm.rx.text.orEmpty
            .subscribe(onNext: { [weak self] passwordConfirm in
                self?.viewModel.input.passwordConfirm = passwordConfirm
                if self?.viewModel.input.password == self?.viewModel.input.passwordConfirm {
                    self?.labelPasswordError.isHidden = true
                } else {
                    self?.labelPasswordError.isHidden = false
                }
            })
            .disposed(by: bag)
    }

    func bindButton() {
        buttonSignup.rx.tap
            .subscribe(onNext: { [weak self] in
                print("hello")
                self?.viewModel.signUp()
            })
            .disposed(by: bag)
    }

    func bindViewModel() {
        viewModel.output.isSignedUp
            .subscribe(onNext: { [weak self] isSignedUp in
                guard let self = self else { return }
                if isSignedUp {
                    DispatchQueue.main.async {
                        self.setNeedsStatusBarAppearanceUpdate()
                        let navigationController = UINavigationController(rootViewController: HomeViewController())
                        self.view.window?.rootViewController = navigationController
                        self.view.window?.makeKeyAndVisible()
                    }
                }
            })
            .disposed(by: bag)
    }
}
