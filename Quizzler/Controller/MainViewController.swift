//
//  MainViewController.swift
//  Quizzler
//
//  Created by Sergey Zakurakin on 05/06/2024.
//

import UIKit

final class MainViewController: UIViewController {
    
// MARK: - Properties
    
    var quizBrain = QuizBrain()
    
// MARK: - UISetup
    private lazy var scoreLabel: UILabel = {
        let element = UILabel()
        element.text = "Score: 0.0"
        element.textColor = .black
        element.numberOfLines = 0
        element.font = .boldSystemFont(ofSize: 14)
        element.textAlignment = .center
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    
    private lazy var titleLabel: UILabel = {
        let element = UILabel()
        element.text = "Four + Two is equal to Six"
        element.textColor = .white
        element.numberOfLines = 0
        element.font = .boldSystemFont(ofSize: 24)
        element.textAlignment = .center
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var trueButton: UIButton = {
        let element = UIButton()
        element.backgroundColor = .systemBlue
        element.layer.cornerRadius = 15
        element.setTitle("True", for: .normal)
        element.setTitleColor(.white, for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        element.addTarget(self, action: #selector(answerButtonPressed), for: .touchUpInside)
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var falseButton: UIButton = {
        let element = UIButton()
        element.backgroundColor = .systemBlue
        element.layer.cornerRadius = 15
        element.setTitle("False", for: .normal)
        element.setTitleColor(.white, for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        element.addTarget(self, action: #selector(answerButtonPressed), for: .touchUpInside)
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var progressView: UIProgressView = {
        let element = UIProgressView()
        element.trackTintColor = .white
        element.progressTintColor = .magenta
        element.setProgress(0, animated: true)
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    // MARK: - Private Methods
    @objc private func answerButtonPressed(_ sender: UIButton){
        let userCurrentAnswer = sender.currentTitle ?? ""
        let userGotItRight = quizBrain.checkAnswer(for: userCurrentAnswer)
        quizBrain.nextQuestion()
        sender.backgroundColor = userGotItRight ? .green : .red
        updateUI()
        
    }
    
    private func updateUI() {
        titleLabel.text = quizBrain.getQuestionText()
        progressView.progress = quizBrain.getProgress()
        scoreLabel.text = "Score: \(quizBrain.getScore())"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.trueButton.backgroundColor = .systemBlue
            self.falseButton.backgroundColor = .systemBlue
        }
        
    }
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraint()
        updateUI()
    }
}

// MARK: - Setup View and Constraint
extension MainViewController {
    
    private func setupView() {
        view.backgroundColor = .systemIndigo
        view.addSubview(titleLabel)
        view.addSubview(scoreLabel)
        
        view.addSubview(trueButton)
        view.addSubview(falseButton)
        view.addSubview(progressView)
        
        
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            titleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            scoreLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            scoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
//            scoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            
            
            
            progressView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            trueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -120),
            trueButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            trueButton.heightAnchor.constraint(equalToConstant: 60),
            trueButton.widthAnchor.constraint(equalToConstant: 200),
            
            falseButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            falseButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            falseButton.heightAnchor.constraint(equalToConstant: 60),
            falseButton.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
}
