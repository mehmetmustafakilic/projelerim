//
//  RickMortyViewModel.swift
//  RickMortySwiftWithoutSB
//
//  Created by Mehmet Mustafa Kılıç on 24.11.2022.
//

import Foundation

protocol IRickMortyViewModel {
    func fetchItem()
    func changeLoading()
    
    var rickMortyCharacters: [Result] { get set }
    var rickMortySevice: IRickMortyService { get }
    var rickMortyOutPut: RickMortyOutPut? { get }
    
    func setDelegate(output: RickMortyOutPut)
}

final  class RickMortyViewModel: IRickMortyViewModel {
    var rickMortyOutPut: RickMortyOutPut?
    
    func setDelegate(output: RickMortyOutPut) {
        rickMortyOutPut = output
    }
    
    var rickMortyCharacters: [Result] = []
    private var isLoading = false
    var rickMortySevice: IRickMortyService
    
    init() {
        rickMortySevice = RickMortyService()
    }
    
    func fetchItem() {
        changeLoading()
        rickMortySevice.fechAllDatas { [weak self] (response) in
            self?.changeLoading()
            self?.rickMortyCharacters = response ?? []
            self?.rickMortyOutPut?.saveDatas(Values: self?.rickMortyCharacters ?? [])
        }
    }
    
    func changeLoading() {
        isLoading = !isLoading
        rickMortyOutPut?.changeLoading(isLoad: isLoading)
    }
}
