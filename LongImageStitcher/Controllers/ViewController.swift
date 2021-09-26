//
//  ViewController.swift
//  LongImageStitcher
//
//  Created by HaiboZhou on 2021/9/25.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var images = [UIImage]()
    private var imagePicker: PHImagePicker!
    
    lazy var importButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Import", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        btn.setTitleColor(.white, for: .normal)
        btn.titleEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        btn.backgroundColor = .myBlue
        btn.layer.cornerRadius = 8
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(importButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    lazy var stitchButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Stitch", for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        btn.setTitleColor(.white, for: .normal)
        btn.titleEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        btn.backgroundColor = .myGreen
        btn.layer.cornerRadius = 8
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(stitchButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    lazy var imageView1: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .myBlue
        imageView.rotate(angle: -20)
        imageView.contentMode = .scaleAspectFill
//        imageView.image = UIImage(named: "001")
        return imageView
    }()
    
    lazy var imageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .myPink
        imageView.contentMode = .scaleAspectFill
//        imageView.image = UIImage(named: "002")
        return imageView
    }()
    
    lazy var imageView3: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .myGreen
        imageView.rotate(angle: 20)
        imageView.contentMode = .scaleAspectFill
//        imageView.image = UIImage(named: "003")
        return imageView
    }()
    
    lazy var longImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .myGreen
        imageView.contentMode = .scaleToFill
        imageView.isHidden = true
        imageView.image = UIImage(named: "003")
        
        return imageView
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViews()
        addImageViewTapGesture()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        longImageView.addGradient(color1: .clear, color2: .black)
    }
    
    func addImageViewTapGesture() {
        // add tapGesture for longImageView
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        self.longImageView.addGestureRecognizer(tapGestureRecognizer)
        self.longImageView.isUserInteractionEnabled = true
    }
    
    @objc func removeButtonTapped(_ sender: UIButton) {
        // todo...
    }
    
    func setViews() {
        title = "Image Stitcher"
        view.backgroundColor = .systemBackground
        
        let removeButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash")?.withTintColor(.systemRed).withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(removeButtonTapped))
        navigationItem.rightBarButtonItem = removeButtonItem
        
        let settingsButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape")?.withTintColor(.myBlue).withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(removeButtonTapped))
        navigationItem.leftBarButtonItem = settingsButtonItem
        
        view.addSubview(importButton)
        view.addSubview(stitchButton)
        view.addSubview(imageView1)
        view.addSubview(imageView2)
        view.addSubview(imageView3)
        view.addSubview(longImageView)

        let g = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: importButton, attribute: .centerX, relatedBy: .equal, toItem: g, attribute: .trailing, multiplier: 0.3, constant: 0),
            importButton.bottomAnchor.constraint(equalTo: g.bottomAnchor, constant: -50),
            importButton.widthAnchor.constraint(equalTo: g.widthAnchor, multiplier: 0.25),
            importButton.heightAnchor.constraint(equalTo: importButton.widthAnchor, multiplier: 0.5),
            
            NSLayoutConstraint(item: stitchButton, attribute: .centerX, relatedBy: .equal, toItem: g, attribute: .trailing, multiplier: 0.7, constant: 0),
            stitchButton.bottomAnchor.constraint(equalTo: g.bottomAnchor, constant: -50),
            stitchButton.widthAnchor.constraint(equalTo: g.widthAnchor, multiplier: 0.25),
            stitchButton.heightAnchor.constraint(equalTo: stitchButton.widthAnchor, multiplier: 0.5),
            
            imageView1.topAnchor.constraint(equalTo: g.topAnchor, constant: 80),
            NSLayoutConstraint(item: imageView1, attribute: .centerX, relatedBy: .equal, toItem: g, attribute: .trailing, multiplier: 0.35, constant: 0),
            imageView1.widthAnchor.constraint(equalTo: g.widthAnchor, multiplier: 0.3),
            imageView1.heightAnchor.constraint(equalTo: imageView1.widthAnchor, multiplier: 1.5),
            
            imageView2.topAnchor.constraint(equalTo: g.topAnchor, constant: 80),
            NSLayoutConstraint(item: imageView2, attribute: .centerX, relatedBy: .equal, toItem: g, attribute: .centerX, multiplier: 1, constant: 0),
            imageView2.widthAnchor.constraint(equalTo: g.widthAnchor, multiplier: 0.3),
            imageView2.heightAnchor.constraint(equalTo: imageView2.widthAnchor, multiplier: 1.5),
