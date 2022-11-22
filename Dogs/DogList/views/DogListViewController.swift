//
//  DogListViewController.swift
//  Dogs
//
//  Created by Anthony Ezeh on 18/11/2022.
//

import UIKit

// View (ViewController) in MVP for the Featured Breeds
final class DogListViewController: UIViewController {

    // strong reference to the presenter
    var presenter: DogListPresenter?

    // XIB outlets
    @IBOutlet weak var tableBreeds: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // pull to refresh control
    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        // setup the navigation bar
        title = NSLocalizedString("Featured Breeds", comment: "")
        navigationStyle()

        // setup the table view
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

        // connect pull to refresh
        refreshControl.attach(self, action: #selector(reloadHandler(_:)), scrollView: tableBreeds)

        // notify presenter that the view is ready
        presenter?.fetchBreeds()
    }

    // reset all animations
    private func stopAnimations() {
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }

        if activityIndicator.isAnimating {
            activityIndicator.stopAnimating()
        }
    }

}

// refreshcontrol presenter extension
extension DogListViewController {

    // handle pull to refresh event
    @objc func reloadHandler(_ sender: AnyObject) {
        // notify presenter to refresh the list
        presenter?.fetchBreeds()
    }

}

// list presenter extension
extension DogListViewController: DogListPresenterProtocol {

    // called when a repository refresh is starting -> setup animations
    func fetchStarting() {
        if let count = presenter?.breeds.count, count > 0 {
            activityIndicator.stopAnimating()
        } else {
            activityIndicator.startAnimating()
        }
    }

    // called when a repository fetch is successfull -> stop animation and reload list
    func fetchCompleted() {
        stopAnimations()

        tableBreeds.reloadData()
    }

    // called when a repository fetch failedd -> stop animations and show error toast
    func fetchFailed() {
        stopAnimations()

        showAlert(presenter?.error?.rawValue)
    }

    // navigate to the detail view for a breed
    func openDetail(breed: DogBreed) {
        let viewController = DogDetailViewController(nibName: "DogDetailViewController", bundle: nil)
        // inject the presenter
        viewController.presenter = DogDetailPresenter(breed: breed, delegate: viewController)

        navigationController?.pushViewController(viewController, animated: true)
    }

}

// view delegate extension for table view
extension DogListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // default height for table row
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
        // notify the presenter that a row was selected
        presenter?.selectBreed(index: indexPath.row)
    }

}

// data source extension for table view
extension DogListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // fetch the number of breeds
        return presenter?.numberOfBreeds ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // fetch and display a table cell for a breed
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
