//
//  ViewController.swift
//  MVC
//
//  Created by Muralidhar reddy Kakanuru on 11/27/24.
//


import UIKit

class ViewController: UIViewController {
    private let userListView = UserListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.addSubview(userListView)
        userListView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            userListView.topAnchor.constraint(equalTo: view.topAnchor),
            userListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userListView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userListView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