//
            imageView3.topAnchor.constraint(equalTo: g.topAnchor, constant: 80),
            NSLayoutConstraint(item: imageView3, attribute: .centerX, relatedBy: .equal, toItem: g, attribute: .trailing, multiplier: 0.65, constant: 0),
            imageView3.widthAnchor.constraint(equalTo: g.widthAnchor, multiplier: 0.3),
            imageView3.heightAnchor.constraint(equalTo: imageView3.widthAnchor, multiplier: 1.5),
            
            longImageView.topAnchor.constraint(equalTo: g.topAnchor, constant: 60),
            longImageView.centerXAnchor.constraint(equalTo: g.centerXAnchor),
            longImageView.widthAnchor.constraint(equalTo: g.widthAnchor, multiplier: 0.35),
            longImageView.heightAnchor.constraint(equalTo: longImageView.widthAnchor, multiplier: 3)
        ])
    }
    
    @objc func importButtonTapped(_ sender: UIButton) {
        // create a new imagePicker instance
        self.imagePicker = PHImagePicker(presentationController: self, delegate: self)
        
        
        for imageView in [self.imageView1, self.imageView2, self.imageView3] {
            imageView.isHidden = false
        }
        self.longImageView.isHidden = true
        self.imagePicker.present(from: sender)
    }
    
    @objc func stitchButtonTapped(sender: UIButton) {
        if self.images.count <= 1 {
            createAlert(message: "Please select at least 2 images", actionTitle: "Confirm")
            return
        }
        
        self.showSpinner()
        DispatchQueue.global().async { [weak self] in
            guard let images = self?.images else { return }
            // start to stitch the images
            let stitchedImage = CVWrapper.process(with: images)
            
            // rotate stitched image by 90 degree
            guard let rotatedImage = stitchedImage.rotate(radians: .pi / 2) else {
                DispatchQueue.main.async {
                    self?.removeSpinner()
                    self?.createAlert(message: "Can't stitch images", actionTitle: "Confirm")
                    self?.imageView1.isHidden = false
                    self?.imageView2.isHidden = false
                    self?.imageView3.isHidden = false
                }
                return
            }
            
            // save image to photos
            UIImageWriteToSavedPhotosAlbum(rotatedImage, nil, nil, nil)

            DispatchQueue.main.async {
                for imageView in [self?.imageView1, self?.imageView2, self?.imageView3] {
                    imageView?.isHidden = true
                }
                self?.removeSpinner()
                guard let imageView = self?.longImageView else { return }
                imageView.image = rotatedImage
                UIView.transition(with: imageView,
                                  duration: 1.6,
                                  options: .transitionCrossDissolve,
                                  animations: {
                                    imageView.isHidden = false
                                  },
                                  completion: nil)
            }
        }
    }
    
    func createAlert(title: String? = nil, message: String? = nil, actionTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    // MARK: - show image on fullscreen when a tapping happened
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        guard let imageView = sender.view as? UIImageView else { return }
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = CGRect(x: 40, y: 40, width: UIScreen.main.bounds.width - 40 * 2, height: UIScreen.main.bounds.height - 40 * 2)
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleToFill
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        
        self.navigationController?.isNavigationBarHidden = true
        UIView.transition(with: view,
                          duration: 0.33,
                          options: [.curveEaseOut, .transitionFlipFromBottom],
                          animations: {
                            self.view.addSubview(newImageView)
                          },
                          completion: nil)
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        
        UIView.transition(with: view,
                          duration: 0.33,
                          options: [.curveEaseOut, .transitionFlipFromBottom],
                          animations: {
                            sender.view?.removeFromSuperview()
                          },
                          completion: nil)
    }
}

extension ViewController: PHImagePickerDelegate {
    func didSelect(images: [UIImage]?) {
        guard let images = images else { return }
        self.images = images
        
        // give an animation for images changing
        UIView.transition(with: self.imageView1,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.imageView1.image = images.indices.contains(0) ? images[0] : nil
                          },
                          completion: {_ in
                            UIView.transition(with: self.imageView2,
                                              duration: 0.5,
                                              options: .transitionCrossDissolve,
                                              animations: {
                                                self.imageView2.image = images.indices.contains(1) ? images[1] : nil
                                              },
                                              completion: {_ in
                                                UIView.transition(with: self.imageView3,
                                                                  duration: 0.5,
                                                                  options: .transitionCrossDissolve,
                                                                  animations: {
                                                                    self.imageView3.image = images.indices.contains(2) ? images[2] : nil
                                                                  },
                                                                  completion: nil)
                                              })
                          })
        
        
        print("images count: ", self.images.count)
    }
}

