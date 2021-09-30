//
//  AddConsoleViewController.swift
//  MyGames
//
//  Created by Andre Ponce on 18/09/21.
//

import UIKit
import Photos

class AddConsoleViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var consoleNameTxt: UITextField!
    @IBOutlet weak var consoleImage: UIImageView!
    @IBOutlet weak var selectImageBt: UIButton!
    @IBOutlet weak var saveBt: UIButton!
    
    var console: Console!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        prepareDataLayout()
    }
    
    func prepareDataLayout() {
        if console != nil {
            title = "Editar Console"
            saveBt.setTitle("ALTERAR", for: .normal)
            
            consoleNameTxt.text = console.name
            consoleImage.image = console.image as? UIImage
            selectImageBt.setTitle(nil, for: .normal)
        }
    }
    
    @IBAction func saveHandler(_ sender: UIButton) {
        let consoleName = self.consoleNameTxt.text
        let consoleImage = self.consoleImage.image
        
        if(!(consoleName ?? "").isEmpty && consoleImage != nil){
            let console = self.console ?? Console(context: self.context)
            console.name = consoleName
            console.image = consoleImage
            
            do {
                try context.save()
                print("Object saved")
            } catch {
                print(error.localizedDescription)
            }
            navigationController?.popViewController(animated: true)
        }else{
            let alert = UIAlertController(title: "Dados incorretos", message: "Insira um nome e selecione uma imagem para o console.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func selectImageHandler(_ sender: UIButton) {
        let alert = UIAlertController(title: "Selecinar imagem", message: "De onde você quer escolher a imagem?", preferredStyle: .actionSheet)
        
        let libraryAction = UIAlertAction(title: "Biblioteca de fotos", style: .default, handler: {(action: UIAlertAction) in
            self.selectPicture(sourceType: .photoLibrary)
        })
        alert.addAction(libraryAction)
        
        let photosAction = UIAlertAction(title: "Album de fotos", style: .default, handler: {(action: UIAlertAction) in
            self.selectPicture(sourceType: .savedPhotosAlbum)
        })
        alert.addAction(photosAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func selectPicture(sourceType: UIImagePickerController.SourceType) {
        
        //Photos
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized{
                    
                    self.chooseImageFromLibrary(sourceType: sourceType)
                    
                } else {
                    
                    print("unauthorized -- TODO message")
                }
            })
        } else if photos == .authorized {
            
            self.chooseImageFromLibrary(sourceType: sourceType)
        
        } else if photos == .denied {
            print("mostrar uma alerta pro usuario pedindo para ele setar manualmente a permissao...")
        }
    }
    
    func chooseImageFromLibrary(sourceType: UIImagePickerController.SourceType) {
        
        DispatchQueue.main.async {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = sourceType
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.navigationBar.tintColor = UIColor(named: "main")
            
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            DispatchQueue.main.async {
                self.consoleImage.image = pickedImage
                self.consoleImage.setNeedsDisplay()
                self.selectImageBt.setTitle(nil, for: .normal)
                self.selectImageBt.setNeedsDisplay()
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
}
