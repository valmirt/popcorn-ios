//
//  PeopleViewModel.swift
//  PopCorn
//
//  Created by Valmir Junior on 30/11/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import UIKit

protocol PeopleViewModelDelegate: AnyObject {
    func onListenerError(with errorMessage: String)
    func onListenerPeople()
    func onListenerFilmography()
}

final class PeopleViewModel {
    //MARK: - Properties
    private let id: Int
    private var repository: PeopleRepositoryProtocol
    private var people: People?
    private var filmography: Filmography?
    
    weak var delegate: PeopleViewModelDelegate?
    
    var name: String {
        people?.name ?? ""
    }
    var birthday: String {
        "★ Birthday: \(people?.birthday ?? "-")"
    }
    var deathday: String {
        "✟ Deathday: \(people?.deathday ?? "-")"
    }
    var department: String {
        "Department: \(people?.knownForDepartment ?? "-")"
    }
    var popularity: String {
        "Popularity: \(String(format: "%.1f", people?.popularity ?? 0))"
    }
    var placeOfBirth: String {
        "Place of Birth: \(people?.placeOfBirth ?? "")"
    }
    var biography: String {
        people?.biography ?? "..."
    }
    var countFilmography: Int {
        guard let filmography = filmography else { return 0 }
        return filmography.cast.count + filmography.crew.count
    }
    
    init(id: Int, _ repository: PeopleRepositoryProtocol = PeopleRepository()) {
        self.id = id
        self.repository = repository
    }
    
    //MARK: - Methods
    func loadData() {
        repository.delegate = self
        repository.detailPeople(with: id)
        repository.combinedFilmography(with: id)
    }
    
    func getImage(onComplete: @escaping (UIImage?) -> Void) {
        let base = Web.BASE_URL_IMAGE
        let path = "\(Web.IMAGE_W185)\(people?.profilePath ?? "")"
        repository.updateImage(baseURL: base, path: path) { image in
            onComplete(image)
        }
    }
    
    func getFilmographyViewModel(at indexPath: IndexPath) -> FilmographyViewModel {
        guard let filmography = filmography else { return FilmographyViewModel(credited: nil) }
        if indexPath.item < filmography.cast.count {
            return FilmographyViewModel(credited: filmography.cast[indexPath.item])
        } else {
            let index = indexPath.item - filmography.cast.count
            return FilmographyViewModel(credited: filmography.crew[index])
        }
    }
    
    func getDetailMovieViewModel(at indexPath: IndexPath) -> DetailMovieViewModel {
        guard let filmography = filmography else { return DetailMovieViewModel(idMovie: 0) }
        if indexPath.item < filmography.cast.count {
            return DetailMovieViewModel(idMovie: filmography.cast[indexPath.item].id)
        } else {
            let index = indexPath.item - filmography.cast.count
            return DetailMovieViewModel(idMovie: filmography.crew[index].id)
        }
    }
    
    func getDetailTVShowViewModel(at indexPath: IndexPath) -> DetailTVShowViewModel {
        guard let filmography = filmography else { return DetailTVShowViewModel(idTV: 0) }
        if indexPath.item < filmography.cast.count {
            return DetailTVShowViewModel(idTV: filmography.cast[indexPath.item].id)
        } else {
            let index = indexPath.item - filmography.cast.count
            return DetailTVShowViewModel(idTV: filmography.crew[index].id)
        }
    }
    
    func isCreditedMovie(at indexPath: IndexPath) -> Bool {
        guard let filmography = filmography else { return true }
        if indexPath.item < filmography.cast.count {
            return filmography.cast[indexPath.item].mediaType == "movie"
        } else {
            let index = indexPath.item - filmography.cast.count
            return filmography.crew[index].mediaType == "movie"
        }
    }
}

//MARK: - People repository delegate
extension PeopleViewModel: PeopleRepositoryDelegate {
    func peopleRepository(_ manager: PeopleRepositoryProtocol, didUpdateError: Error) {
        delegate?.onListenerError(with: didUpdateError.localizedDescription)
    }
    
    func peopleRepository(_ manager: PeopleRepositoryProtocol, didUpdatePeople: People) {
        people = didUpdatePeople
        delegate?.onListenerPeople()
    }
    
    func peopleRepository(_ manager: PeopleRepositoryProtocol, didUpdateFilmography: Filmography) {
        filmography = didUpdateFilmography
        delegate?.onListenerFilmography()
    }
}
