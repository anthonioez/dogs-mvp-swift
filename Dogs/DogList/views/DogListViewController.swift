//
//  DogListViewController.swift
//  Dogs
//
//  Created by Anthony Ezeh on 18/11/2022.
//

import UIKit

final class DogListViewController: UIViewController {

    var presenter: DogListPresenter?

    @IBOutlet weak var tableBreeds: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = true

        tableBreeds.register(UINib(nibName: DogListTableViewCell.cellIdentifier, bundle: nil),
                                forCellReuseIdentifier: DogListTableViewCell.cellIdentifier)
        tableBreeds.delegate = self
        tableBreeds.dataSource = self
        tableBreeds.automaticallyAdjustsScrollIndicatorInsets = false
        tableBreeds.contentInsetAdjustmentBehavior = .never

        tableBreeds.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)

        tableBreeds.tintColor = .clear
        tableBreeds.backgroundColor = .white
        tableBreeds.separatorColor = .clear

        tableBreeds.separatorStyle = .none

        refreshControl.attach(self, action: #selector(reloadHandler(_:)), scrollView: tableBreeds)

        presenter?.fetchBreeds()
    }

    private func stopAnimations() {
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }

        if activityIndicator.isAnimating {
            activityIndicator.stopAnimating()
        }
    }

}

extension DogListViewController {

    @objc func reloadHandler(_ sender: AnyObject) {
        presenter?.fetchBreeds()
    }

}

extension DogListViewController: DogListPresenterProtocol {

    func fetchStarting() {
        if let count = presenter?.breeds.count, count > 0 {
            activityIndicator.stopAnimating()
        } else {
            activityIndicator.startAnimating()
        }
    }

    func fetchCompleted() {
        stopAnimations()

        tableBreeds.reloadData()
    }

    func fetchFailed() {
        stopAnimations()

        showAlert(presenter?.error)
    }

    func openDetail(breed: DogBreed) {
        let viewController = DogDetailViewController(nibName: "DogDetailViewController", bundle: nil)
        viewController.presenter = DogDetailPresenter(breed: breed, delegate: viewController)

        navigationController?.pushViewController(viewController, animated: true)
    }

}

extension DogListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DogListTableViewCell.cellHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectBreed(index: indexPath.row)
    }

}

extension DogListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfBreeds ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let breed = presenter?.breedAt(index: indexPath.row) {
            let cell = tableView.dequeueReusableCell(withIdentifier: DogListTableViewCell.cellIdentifier,
                                                     for: indexPath as IndexPath) as! DogListTableViewCell
            cell.configure(breed: breed)
            return cell
        }

        let cell = UITableViewCell()
        cell.backgroundColor = .clear
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}
