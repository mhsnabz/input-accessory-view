//
//  ViewController.swift
//  input accessory view
//
//  Created by mahsun abuzeyitoğlu on 11.07.2020.
//  Copyright © 2020 mahsun abuzeyitoğlu. All rights reserved.
//

import UIKit
import Lottie
import AVFoundation
import MobileCoreServices

class ViewController: UIViewController , UIImagePickerControllerDelegate,UINavigationControllerDelegate ,AVAudioRecorderDelegate,AVAudioPlayerDelegate {
    
    //MARK: - variables
    var isRecording : Bool = false
    


    //MARK: -menu variables
    var record = AnimationView()
     var recording = AnimationView()
     var trash = AnimationView()
      var playPause = AnimationView()
    
    var image = AnimationView()
       var video = AnimationView()
             var sound = AnimationView()
             var location = AnimationView()
    var cancel = AnimationView()

           //MARK: -toolbar menu
     lazy var menu : UIView = {
         let v = UIView()
         v.backgroundColor = .white
         v.clipsToBounds = true
         v.layer.cornerRadius = 10
         v.layer.shadowColor = UIColor.black.cgColor
         v.layer.shadowOpacity = 1
         v.layer.shadowOffset = .zero
         v.layer.shadowRadius = 10
         v.layer.shadowPath = UIBezierPath(rect: v.bounds).cgPath
         v.layer.shouldRasterize = true
         v.layer.rasterizationScale = UIScreen.main.scale
         
         
         image = .init(name: "image")
         let imageChoose = UITapGestureRecognizer(target: self, action:  #selector (imageChoose (_:)))
         image.addGestureRecognizer(imageChoose)
       
         
         
      
         video = .init(name: "vv")
         let videoChoose = UITapGestureRecognizer(target: self, action:  #selector (videoChoose(_:)))
         video.addGestureRecognizer(videoChoose)
         
         
         

         sound = .init(name: "sound")
         let soundChoose = UITapGestureRecognizer(target: self, action:  #selector (sendSound(_:)))
         sound.addGestureRecognizer(soundChoose)
         sound.play()
        
         
         

         location = .init(name: "location")
         let locationChoose = UITapGestureRecognizer(target: self, action:  #selector (locaitonChoose(_:)))
         location.addGestureRecognizer(locationChoose)
         location.play()
         
        
        
         cancel = .init(name: "cancel")
         let dismiss = UITapGestureRecognizer(target: self, action:  #selector (cancel(_:)))
         cancel.addGestureRecognizer(dismiss)
         cancel.play()
      
         let stack = UIStackView(arrangedSubviews: [image,video,sound,location,cancel])
         stack.alignment = .center
         stack.distribution = .fillEqually
         stack.axis = .horizontal
         let size = stack.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
         v.addSubview(stack)
         stack.anchor(top: nil, left: nil, bottom: nil, rigth: nil, marginTop: 0, marginLeft: 0, marginBottom: 0, marginRigth: 0, width: self.view.frame.width - 30, heigth: 40)
         stack.centerYAnchor.constraint(equalTo: v.centerYAnchor).isActive = true
         stack.centerXAnchor.constraint(equalTo: v.centerXAnchor).isActive = true
         
         return v
     }()
    //MARK: - record menu
        lazy var recordProgres : UIView = {
            let v = UIView()
            v.backgroundColor = .white
            v.clipsToBounds = true
            v.layer.cornerRadius = 10
            v.layer.shadowColor = UIColor.black.cgColor
            v.layer.shadowOpacity = 1
            v.layer.shadowOffset = .zero
            v.layer.shadowRadius = 10
            v.layer.shadowPath = UIBezierPath(rect: v.bounds).cgPath
            v.layer.shouldRasterize = true
            v.layer.rasterizationScale = UIScreen.main.scale
            
            record.animation = Animation.named("recordBtn")
            let recordChoose = UITapGestureRecognizer(target: self, action:  #selector (recordBtn(_:)))
            record.addGestureRecognizer(recordChoose)
            
            v.addSubview(record)
            record.anchor(top: nil, left: v.leftAnchor, bottom: nil, rigth: nil, marginTop: 0, marginLeft: 12, marginBottom: 0, marginRigth: 0, width: 40, heigth: 40)
            record.centerYAnchor.constraint(equalTo: v.centerYAnchor).isActive = true
            
            
            recording = .init(name: "recording")
            
            recording.contentMode = .scaleToFill
            
            
            var cancel = AnimationView()
            cancel = .init(name: "down")
            let dismiss = UITapGestureRecognizer(target: self, action:  #selector (dismissRecordProgress(_:)))
            cancel.addGestureRecognizer(dismiss)
            
            
            v.addSubview(cancel)
            
            cancel.anchor(top: nil, left: nil, bottom: nil, rigth: v.rightAnchor, marginTop: 0, marginLeft: 0, marginBottom: 0, marginRigth: 8, width: 40, heigth: 40)
            cancel.centerYAnchor.constraint(equalTo: v.centerYAnchor).isActive = true
            
    //
    //        trash = .init(name: "trash")
    //        trash.contentMode = .scaleToFill
    //        let trashGes = UITapGestureRecognizer(target: self, action:  #selector (cancel(_:)))
    //        trash.addGestureRecognizer(trashGes)
    //        v.addSubview(trash)
    //        trash.anchor(top: nil, left: nil, bottom: nil, rigth: cancel.leftAnchor, marginTop: 0, marginLeft: 2, marginBottom: 0, marginRigth: 2, width: 45, heigth: 45)
            
            v.addSubview(recording)
            recording.anchor(top: nil, left: record.rightAnchor, bottom: nil, rigth: cancel.leftAnchor, marginTop: 0, marginLeft: 8, marginBottom: 0, marginRigth: 8, width: 0, heigth: 43)
            recording.centerYAnchor.constraint(equalTo: v.centerYAnchor).isActive = true
            
            return v
        }()
    //MARK: -play progress
    lazy var playProgress : UIView = {
         let v = UIView()
         v.backgroundColor = .white
         v.clipsToBounds = true
         v.layer.cornerRadius = 10
         v.layer.shadowColor = UIColor.black.cgColor
         v.layer.shadowOpacity = 1
         v.layer.shadowOffset = .zero
         v.layer.shadowRadius = 10
         v.layer.shadowPath = UIBezierPath(rect: v.bounds).cgPath
         v.layer.shouldRasterize = true
         v.layer.rasterizationScale = UIScreen.main.scale
         
         playPause.animation = Animation.named("play-pause")
         let recordChoose = UITapGestureRecognizer(target: self, action:  #selector (playPauseAction(_:)))
         playPause.addGestureRecognizer(recordChoose)
         v.addSubview(playPause)
         playPause.anchor(top: nil, left: v.leftAnchor, bottom: nil, rigth: nil, marginTop: 0, marginLeft: 12, marginBottom: 0, marginRigth: 0, width: 40, heigth: 40)
         playPause.centerYAnchor.constraint(equalTo: v.centerYAnchor).isActive = true
         
         
         recording = .init(name: "recording")
         
         recording.contentMode = .scaleToFill
         
         
         var cancel = AnimationView()
         cancel = .init(name: "down")
         let dismiss = UITapGestureRecognizer(target: self, action:  #selector (cancel(_:)))
         cancel.addGestureRecognizer(dismiss)
         
         
         v.addSubview(cancel)
         
         cancel.anchor(top: nil, left: nil, bottom: nil, rigth: v.rightAnchor, marginTop: 0, marginLeft: 0, marginBottom: 0, marginRigth: 8, width: 40, heigth: 40)
         cancel.centerYAnchor.constraint(equalTo: v.centerYAnchor).isActive = true
         
         
         trash = .init(name: "trash")
         trash.contentMode = .scaleToFill
         let trashGes = UITapGestureRecognizer(target: self, action:  #selector (cancel(_:)))
         trash.addGestureRecognizer(trashGes)
         v.addSubview(trash)
         trash.anchor(top: nil, left: nil, bottom: nil, rigth: cancel.leftAnchor, marginTop: 0, marginLeft: 2, marginBottom: 0, marginRigth: 2, width: 45, heigth: 45)
         
         v.addSubview(recording)
         recording.anchor(top: nil, left: playPause.rightAnchor, bottom: nil, rigth: trash.leftAnchor, marginTop: 0, marginLeft: 8, marginBottom: 0, marginRigth: 8, width: 0, heigth: 43)
         recording.centerYAnchor.constraint(equalTo: v.centerYAnchor).isActive = true
         
         return v
     }()
    
    //MARK:- keyboard
    var customInputView: UIView!
    var sendButton: UIButton!
    var addMediaButtom: UIButton!
    let textField = FlexibleTextView()
    override var inputAccessoryView: UIView?{
        if customInputView == nil {
            customInputView = CustomView()
            customInputView.backgroundColor = .white
            textField.placeholder = "Type New Message ..."
            textField.font = .systemFont(ofSize: 15)
            textField.layer.cornerRadius = 5
            
            
            customInputView.autoresizingMask = .flexibleHeight
            
            customInputView.addSubview(textField)
            
            sendButton = UIButton()
            sendButton.isEnabled = true
            sendButton.setImage(UIImage(named: "send"), for: .normal)
            sendButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
            sendButton.addTarget(self, action: #selector(sendMsg), for: .touchUpInside)
            customInputView?.addSubview(sendButton)
            
            addMediaButtom = UIButton()
            addMediaButtom.setImage(UIImage(named: "add"), for: .normal)
            addMediaButtom.isEnabled = true
            //addMediaButtom.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            
            addMediaButtom.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 4)
            addMediaButtom.addTarget(self, action: #selector(showMenu), for: .touchUpInside)
            customInputView?.addSubview(addMediaButtom)
            
            textField.translatesAutoresizingMaskIntoConstraints = false
            sendButton.translatesAutoresizingMaskIntoConstraints = false
            addMediaButtom.translatesAutoresizingMaskIntoConstraints = false
            sendButton.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: NSLayoutConstraint.Axis.horizontal)
            sendButton.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: NSLayoutConstraint.Axis.horizontal)
            
            addMediaButtom.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: NSLayoutConstraint.Axis.horizontal)
            addMediaButtom.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: NSLayoutConstraint.Axis.horizontal)
            
            
            
            textField.maxHeight = 80
            
            addMediaButtom.leadingAnchor.constraint(
                equalTo: customInputView.leadingAnchor,
                constant: 8
            ).isActive = true
            
            addMediaButtom.trailingAnchor.constraint(
                equalTo: textField.leadingAnchor,
                constant: -8
            ).isActive = true
            
            addMediaButtom.topAnchor.constraint(
                equalTo: customInputView.topAnchor,
                constant: 8
            ).isActive = true
            
            addMediaButtom.bottomAnchor.constraint(
                equalTo: customInputView.layoutMarginsGuide.bottomAnchor,
                constant: -8
            ).isActive = true
            
            textField.trailingAnchor.constraint(
                equalTo: sendButton.leadingAnchor,
                constant: 0
            ).isActive = true
            
            textField.topAnchor.constraint(
                equalTo: customInputView.topAnchor,
                constant: 8
            ).isActive = true
            
            textField.bottomAnchor.constraint(
                equalTo: customInputView.layoutMarginsGuide.bottomAnchor,
                constant: -8
            ).isActive = true
            
            sendButton.leadingAnchor.constraint(
                equalTo: textField.trailingAnchor,
                constant: 0
            ).isActive = true
            
            sendButton.trailingAnchor.constraint(
                equalTo: customInputView.trailingAnchor,
                constant: -8
            ).isActive = true
            
            sendButton.bottomAnchor.constraint(
                equalTo: customInputView.layoutMarginsGuide.bottomAnchor,
                constant: -8
            ).isActive = true
        }
        return customInputView
        
    }
    
    //MARK: -life
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        //dismis keyboard when ckick on view
        hideKeyboardWhenTappedAround()
    }
    
    override var canBecomeFirstResponder: Bool {  return true  }

    
    //MARK:- handlers
    
    @objc func sendMsg(){
        
    }
    
    @objc func showMenu(){
       
        self.view.addSubview(self.menu)
        self.menu.anchor(top: nil, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, rigth: self.view.rightAnchor, marginTop: 0, marginLeft: 10, marginBottom: 5, marginRigth: 10, width: 0, heigth: 45)
        textField.resignFirstResponder()
             let bottom = CGAffineTransform(translationX: 0, y: -1 * (self.inputAccessoryView?.frame.height)!)
             UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                 self.menu.transform = bottom
                 
             },completion:{ (isShow) in
                 if isShow{
                        self.image.play()
                        self.image.loopMode = .repeat(2)
                        self.image.animationSpeed = 1.0
                        self.image.loopMode = .repeat(2)
                        self.video.play()
                        self.video.animationSpeed = 1.0
                        self.video.loopMode = .repeat(2)
                        self.sound.play()
                        self.sound.loopMode = .repeat(2)
                        self.sound.animationSpeed = 1.0
                        self.location.play()
                        self.location.loopMode = .repeat(2)
                        self.location.animationSpeed = 1.0
                        self.cancel.play()
                        self.cancel.loopMode = .repeat(2)
                        self.cancel.animationSpeed = 1.0
                 }
             })
    }
    
    func showRecordMenu(){
        view.addSubview(recordProgres)
              recordProgres.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, rigth: view.rightAnchor, marginTop: 0, marginLeft: 10, marginBottom: 5, marginRigth: 10, width: 0, heigth: 45)
              let top = CGAffineTransform(translationX: 0, y: (self.inputAccessoryView?.frame.height)!)
              UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                  self.menu.transform = top
                  
              },completion:{ (isShow) in
                  if isShow{
                      self.textField.resignFirstResponder()
                      let bottom = CGAffineTransform(translationX: 0, y: -1 * (self.inputAccessoryView?.frame.height)!)
                      UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                          self.recordProgres.transform = bottom
                          
                      },completion:{ (isShow) in
                          if isShow{
                            self.menu.removeFromSuperview()
                          }
                      })
                  }
              })
    }
    @objc func recordBtn(_ sender:UITapGestureRecognizer){
        
        
        if !isRecording {
            
            record.play(fromProgress: 0, toProgress: 100, loopMode: .none, completion: nil)

            record.animationSpeed = 1.5
            recording.play()
            recording.animationSpeed = 0.1334 //20 seconds
     
            print("start reccording")
            
        }else {
       print("stop reccording")

            record.play(fromProgress: 100, toProgress: 0, loopMode: .none) { (showPlayProgress) in
             
      let top = CGAffineTransform(translationX: 0, y: (self.inputAccessoryView?.frame.height)!)
                        UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                            self.recordProgres.transform = top
                            
                        },completion:{ (isShow) in
                            if isShow{
                                self.recordProgres.removeFromSuperview()

                            self.view.addSubview(self.playProgress)
                            self.playProgress.anchor(top: nil, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, rigth: self.view.rightAnchor, marginTop: 0, marginLeft: 20, marginBottom: 5, marginRigth: 20, width: self.view.frame.width, heigth: 45)
                                
                                self.textField.resignFirstResponder()
                                       let bottom = CGAffineTransform(translationX: 0, y: -1 * (self.inputAccessoryView?.frame.height)!)
                                       UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                                           self.playProgress.transform = bottom
                                           
                                       },completion:{ (isShow) in
                                           if isShow{
                                               
                                               
                                               
                                           }
                                       })
                            }
                        })
                
            }
            
          
            isRecording = false
            record.animationSpeed = 1.5
            recording.pause()
            recording.animationSpeed = 0.1334 //20 seconds
      
            print("recording stop")
            
            
        }
       
    }
    @objc func dismissRecordProgress(_ sender:UITapGestureRecognizer){
          let top = CGAffineTransform(translationX: 0, y: (self.inputAccessoryView?.frame.height)!)
                 UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                     self.recordProgres.transform = top
                     
                 },completion:{ (isShow) in
                     if isShow{
                        self.showMenu()
                        self.recordProgres.removeFromSuperview()
//
                     }
                 })

        }
    //MARK: -menu handelers
    
    @objc func cancel(_ sender:UITapGestureRecognizer){
        let top = CGAffineTransform(translationX: 0, y: (self.inputAccessoryView?.frame.height)!)
            UIView.animate(withDuration: 0.4, delay: 0.0, options: [], animations: {
                self.menu.transform = top
                
            },completion:{ (isShow) in
                if isShow{
                    self.menu.removeFromSuperview()
                }
            })
    }
    
    @objc func videoChoose(_ sender:UITapGestureRecognizer){
          let imagePickerController = UIImagePickerController()
          imagePickerController.delegate = self
          imagePickerController.allowsEditing = true
          let type = String(kUTTypeMovie)
          
          imagePickerController.mediaTypes = [type]
          self.present(imagePickerController, animated: true) {
              self.customInputView.isHidden = true
          }
      }
      @objc func sendSound(_ sender:UITapGestureRecognizer){
        showRecordMenu()
      }
      @objc func locaitonChoose(_ sender:UITapGestureRecognizer){
          print("locaitonChoose ")
      }
      
      @objc func imageChoose(_ sender:UITapGestureRecognizer){
          let imagePickerController = UIImagePickerController()
          imagePickerController.delegate = self
          imagePickerController.allowsEditing = true
          let type = String(kUTTypeImage)
          imagePickerController.mediaTypes = [type]
          self.present(imagePickerController, animated: true) {
              self.customInputView.isHidden = true
          }
      }
      @objc func playPauseAction(_ sender:UITapGestureRecognizer){ }
    
    
    
    
   
    

}

class CustomView: UIView {
    override var intrinsicContentSize: CGSize {
        return CGSize.zero
    }
}
