//
//  ViewController.swift
//  LongImageStitcher
//
//  Created by HaiboZhou on 2021/9/25.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    private lazy var images = [UIImage]()
    private var imagePicker: PHImagePicker!
    private var longImageViewHighConstraint: NSLayoutConstraint!
    private var rotatedImage: UIImage?
    
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
        return imageView
    }()
    
    lazy var imageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .myPink
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var imageView3: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .myGreen
        imageView.rotate(angle: 20)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var longImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        return imageView
    }()
    
    lazy var scrollView: UIScrollView = {
        let aView = UIScrollView()
        return aView
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
    
    /// save generated long image to photos
    @objc func saveButtonTapped(_ sender: UIButton) {
        guard let image = self.rotatedImage else { return }
        
        showSpinner()
        DispatchQueue.global().async { [weak self] in
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            DispatchQueue.main.async {
                self?.removeSpinner()
                self?.createAlert(message: "Image save complete", actionTitle: "Done")
            }
        }
    }
    
    /// todo...
    @objc func settingsButtonTapped(_ sender: UIButton) {
        
    }
    
    func setViews() {
        title = "Image Stitcher"
        view.backgroundColor = .systemBackground
        
        setBackgroundImage(imageName: "backgroundImage")
        
        let saveButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.down")?.withTintColor(.systemRed).withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButtonItem
        
        let settingsButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape")?.withTintColor(.myBlue).withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(settingsButtonTapped))
        navigationItem.leftBarButtonItem = settingsButtonItem
        
        view.addSubview(importButton)
        view.addSubview(stitchButton)
        view.addSubview(imageView3)
        view.addSubview(imageView2)
        view.addSubview(imageView1)
        view.addSubview(longImageView)

        let g = view.safeAreaLayoutGuide
        longImageViewHighConstraint = longImageView.heightAnchor.constraint(equalTo: longImageView.widthAnchor, multiplier: 3)
        longImageViewHighConstraint.isActive = true
        
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
            longImageView.widthAnchor.constraint(equalTo: g.widthAnchor, multiplier: 0.35)
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
    
    /// stitch images
    @objc func stitchButtonTapped(sender: UIButton) {
        if self.images.count <= 1 {
            createAlert(message: "Please select at least 2 images", actionTitle: "Confirm")
            return
        }
        
        self.showSpinner()
        DispatchQueue.global().async { [weak self] in
            // rotate each image 90 degree counterclockwise before processing them
            let images = self?.images.map { $0.rotate(radians: .pi / -2) }
            guard let rotatedImages = images else { return }
            
            // start to stitch the images
            var status: Int32 = 20
            let stitchedImage = CVWrapper.process(with: rotatedImages, status: &status)
            
            // if Stitch::Status returned from C++ code was NOK
            if status == -1 {
                DispatchQueue.main.async {
                    self?.removeSpinner()
                    self?.createAlert(message: "Can't stitch images", actionTitle: "Confirm")
                    self?.imageView1.isHidden = false
                    self?.imageView2.isHidden = false
                    self?.imageView3.isHidden = false
                }
                return
            }
            
            // rotate stitched image by 90 degree clockwise
            let rotatedImage = stitchedImage.rotate(radians: .pi / 2)
            self?.rotatedImage = rotatedImage

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
    
    func setupScrollView(with imageView: UIImageView) {
        let newImageView = UIImageView()
        newImageView.contentMode = .scaleAspectFit
        newImageView.image = imageView.image
        
        // give scrollView frame equals to superview(self.view) size,
        // and set its contentSize bigger then scrollView size to make it scallable
        scrollView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scrollView.addSubview(newImageView)
        scrollView.backgroundColor = .brown
        scrollView.delegate = self
        scrollView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        scrollView.addGestureRecognizer(tap)
        view.addSubview(scrollView)
        guard let height = imageView.image?.size.height else { return }
        guard let width = imageView.image?.size.width else { return }
        let ratio = width / height
        let onScreenWidth = UIScreen.main.bounds.width - 20 * 2
        let onScreenHeight = onScreenWidth / ratio
        // give a litte padding(40 points) on the bottom
        scrollView.contentSize = CGSize(width: onScreenWidth, height: onScreenHeight + 40)
        newImageView.frame = CGRect(x: 20, y: 20, width: UIScreen.main.bounds.width - 40, height: onScreenHeight)
    }
    
    // MARK: - show image on fullscreen when a tapping happened
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        guard let imageView = sender.view as? UIImageView else { return }
        setupScrollView(with: imageView)
        
        // add animation when showing scrollView
        self.navigationController?.isNavigationBarHidden = true
        UIView.transition(with: view,
                          duration: 0.33,
                          options: [.curveEaseOut, .transitionFlipFromBottom],
                          animations: {
                            self.view.addSubview(self.scrollView)
                          },
                          completion: nil)
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        
        // add animation when remove scrollView
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

