//
//  SampleTableViewCell.swift
//  PrjctModel
//
//  Created by Bimal@AppStation on 03/06/22.
//

import UIKit

protocol DataPassToVCDelegate {
    func dataPassTextField1(str: String, cellModel: Sample)
    func buttonActionFirst()
//    func buttonActionSecond()
    func buttonActionCam()
}
class SampleTableViewCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet weak var button: UIButton?
    @IBOutlet weak var txtFld: UITextField?
    @IBOutlet weak var labelInCell: UILabel?
    @IBOutlet weak var imageviewCam: UIImageView?
    @IBOutlet weak var imageViewCycle: UIImageView?
    var delegate: DataPassToVCDelegate?
    var currentModel: Sample?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setModel(setSample: Sample) {
        currentModel = setSample
        txtFld?.delegate = self
        self.txtFld?.text = setSample.enteredtxt
        if setSample.type == .textFieldLabel
        {
            self.labelInCell?.text = setSample.enteredtxt
        }
        setStyle()
    }
    func setStyle(){
        button?.layer.borderWidth = 1
        button?.layer.borderColor = #colorLiteral(red: 0.8731591702, green: 0.8731591702, blue: 0.8731591702, alpha: 1)
        button?.layer.cornerRadius = 6
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
      
        delegate?.dataPassTextField1(str: txtFld?.text ?? "", cellModel: currentModel!)
       
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        self.endEditing(true)
        return true;
    }
    @IBAction func buttonActionFirst(sender: UIButton) {
        delegate?.buttonActionFirst()
    }
//    @IBAction func buttonActionSecond(sender: UIButton) {
//        delegate?.buttonActionSecond()
//    }
    @IBAction func buttonActionCam(sender: UIButton) {
        delegate?.buttonActionCam()
    }
}
