//
//  ParticlesView.swift
//  Hackaton-2
//
//  Created by Karsten Flache on 29.07.24.
//

//import SwiftUI
//
//struct ParticlesView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
import SwiftUI
import UIKit

// UIViewRepresentable für Partikeleffekte
struct ParticleEffectView: UIViewRepresentable {
    var duration: TimeInterval
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        let emitterLayer = CAEmitterLayer()
        
        emitterLayer.frame = CGRect(x: 50, y: 50, width: 300, height: 300)
        emitterLayer.emitterPosition = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        emitterLayer.emitterShape = .circle
        emitterLayer.emitterSize = CGSize(width: 100, height: 100)
        
        let cell = CAEmitterCell()
        cell.birthRate = 10
        cell.lifetime = 1.0
        cell.velocity = 300
        cell.velocityRange = 50
        cell.emissionRange = .pi * 2
        cell.scale = 0.5
        cell.scaleRange = 0.02
        
        //let textLayer = CATextLayer()
        //textLayer.string = "🎉"
        //textLayer.string="💩"
        //textLayer.fontSize = 50
        //textLayer.foregroundColor = UIColor.red.cgColor
        //textLayer.frame = CGRect(x: 0, y: 0, width: 50, height: 50)

        //UIGraphicsBeginImageContext(textLayer.bounds.size)
        //textLayer.render(in: UIGraphicsGetCurrentContext()!)
        
        // Erstellen eines Rechtecks als Bild für die CAEmitterCell
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 50, height: 50))
        
        //let textImage = UIGraphicsGetImageFromCurrentImageContext()!
        //UIGraphicsEndImageContext()
        //cell.contents = textImage.cgImage
        
        //cell.contents = UIImage(named: "radial-gradient-red")?.cgImage // Bild für Konfetti
        
        let image = renderer.image { ctx in
                    // Rechteck mit verschiedenen Farben zeichnen
                    let rect1 = CGRect(x: 0, y: 0, width: 50, height: 25)
                    ctx.cgContext.setFillColor(UIColor.red.cgColor)
                    ctx.cgContext.fill(rect1)
                    
                    let rect2 = CGRect(x: 0, y: 25, width: 50, height: 25)
                    ctx.cgContext.setFillColor(UIColor.blue.cgColor)
                    ctx.cgContext.fill(rect2)
                }
        
        cell.contents = image.cgImage
        
        emitterLayer.emitterCells = [cell]
        view.layer.addSublayer(emitterLayer)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            emitterLayer.birthRate = 0
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // Hier können Sie den Emitter aktualisieren, wenn nötig
    }
}

#Preview {
    ParticleEffectView(duration: 10)
}
