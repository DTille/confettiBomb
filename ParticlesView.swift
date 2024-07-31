//
//  ParticlesView.swift
//  confettiBomb
//
//  Created by Daniel Tille on 31.07.24.
//

import SwiftUI

// UIViewRepresentable für Partikeleffekte
struct ParticleEffectView: UIViewRepresentable {
    var duration: TimeInterval
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        let emitterLayer = CAEmitterLayer()
        
        // Emitter-Position und Eigenschaften einstellen
        emitterLayer.emitterPosition = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2) // Setzt den Emitter in die Mitte des Bildschirms
        emitterLayer.emitterShape = .line                           // Der Emitter hat die Form einer Linie
        emitterLayer.emitterSize = CGSize(width: 10, height: 10)    // Die Größe des Emitters (hier eine kleine Linie)
        emitterLayer.emitterDepth = 8                               // Die Tiefe des Emitters (nützlich bei 3D-Effekten)
        emitterLayer.lifetime = 0.8                                 // Die Lebensdauer des Emitters
        
        // Array von Partikelkonfigurationen
        let cells = [
            (size: CGSize(width: 40, height: 120), color: UIColor(red: 106/255, green: 90/255, blue: 205/255, alpha: 0.5)),     // Lila
            (size: CGSize(width: 40, height: 120), color: UIColor(red: 255/255, green: 69/255, blue: 0.0, alpha: 0.9)),         // OrangeRed
            (size: CGSize(width: 40, height: 120), color: UIColor(red: 255/255, green: 185/255, blue: 15/255, alpha: 0.5)),     // DarkGoldenrod
            (size: CGSize(width: 80, height: 80), color: UIColor(red: 255/255, green: 215/255, blue: 0.0, alpha: 0.8)),         // Gold
            (size: CGSize(width: 80, height: 80), color: UIColor(red: 186/255, green: 85/255, blue: 211/255, alpha: 0.5)),      // MediumOrchid
            (size: CGSize(width: 80, height: 80), color: UIColor(red: 255/255, green: 69/255, blue: 0.0, alpha: 0.5))           // OrangeRed
        ].map { createParticleCell(size: $0.size, color: $0.color) }
        
        // Emitter mit Partikelzellen befüllen
        emitterLayer.emitterCells = cells
        view.layer.addSublayer(emitterLayer)
        
        // Partikelemitter nach gegebener Dauer stoppen
        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
            emitterLayer.birthRate = 0              // Setzt die Geburtsrate auf 0, um keine neuen Partikel zu erzeugen
        }
        
        return view
    }
    
    // Funktion zur Erstellung einer CAEmitterCell mit den gegebenen Eigenschaften
    func createParticleCell(size: CGSize, color: UIColor) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.contents = createImage(size: size, color: color)?.cgImage // Setzt das Bild der Partikel
        cell.birthRate = 15             // Die Rate, mit der die Partikel erstellt werden
        cell.lifetime = 4.0             // Die Lebensdauer der Partikel
        cell.lifetimeRange = 1          // Die maximale Abweichung von der durchschnittlichen Lebensdauer
        cell.velocity = 300             // Die Anfangsgeschwindigkeit der Partikel
        cell.velocityRange = 200        // Die maximale Abweichung von der durchschnittlichen Geschwindigkeit
        cell.emissionLongitude = .pi * 2 // Der Winkel, in dem die Partikel emittiert werden
        cell.emissionRange = .pi / 6    // Der Bereich des Emissionswinkels
        cell.yAcceleration = 250        // Die Beschleunigung der Partikel nach unten (Schwerkraft)
        cell.spin = 10                   // Die durchschnittliche Rotationsgeschwindigkeit der Partikel in Radiant pro Sekunde
        cell.spinRange = 6              // Die maximale Abweichung von der durchschnittlichen Rotationsgeschwindigkeit
        cell.scale = 0.1                // Die Größe der Partikel
        cell.scaleRange = 0.05          // Die Variationsbreite der Größe der Partikel
        return cell
    }
    
    // Funktion zur Erstellung eines Bildes (Rechteck oder Kreis) mit der gegebenen Größe und Farbe
    func createImage(size: CGSize, color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        // Erstellen eines Rechteck- oder Kreisbildes basierend auf den Dimensionen
        let path = size.width == size.height ? UIBezierPath(ovalIn: CGRect(origin: .zero, size: size)) : UIBezierPath(rect: CGRect(origin: .zero, size: size))
        context.addPath(path.cgPath)
        context.setFillColor(color.cgColor)
        context.fillPath()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    // Update der UIView (optional)
    func updateUIView(_ uiView: UIView, context: Context) {
        // Hier kann der Emitter aktuallisiert werden, wenn nötig
    }
}

#Preview {
    ParticleEffectView(duration: 0)
}
