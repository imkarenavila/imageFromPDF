//
//  DocumentViewController.swift
//  AprendiendoImageFromPDF
//
//  Created by Karen Avila Olivarez on 02/07/20.
//  Copyright © 2020 Karen Avila. All rights reserved.
//

import UIKit
import PDFKit

class DocumentViewController: UIViewController {
    
    @IBOutlet weak var pdfView: PDFView?
    @IBOutlet weak var pageImage: UIImageView!
    
    
    
       //@IBOutlet weak var thumbnailView: PDFThumbnailView?
       //@IBOutlet var thumbnailViewContainer: UIView?
       //@IBOutlet weak var collectionView: UICollectionView!
       //@IBOutlet weak var CollectionViewCell: UICollectionViewCell!
       //@IBOutlet weak var pageImage: UIImageView!
    
         
      // Vars para Abrir el PDF
       
       var openDocument: UIDocument!
       var documentURL: URL!
       var pdfDocument: PDFDocument!
    
    
    // All vars to Collect Data
    var pdfDocumentForPages: PDFDocument!
    var numberOfPages: Int = 0
    var pageImages: PDFPage!// Array para Paginas
    var pageImgThumbnail: UIImage! // Array para Imagenes de Paginas -- esta es la Data Final
    var pageImgThumbnails: UIImage! // Array para Imagenes de Paginas -- esta es la Data Final
    //var n: Int = 0
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        // Access the document
        openDocument?.open(completionHandler: { (success) in
            if success {
                // Display the content of the document, e.g.:
                
                //Save documet URL
                self.documentURL = self.openDocument?.fileURL.absoluteURL
                self.pdfDocument = PDFDocument(url: self.documentURL)
                self.pdfView?.document = self.pdfDocument
                
                self.setupPDFView()
                
                self.pdfDocumentForPages = self.pdfDocument
                
                
            } else {
                // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
            }
        })
        //print(pageImage?.image!)
       
    }
    
    @IBAction func dismissDocumentViewController() {
        dismiss(animated: true) {
            self.openDocument?.close(completionHandler: nil)
        }
    }
    
    @IBAction func thumbnailsButton(_ sender: UIButton) {
               
        let fullSizedImage = UIImage(named: "ios11-ipad.jpg")
        //let thumbnailSize = CGSize(width: 78.0, height: 100.0)
              
        if let page = pdfDocument.page(at: 1){
            
            pageImages = page
            print(pageImages!.thumbnail(of: CGSize(width: 100, height: 100), for: .artBox))
            
            pageImgThumbnail = pageImages!.thumbnail(of: CGSize(width: 78, height: 100), for: .artBox)
            print(pageImgThumbnail!)
            
            print(fullSizedImage!)
            
            // TODO ESTA BIEN HASTA AQUI, NO ME DEJA MOSTRAR EL CONTENIDO DE pageImgThumbnail EN FORMA DE IMAGEN EN EL pageImage UIImageView
            
            // TAL VEZ SEA HORA DE USAR OTRO METODO, TAL VEZ EL DE func draw(with: PDFDisplayBox, to: CGContext)?
            //pageImage.image = pageImgThumbnail!
            
            pageImage?.image = fullSizedImage
            print(pageImage?.image!)
            
            //if let imageSample = imageToLoad {
              //  print("si pude entrar a convertir la imagen!")
                //pageImage!.image = imageSample
            //}
            
            
            // ESTI DE AQUI ES EN SUSTITUCIÒN DE LA FUNCION imagesFromArray para convertir un PDFPage en UIImage
            //pageImage!.image = pageImages!.thumbnail(of: CGSize(width: 100, height: 100), for: .artBox)
               
            //Mostrar imagen en UIImageView
            //   pageImage.image = pageImgThumbnails!
        }
           
           

        
            
    }
    
    
    func setupPDFView() {
        view.addSubview(pdfView!)
        pdfView!.displayDirection = .horizontal
        pdfView!.usePageViewController(true)
        pdfView!.pageBreakMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        pdfView!.autoScales = true
                
        
    }
    
    
}

extension UIImage {
  func thumbnailOfSize(_ newSize: CGSize) -> UIImage? {
    let renderer = UIGraphicsImageRenderer(size: newSize)
    let thumbnail = renderer.image { _ in
      draw(in: CGRect.init(origin: CGPoint.zero, size: newSize))
    }
    return thumbnail
  }
}
