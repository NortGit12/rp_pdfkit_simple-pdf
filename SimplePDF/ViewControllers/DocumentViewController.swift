//
//  PDFViewController.swift
//  SimplePDF
//
//  Created by Jeff Norton on 2/13/18.
//  Copyright © 2018 Jeff Norton. All rights reserved.
//

import PDFKit
import UIKit

protocol DocumentViewControllerDelegate {
    func didSaveDocument()
}

class DocumentViewController: UIViewController {
    
    //==================================================
    // MARK: - _Properties
    //==================================================
    
    // General
    var delegate: DocumentViewControllerDelegate?
    var document: PDFDocument?
    
    // Outlets
    @IBOutlet weak var pdfView: PDFView!
    
    //==================================================
    // MARK: - _View Lifecycle
    //==================================================

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        
        loadPDF{
            self.provideAnnotationDetails()
        }
    }
    
    //==================================================
    // MARK: - Methods
    //==================================================
    
    private func configureNavigationBar() {
//        navigationItem.leftBarButtonItem
    }
    
    private func loadPDF(completion: (()->Void)? = nil) {
        if let document = document {
            if document.isEncrypted || document.isLocked {
                document.delegate = self
                
                if let page = document.page(at: 0) {
                    for annotation in page.annotations {
                        annotation.isReadOnly = true
                    }
                }
            }
            
            pdfView.displayMode = .singlePageContinuous
            pdfView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
            
            pdfView.autoScales = true
            
            pdfView.document = document
        }
        
        if let completion = completion {
            completion()
        }
    }
    
    private func provideAnnotationDetails() {
        if let document = document {
            
            for pageIndex in 0 ..< document.pageCount {
                if let page = document.page(at: pageIndex) {
                    
                    for annotation in page.annotations {
                        print("\n\(String(describing: annotation.fieldName))\(!annotation.buttonWidgetStateString.isEmpty ? " [\(annotation.buttonWidgetStateString)]" : ""):")
                        
                        print("\tAccessing info")
                        print("\t\ttype = \(String(describing: annotation.type))")
                        print("\t\tcontents = \(String(describing: annotation.contents))")
                        print("\tManaging display characteristics")
                        print("\t\tbounds = \(annotation.bounds)")
                        print("\t\tborder = \(String(describing: annotation.border))")
                        print("\t\tcolor = \(annotation.color)")
                        print("\t\thasAppearanceStream = \(annotation.hasAppearanceStream)")
                        print("\tManaging drawing & output")
                        print("\t\tshouldDisplay = \(annotation.shouldDisplay)")
                        print("\t\tshouldPrint = \(annotation.shouldPrint)")
                        print("\tAnnotation Keys")
                        print("\t\tannotationKeyValues = \(annotation.annotationKeyValues)")
                        print("\tInstance properties")
                        print("\t\taction = \(String(describing: annotation.action))")
                        print("\t\talignment = \(annotation.alignment)")
                        print("\t\tallowsToggleToOff = \(annotation.allowsToggleToOff)")
                        print("\t\tbackgroundColor = \(String(describing: annotation.backgroundColor))")
                        print("\t\tbuttonWidgetState = \(annotation.buttonWidgetState)")
                        print("\t\tbuttonWidgetStateString = \(annotation.buttonWidgetStateString)")
                        print("\t\tcaption = \(String(describing: annotation.caption))")
                        print("\t\tchoices = \(String(describing: annotation.choices))")
                        print("\t\tdestination = \(String(describing: annotation.destination))")
                        print("\t\tendLineStyle[.rawValue] = \(String(describing: annotation.endLineStyle.rawValue))")
                        print("\t\tendPoint = \(String(describing: annotation.endPoint))")
                        print("\t\tfieldName = \(String(describing: annotation.fieldName))")
                        print("\t\tfont = \(String(describing: annotation.font))")
                        print("\t\tfontColor = \(String(describing: annotation.fontColor))")
                        print("\t\thasComb = \(String(describing: annotation.hasComb))")
                        print("\t\tinteriorColor = \(String(describing: annotation.interiorColor))")
                        print("\t\tisHighlighted = \(String(describing: annotation.isHighlighted))")
                        print("\t\tisListChoice = \(String(describing: annotation.isListChoice))")
                        print("\t\tisMultiline = \(String(describing: annotation.isMultiline))")
                        print("\t\tisOpen = \(String(describing: annotation.isOpen))")
                        print("\t\tisPasswordField = \(String(describing: annotation.isPasswordField))")
                        print("\t\tisReadOnly = \(String(describing: annotation.isReadOnly))")
                        print("\t\tmarkupType[.rawValue] = \(String(describing: annotation.markupType.rawValue))")
                        print("\t\tmaximumLength = \(String(describing: annotation.maximumLength))")
                        print("\t\tpaths = \(String(describing: annotation.paths))")
                        print("\t\tquadrilateralPoints = \(String(describing: annotation.quadrilateralPoints))")
                        print("\t\tradiosInUnison = \(String(describing: annotation.radiosInUnison))")
                        print("\t\tstampName = \(String(describing: annotation.stampName))")
                        print("\t\tstartLineStyle[.rawValue] = \(String(describing: annotation.startLineStyle.rawValue))")
                        print("\t\tstartPoint = \(String(describing: annotation.startPoint))")
                        print("\t\turl = \(String(describing: annotation.url))")
                        print("\t\tvalues = \(String(describing: annotation.values))")
                        print("\t\twidgetControlType = \(String(describing: annotation.widgetControlType))")
                        print("\t\twidgetControlType[.rawValue] = \(String(describing: annotation.widgetControlType.rawValue))")
                        print("\t\twidgetDefaultStringValue = \(String(describing: annotation.widgetDefaultStringValue))")
//                        print("\t\twidgetFieldType.rawValue = \(String(describing: annotation.widgetFieldType.rawValue))")
                        print("\t\twidgetStringValue = \(String(describing: annotation.widgetStringValue))")
                        
                    }
                }
            }
        }
    }
}

extension DocumentViewController: PDFDocumentDelegate {
    func classForPage() -> AnyClass {
        // 4) Indicate that you want the LockedMark class to take control of drawing the pages of the document
        return LockedMark.self
    }
}









