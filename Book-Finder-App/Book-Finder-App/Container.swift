//
//  Container.swift
//  Book-Finder-App
//
//  Created by 최최성균 on 2022/09/07.
//

final class Container {
    func mainViewController() -> MainViewController {
        return MainViewController()
    }
    
    private func mainViewModel() -> MainViewModelable {
        return MainViewModel()
    }
}
