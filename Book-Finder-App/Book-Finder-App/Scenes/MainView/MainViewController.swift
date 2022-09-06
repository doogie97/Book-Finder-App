//
//  MainViewController.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/06.
//

import UIKit

final class MainViewController: UIViewController {
    private let mainView = MainView()
    
    override func loadView() {
        self.view = mainView
    }
}

