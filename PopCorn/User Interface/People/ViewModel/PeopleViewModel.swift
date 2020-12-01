//
//  PeopleViewModel.swift
//  PopCorn
//
//  Created by Valmir Junior on 30/11/20.
//  Copyright © 2020 Valmir Torres. All rights reserved.
//

import Foundation

protocol PeopleViewModelDelegate: AnyObject {
    func onListenerError(with errorMessage: String)
    func onListenerPeople()
}

final class PeopleViewModel {
    //MARK: - Properties
    private let id: Int
    private var repository: PeopleRepositoryProtocol
    private var people: People?
    weak var delegate: PeopleViewModelDelegate?
    
    init(id: Int, _ repository: PeopleRepositoryProtocol = PeopleRepository()) {
        self.id = id
        self.repository = repository
    }
    
    //MARK: - Methods
    func loadData() {
        repository.delegate = self
        //TODO
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
}
