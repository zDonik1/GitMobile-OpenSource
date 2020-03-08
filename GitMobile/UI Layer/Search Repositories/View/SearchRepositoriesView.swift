//
//  SearchRepositoriesView.swift
//  GitMobile
//
//  Created by Zafar on 3/8/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import UIKit

import RxSwift
import RxDataSources

class SearchRepositoriesView: UIView {
    
    // MARK: - Initialization
    init(viewModel: SearchRepositoriesViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        setupUI()
        bindTableView()
        bindSearchBarState()
        bindLoadingState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    let viewModel: SearchRepositoriesViewModel
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 70
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: RepositoryTableViewCell.reuseIdentifier())
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.tintColor = .white
        searchBar.barTintColor = Colors.githubDarkGray
        searchBar.placeholder = "Search for a repo..."
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchTextField.textColor = .white
        return searchBar
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .gray
        indicator.hidesWhenStopped = true
        return indicator
    }()
}

// MARK: - Binding
extension SearchRepositoriesView {
    private func bindTableView() {
        viewModel.repositoryViewModels
            .bind(to: tableView.rx.items(cellIdentifier: RepositoryTableViewCell.reuseIdentifier(), cellType: RepositoryTableViewCell.self)) { index, viewModel, cell in
                
                cell.viewModel = viewModel
        }
        .disposed(by: disposeBag)
    }
    
    private func bindSearchBarState() {
        searchBar.rx.text
            .orEmpty
            .filter { $0.count > 3}
            .distinctUntilChanged()
            .debounce(RxTimeInterval.milliseconds(5), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.viewModel.searchRepositories(for: $0)
            })
            .disposed(by: disposeBag)
        
        searchBar.rx.text
            .orEmpty
            .subscribe(onNext: { [weak self] (text) in
                self?.searchBar.showsCancelButton = !text.isEmpty
            })
            .disposed(by: disposeBag)
        
        searchBar.rx.textDidEndEditing
            .subscribe(onNext: { [weak self] in
                self?.searchBar.showsCancelButton = true
            })
            .disposed(by: disposeBag)
        
        searchBar.rx.cancelButtonClicked
            .subscribe(onNext: { [weak self] in
                self?.searchBar.resignFirstResponder()
                self?.searchBar.searchTextField.resignFirstResponder()
                self?.searchBar.text = ""
                self?.searchBar.showsCancelButton = false
            })
            .disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked
            .subscribe(onNext: { [weak self] in
           
                self?.searchBar.searchTextField.resignFirstResponder()
            })
            .disposed(by: disposeBag)
    }
    
    private func bindLoadingState() {
        viewModel.isLoading
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
    }
}

// MARK: - Setup UI
extension SearchRepositoriesView {
    private func setupUI() {
        self.backgroundColor = .white
        
        self.addSubview(searchBar)
        self.addSubview(tableView)
        tableView.addSubview(activityIndicator)
        
        searchBar.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
