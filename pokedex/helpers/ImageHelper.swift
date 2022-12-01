//
//  ImageHelper.swift
//  pokedex
//
//  Created by user on 1/12/22.
//

import Foundation
import Kingfisher

class ImageHelper {
    static var shared = ImageHelper()

    func downloadAndCacheImage(imageView: UIImageView, urlString: String) {
        let imageProcessor = DownsamplingImageProcessor(size: imageView.frame.size)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: URL(string: urlString),
            options: [
                .processor(imageProcessor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ]
        )
    }

}
