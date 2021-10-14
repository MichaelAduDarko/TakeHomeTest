//
//  ImageLoader.swift
//  TakeHomeTest
//
//  Created by MICHAEL ADU DARKO on 10/12/21.
//

import UIKit

public class ImageLoader {
    static let shared = ImageLoader()

    private var task: URLSessionDataTask?
    private var cache: [URL: UIImage] = [:]

    private init() {}

    func loadImage(from url: URL, into imageView: UIImageView) {
        if let image = cache[url] {
            imageView.image = image
            return
        }

        task = URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, _, error) in
            guard let self = self else { return }

            if let data = data, let image = UIImage(data: data) {
                self.cache[url] = image
                self.update(imageView: imageView, with: image)
            }
        })

        task?.resume()

    }

    func cancel() {
        task?.cancel()
        task = nil
    }

    private func update(imageView: UIImageView, with image: UIImage) {
        DispatchQueue.main.async {
            imageView.image = image
        }
    }
}
