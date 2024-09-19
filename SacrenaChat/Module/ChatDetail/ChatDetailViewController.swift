//
//  ChatDetailViewController.swift
//  SacrenaChat


import UIKit
import StreamChat

class ChatDetailViewController: UIViewController {
    @IBOutlet weak var profileNavigationView: ProfileNavigationView!
    @IBOutlet weak var chatInputView: ChatInputView!
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var emptyMsgLbl: UILabel!
    @IBOutlet weak var chatInputViewBottomConstraint: NSLayoutConstraint!

    var messageList: [MesageShortestList] = [] {
        didSet {
            chatTableView.reloadData()
            scrollToBottom()
        }
    }
    var viewModel: ChatDetailViewModel? {
        didSet {
            setupViewModelBindings()
        }
    }
    let imagePickerHelper = ImagePickerHelper()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDelegates()
        setupObservers()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func setupUI() {
        registerCells()
    }

    private func setupDelegates() {
        profileNavigationView.delegate = self
        chatInputView.delegate = self
        chatTableView.dataSource = self
        chatTableView.delegate = self
        imagePickerHelper.configure(delegate: self)
    }

    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func registerCells() {
        let receiverNib = UINib(nibName: "ReceiverMessageTVCell", bundle: nil)
        chatTableView.register(receiverNib, forCellReuseIdentifier: "ReceiverMessageTVCell")
        let senderNib = UINib(nibName: "SenderMessgeTVCell", bundle: nil)
        chatTableView.register(senderNib, forCellReuseIdentifier: "SenderMessgeTVCell")
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        adjustForKeyboard(notification: notification, show: true)
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        adjustForKeyboard(notification: notification, show: false)
    }

    private func adjustForKeyboard(notification: NSNotification, show: Bool) {
        let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
        let transform = show ? CGAffineTransform(translationX: 0, y: -keyboardHeight) : .identity
        UIView.animate(withDuration: 0.3) {
            self.chatInputView.transform = transform
            self.view.layoutIfNeeded()
        }
        var contentInset = chatTableView.contentInset
        contentInset.bottom = show ? keyboardHeight : 0
        chatTableView.contentInset = contentInset
        chatTableView.scrollIndicatorInsets = contentInset
        if show {
            scrollToBottom(animated: true)
        }
    }
    
    private func scrollToBottom(animated: Bool = false) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let numberOfSections = self.chatTableView.numberOfSections
            if numberOfSections > 0 {
                let numberOfRows = self.chatTableView.numberOfRows(inSection: numberOfSections - 1)
                if numberOfRows > 0 {
                    let indexPath = IndexPath(row: numberOfRows - 1, section: numberOfSections - 1)
                    self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: animated)
                }
            }
        }
    }

    func setupViewModelBindings() {
        viewModel?.getUpdatedMessage(completion: { [weak self] messages in
            DispatchQueue.main.async {
                self?.messageList = messages
                self?.emptyMsgLbl.isHidden = !messages.isEmpty
            }
        })
        viewModel?.receivedMessages =  { [weak self] messages in
            DispatchQueue.main.async {
                self?.messageList = messages
                self?.emptyMsgLbl.isHidden = !messages.isEmpty
            }
        }
    }
}

extension ChatDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {}
