//
//  ListMovieViewController.swift
//  MovieTestingApp
//
//  Created by Escurra Colquis
//

import UIKit

// MARK: - ListMovieViewProtocol
protocol ListMovieViewProtocol: AnyObject {
    func showProgressView()
    func hideProgressView()
    func reloadData()
    func showModal(title: String, message: String)
    func showListMovie(movie: [MovieResponse])
}

class ListMovieViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var upcomingCollectionView: UICollectionView?
    @IBOutlet weak var upcomingView: UIView?
    @IBOutlet weak var movieSearchBar: UISearchBar?
    
    // MARK: - Properties
    var presenter: ListMoviePresenterProtocol?
    var listMovieConfigurator: ListMovieConfiguratorProtocol?
    var listMovieSelect: MovieResponse?
    var listMovie: [MovieResponse]? = []
    var currentPage: Int = 0
    var reloadNext: Bool = false
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureListMovie()
        setupCollectionView()
        configureView()
        callService(page: currentPage + 1)
    }
    
    //MARK: - Functions
    private func configureListMovie() {
        listMovieConfigurator = ListMovieConfigurator()
        listMovieConfigurator?.configureListMovieView(viewController: self)
    }
    
    fileprivate func callService(page: Int?) {
        presenter?.getListMovie(type: .upcoming, page: page ?? 0)
    }
    
    private func setupCollectionView() {
        upcomingCollectionView?.register(UINib(nibName: UpcomingCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: UpcomingCollectionViewCell.nibName)
        upcomingCollectionView?.layer.cornerRadius = 10
        upcomingCollectionView?.delegate = self
        upcomingCollectionView?.dataSource = self
        let layoutUpcoming = UICollectionViewFlowLayout()
        layoutUpcoming.scrollDirection = .vertical
        upcomingCollectionView?.collectionViewLayout = layoutUpcoming
        upcomingCollectionView?.showsHorizontalScrollIndicator = false
        upcomingCollectionView?.bounces = false
        upcomingCollectionView?.layer.masksToBounds = true
    }
    
    private func configureView() {
        upcomingView?.backgroundColor = .clear
        movieSearchBar?.layer.cornerRadius = 10
        movieSearchBar?.delegate = self
        movieSearchBar?.placeholder = NSLocalizedString("searchMovie", comment: "searchMovie")
        movieSearchBar?.showsCancelButton = false
        movieSearchBar?.autocorrectionType = .no
        movieSearchBar?.spellCheckingType = .no
    }
    
    fileprivate func showAllListMovie(movie: [MovieResponse]) {
        presenter?.arrayUncomingMovie = movie
        upcomingCollectionView?.reloadData()
    }
    
    internal func getData() {
        reloadNext = true
        if reloadNext {
            currentPage += 1
            self.callService(page: self.currentPage)
        }
    }
    
    // MARK: - @IBActions
    @IBAction func didTapBack(_ sender: UIButton) {
        presenter?.goToBack()
    }
    
    // MARK: - UIStatusBarStyle
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - UICollectionViewDelegate - UICollectionViewDataSource  UICollectionViewDelegateFlowLayout
extension ListMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.arrayUncomingMovie?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingCollectionViewCell.nibName, for: indexPath) as? UpcomingCollectionViewCell
        cell?.accessibilityIdentifier = UpcomingCollectionViewCell.nibName + "_\(indexPath.row)"
        cell?.iconMovie = presenter?.arrayUncomingMovie?[indexPath.row]
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        listMovieSelect = presenter?.arrayUncomingMovie?[indexPath.row]
        presenter?.goToDetailMovie()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.width/2
        return CGSize(width: 130, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (presenter?.arrayUncomingMovie?.count ?? 0) - 2 {
            getData()
        }
    }
}

// MARK: - ListMovieViewProtocol
extension ListMovieViewController: ListMovieViewProtocol {
    func showModal(title: String, message: String) {
        upcomingView?.isHidden = true
        movieSearchBar?.isHidden = true
        Utils.showMessageTop(true, textBody: NSLocalizedString("errorService", comment: "errorService"))
        Utils.routeToModal(title: title, subtitle: message, from: self, okTitle: NSLocalizedString("accept", comment: "accept"))
    }
    
    func reloadData() {
        upcomingCollectionView?.reloadData()
    }
    
    func showListMovie(movie: [MovieResponse]) {
        if movie.count > 0 {
            listMovie?.insert(contentsOf: movie, at: 0)
            upcomingCollectionView?.reloadData()
        } else {
            reloadNext = false
        }
    }
    
    func showProgressView() {
        let progress = MBProgressHUD.showAdded(to: self.view, animated: true)
        progress.label.text = NSLocalizedString("loadData", comment: "loadData")
        progress.detailsLabel.text = NSLocalizedString("pleaseWait", comment: "pleaseWait")
        progress.isUserInteractionEnabled = false
    }
    
    func hideProgressView() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension ListMovieViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.arrayUncomingMovie = listMovie
            if searchText.isEmpty == false {
                presenter?.arrayUncomingMovie = listMovie?.filter({
                    guard let titleMovie = $0.title else {
                        return false
                    }
                    return titleMovie.contains(searchText)})
            }
            if self.presenter?.arrayUncomingMovie?.count == 0 {
                searchBar.showsCancelButton = true
                let alert = UIAlertController(title: NSLocalizedString("listIsEmpty", comment: "listIsEmpty"), message: NSLocalizedString("messageAlert", comment: "messageAlert"), preferredStyle: .alert)
                let okAction = UIAlertAction(title: NSLocalizedString("accept", comment: "accept"), style: .default) { (_) in
                    self.movieSearchBar?.text = .empty
                    self.movieSearchBar?.showsCancelButton = false
                    self.movieSearchBar?.endEditing(true)
                    guard let movie = self.listMovie else {
                        return
                    }
                    self.showAllListMovie(movie: movie)
                }
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
            upcomingCollectionView?.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.isFirstResponder == true  {
            searchBar.showsCancelButton = true
            searchBar.endEditing(true)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = .empty
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        guard let movie = self.listMovie else {
            return
        }
        showAllListMovie(movie: movie)
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return filterSearch(searchBar, filterText: text, range: range)
    }
}

// MARK: ModalInformationDelegate
extension ListMovieViewController: ModalInformationDelegate {
    func didTapAccept() {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
}
