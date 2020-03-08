//
//  SearchRepositoriesViewController.swift
//  GitMobile
//
//  Created by Zafar on 3/8/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class SearchRepositoriesViewController: UIViewController {
    
    // MARK: - Lifecycle
    init(viewModelFactory: SearchRepositoriesViewModelFactory) {
        self.viewModelFactory = viewModelFactory
        self.viewModel = viewModelFactory.makeViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Search Repositories"
    }
    
    override func loadView() {
        view = SearchRepositoriesView(viewModel: viewModelFactory.makeViewModel())
    }
    
    // MARK: - Properties
    let viewModelFactory: SearchRepositoriesViewModelFactory
    let viewModel: SearchRepositoriesViewModel
}

