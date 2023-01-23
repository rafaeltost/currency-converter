//
//  CoinConverterController.swift
//  currency converter
//
//  Created by Rafael Tosta on 21/01/23.
//

import UIKit
import iOSDropDown

class CoinConverterController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var dropDownTo: DropDown!
    @IBOutlet weak var dropDownFrom: DropDown!
    @IBOutlet weak var lblValueConvert: UILabel!
    @IBOutlet weak var txtValueInfo: UITextField!
    
    
    //MARK: ViewModel
    private var viewModel: CoinConverterViewModel!
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
    
    private func configureView(){
        self.viewModel = CoinConverterViewModel(service: WebService())
        self.configDropDown()
    }
    
    //MARK: @IBActions
    @IBAction func actGetCoin(_ sender: UIButton) {
        let error:String = self.validateFields()
        if error != String.empty() {
            self.view.showMessageView(view: self, message: error)
       } else {
            let param1 = self.dropDownTo.text!
            let param2 = self.dropDownFrom.text!
            let param:String = "\(param1)-\(param2)"
            self.getConvertedCoin(param: param)
        }
        view.endEditing(true)
    }
    
    //MARK: Private Funcs
    private func validateFields() -> String {
        var error:String = String.empty()
        
        if self.txtValueInfo.text == String.empty() {
            error = "Informe um valor a ser convertido"
        } else if self.dropDownTo.text == String.empty() || self.dropDownFrom.text == String.empty() {
            error = "Selecione as moedas a serem convertidas"
        } else if self.dropDownTo.text == self.dropDownFrom.text {
            error = "Selecione moedas diferentes"
        }
        
        return error
    }
    
    private func getConvertedCoin(param:String) {
        self.viewModel.getCoins(params: param){ (data, error) in
            if let coins = data {
                self.calculateCoin(coins)
            } else {
                return
            }
        }
    }
    
    private func calculateCoin(_ coins: ExchangeCoins){
        let coinUsed:Coin? = coins.first!.value
        let valueStr:NSNumber = self.viewModel.calculateCoins(valueInfo: self.txtValueInfo.text!, valueCoin: coinUsed!.buyValue)
        self.lblValueConvert.text = String.formatCurrency(value: valueStr, enumCoin: self.dropDownFrom.text!)

    }
    
    private func configDropDown() {
        self.dropDownTo.optionArray = self.viewModel.getListCoins()
        self.dropDownTo.arrowSize = 9
        self.dropDownTo.selectedRowColor = .gray
        
        self.dropDownFrom.optionArray = self.viewModel.getListCoins()
        self.dropDownFrom.arrowSize = 9
        self.dropDownFrom.selectedRowColor = .gray
    }

}
