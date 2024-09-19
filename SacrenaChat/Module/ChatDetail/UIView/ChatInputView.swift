//
//  ChatInputView.swift
//  SacrenaChat
//


import UIKit

protocol ChatInputViewDelegate: AnyObject {
    func didPressSendButton(withText text: String)
    func didPressCameraButton()
    func didupdateTextViewHeight(_ height: CGFloat)
}

class ChatInputView: UIView, UITextViewDelegate {
    weak var delegate: ChatInputViewDelegate?
    private let cameraButton = UIButton(type: .system)
    private let textView = UITextView()
    private let sendButton = UIButton(type: .system)
    private let topSepratorLbl: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    private func setupView() {
        backgroundColor = .appBg // Background color for the input view
        // Configure camera button
        cameraButton.setImage(UIImage(systemName: "camera"), for: .normal)
        cameraButton.tintColor = .white
        cameraButton.addTarget(self, action: #selector(cameraButtonTapped), for: .touchUpInside)
        // Configure send button
        sendButton.setBackgroundImage(UIImage(systemName: "arrow.up.circle.fill"), for: .normal)
        sendButton.tintColor = .lightGray
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        // Configure text view
        textView.layer.cornerRadius = 15
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textColor = .white
        textView.delegate = self
        textView.isScrollEnabled = false
        textView.backgroundColor = .appBg
        textView.tintColor = .white
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)
        textView.returnKeyType = .done
        topSepratorLbl.backgroundColor = UIColor.border
        
        addSubview(topSepratorLbl)
        addSubview(cameraButton)
        addSubview(textView)
        addSubview(sendButton)
        setupConstraints()
    }
    private func setupConstraints() {
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        topSepratorLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topSepratorLbl.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            topSepratorLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            topSepratorLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            topSepratorLbl.heightAnchor.constraint(equalToConstant: 1),
            
            cameraButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cameraButton.widthAnchor.constraint(equalToConstant: 40),
            cameraButton.heightAnchor.constraint(equalToConstant: 40),
            sendButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            sendButton.widthAnchor.constraint(equalToConstant: 30),
            sendButton.heightAnchor.constraint(equalToConstant: 30),
            textView.leadingAnchor.constraint(equalTo: cameraButton.trailingAnchor, constant: 8),
            textView.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -8),
            textView.topAnchor.constraint(equalTo: topSepratorLbl.bottomAnchor, constant: 15),
            textView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24),
            sendButton.centerYAnchor.constraint(equalTo: textView.centerYAnchor),
            cameraButton.centerYAnchor.constraint(equalTo: textView.centerYAnchor)
        ])
    }
    // Button actions
    @objc private func cameraButtonTapped() {
        delegate?.didPressCameraButton()
    }
    @objc private func sendButtonTapped() {
        if textView.text.trimmingCharacters(in: .whitespaces).count > 0 {
            delegate?.didPressSendButton(withText: textView.text)
            textView.text = nil
            sendButton.tintColor = .lightGray
            textView.layer.borderColor = UIColor.lightGray.cgColor
            textView.resignFirstResponder()
            updateTextViewHeight()
        }
    }
    // UITextViewDelegate method to handle text changes
    func textViewDidChange(_ textView: UITextView) {
        let isContentText = textView.text.trimmingCharacters(in: .whitespaces).count > 0
        sendButton.tintColor = isContentText ? UIColor(named: "SendButtonColor") : .lightGray
        textView.layer.borderColor = isContentText ? UIColor.white.cgColor : UIColor.lightGray.cgColor
        updateTextViewHeight()
    }
    private func updateTextViewHeight() {
        let size = CGSize(width: textView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.isScrollEnabled = estimatedSize.height > 77
        if estimatedSize.height > 35 {
            delegate?.didupdateTextViewHeight(estimatedSize.height)
        } else {
            delegate?.didupdateTextViewHeight(30)
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            print("Return key tapped!")
            return false
        }
        return true
    }

}
