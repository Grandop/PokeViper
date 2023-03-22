import UIKit

public final class PVImageView: UIImageView {

    public init(image: PVImageType? = nil) {
        super.init(frame: .zero)
        switch image {
        case .some(.imgUrl(url: let url)):
            load(from: url)
        default:
            self.image = image?.image
        }
    }

    public func setImage(_ image: PVImageType?, contentMode: ContentMode = .scaleAspectFit) {
        self.image = image?.image
        self.contentMode = contentMode
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { return nil }

    public var color: UIColor? {

        get { return self.tintColor }

        set {
            self.image = self.image?.withRenderingMode(newValue == nil ? .alwaysOriginal : .alwaysTemplate)
            self.tintColor = newValue
        }
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.contentMode = .scaleAspectFit
    }
    
    public func load(from url: String, defaultImage: UIImage? = nil) {
        PVImageLoader.shared.load(url, self, defaultImage: defaultImage)
        }
        
    // can be called on cell's prepareForReuse()
    public func cancelImageRequest() {
        PVImageLoader.shared.cancel(for: self)
    }
}


public enum PVImageType {
    case empty
    // New rebranding images
    case imgBackground
    case imgFinderLogo
    case imgPokemonLogo
    case imgNextButton
    case imgPikachu
    case arrowDown
    case close
    case imgUrl(url: String)
    case customImage(image: UIImage)

    public var image: UIImage? {
        
        switch self {
        case .empty: return UIImage()
        // New rebranding images:
        case .imgBackground: return UIImage(named: "bg")
        case .imgFinderLogo: return UIImage(named: "finder")
        case .imgPokemonLogo: return UIImage(named: "pokemon-logo")
        case .imgNextButton: return UIImage(named: "next")
        case .imgPikachu: return UIImage(named: "pikachu")
        case .arrowDown: return UIImage(named: "arrowDown")
        case .close: return UIImage(named: "close")
        case .imgUrl: return nil
        case .customImage(let image): return image
        }
    }
}

private class ImageCache: NSObject {
    static let imageCache = NSCache<NSString, UIImage>()
    
    class func setImage(_ image: UIImage, forKey: String) {
        imageCache.setObject(image, forKey: NSString(string: forKey))
    }
    
    class func getImage(forKey: String) -> UIImage? {
        return imageCache.object(forKey: NSString(string: forKey))
    }
}

protocol PVImageLoaderInterface: AnyObject {
    static var shared: PVImageLoaderInterface { get }
    func load(_ url: String, _ imageView: UIImageView, defaultImage: UIImage?)
    func cancel(for imageView: UIImageView)
}

class PVImageLoader: PVImageLoaderInterface {
    static var shared: PVImageLoaderInterface { PVImageLoader() }
    private let imageLoader = ImageLoader()
    private var uuidMap = [UIImageView: UUID]()
    
    private init() {}
    
    func load(
        _ url: String,
        _ imageView: UIImageView,
        defaultImage: UIImage? = nil
    ) {
        let token = imageLoader.loadImage(url) { [weak self] result in
            defer { self?.uuidMap.removeValue(forKey: imageView) }
            
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    imageView.image = image
                }
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    imageView.image = defaultImage
                }
            }
        }
        if let token = token {
            uuidMap[imageView] = token
        }
    }
    
    func cancel(for imageView: UIImageView) {
        if let uuid = uuidMap[imageView] {
            imageLoader.cancelLoad(uuid)
            uuidMap.removeValue(forKey: imageView)
        }
    }
}

private class ImageLoader {
    private var currentRequests = [UUID: URLSessionDataTask]()
    
    func loadImage(
        _ urlString: String,
        _ completion: @escaping (Result<UIImage, Error>
        ) -> Void) -> UUID? {
        
        if let cachedImage = ImageCache.getImage(forKey: urlString) {
            completion(.success(cachedImage))
            return nil
        }
        
        let uuid = UUID()
        guard let url = URL(string: urlString) else { return nil }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            defer { self?.currentRequests.removeValue(forKey: uuid) }
            
            if let data = data, let image = UIImage(data: data) {
                ImageCache.setImage(image, forKey: urlString)
                completion(.success(image))
                return
            }
            
            guard let error = error else { return }
            guard (error as NSError).code == NSURLErrorCancelled else {
                completion(.failure(error))
                return
            }
        }
        task.resume()
        
        currentRequests[uuid] = task
        return uuid
    }
    
    func cancelLoad(_ uuid: UUID) {
        currentRequests[uuid]?.cancel()
        currentRequests.removeValue(forKey: uuid)
    }
}
