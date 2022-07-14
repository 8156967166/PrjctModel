//
//  SampleViewController.swift
//  PrjctModel
//
//  Created by Bimal@AppStation on 03/06/22.
//

import UIKit

class SampleViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, DataPassToVCDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    var sampleArray = [Sample]()
    func dataPassTextField1(str: String, cellModel: Sample) {
       /* for model in sampleArray {
            if model.type == cellModel.type {
                model.enteredtxt = str
            }
        }*/
        if let objModel = sampleArray.first(where: {$0.type == cellModel.type}) {
            objModel.enteredtxt = str
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setModelSample()
        // Do any additional setup after loading the view.
    }
    func setModelSample() {
        let buttonModel = Sample(strType: .button)
        let buttonImgModel = Sample(strType: .buttonImage)
        let textLabelModel = Sample(strType: .textFieldLabel)
        let labelimgModel = Sample(strType: .labelImage)
        let textFieldModel = Sample(strType: .textField)
        sampleArray = [buttonModel,buttonImgModel,textLabelModel,labelimgModel,textFieldModel]
        
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
    func buttonActionFirst() {
        self.view.endEditing(true)
        for model in sampleArray {
            if model.type == .textFieldLabel {
                print("entered text in textfield1: \(model.enteredtxt) ")
            }
            else if model.type == .textField {
                print("Entered text in textField2: \(model.enteredtxt)")
            }
        }
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
//    func buttonActionSecond() {
//        self.view.endEditing(true)
//        for model in sampleArray {
//            if model.type == .textField {
//                print("Entered text in textField2: \(model.enteredtxt)")
//            }
//        }
//        DispatchQueue.main.async {
//            self.tableview.reloadData()
//        }
//    }
    func buttonActionCam() {
        self.showAlert()
    }
    func showAlert() {
        let alertController = UIAlertController(title: "selection Process ", message: "Choose Any Option", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(_ action: UIAlertAction) in self.getImage(fromSourceType: .camera) }))
        alertController.addAction(UIAlertAction(title: "Gallery", style: .default, handler: {(_ action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
            
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        if let objModels = sampleArray.first(where: {$0.type == .labelImage}) {
            objModels.selectedImg = tempImage
        }
        DispatchQueue.main.async {
            self.tableview.reloadData()
            self.dismiss(animated: true, completion: nil)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
    }
}
extension SampleViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = sampleArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.identifier, for: indexPath) as! SampleTableViewCell
        cell.setModel(setSample: cellModel)
        if cellModel.type == .labelImage {
            if let objModel = sampleArray.first(where: {$0.type == .textField}) {
                cell.labelInCell?.text = objModel.enteredtxt
            }
            if let temp = cellModel.selectedImg {
                cell.imageViewCycle?.image = temp
            }
        }
        cell.delegate = self
        return cell
    }
}
