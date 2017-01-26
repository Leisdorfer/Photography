import UIKit

public class DemoView: UIView {
    private let image = UIImageView()
    private let icon = UIImageView()
    private let slider = UISlider()
    private let cameraValue = UILabel()
    private let cameraSensor = UIView()
    private let cameraSensorOpening = UIView()
    private var cameraSensorSize: CGFloat = 44
    private var cameraOpeningSize: CGFloat = 38
    private let demoInstructions = UILabel()
    private var apertureImage: String?
    
    private let cache = NSCache<NSString, UIImage>()
    var movedSlider: (Int?) ->() = { _ in }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cameraValue.font = UIFont.systemFont(ofSize: 32)
        layoutSlider()
        layoutDemoInstructions()
        addSubviews([image, cameraValue, icon, cameraSensor, cameraSensorOpening, slider, demoInstructions])
    }
    
    public func addInformation(demoInformation: CameraSectionDemoSettings) {
        layoutImage(imageView: image, image: demoInformation.image ?? "")
        layoutImage(imageView: icon, image: demoInformation.icon ?? "")
        cameraOpeningSize = CGFloat(demoInformation.cameraOpeningSize ?? 0)
        cameraSensorSize = CGFloat(demoInformation.cameraSensorSize ?? 0)
        layoutSensor(cameraSensorSize: cameraSensorSize, cameraOpeningSize: cameraOpeningSize)
        cameraValue.text = demoInformation.text
        demoInstructions.text = demoInformation.instructions
        layoutDemoInstructions()
        setNeedsLayout()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutImage(imageView: UIImageView, image: String) {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: image)
//        let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/photography-f68e7.appspot.com/o/waterfall4.jpg?alt=media&token=f040e86b-f75f-4e20-af1d-bbf14ce4f914")
//        DispatchQueue.global().async {
//            let data = try? Data(contentsOf: url!)
//            DispatchQueue.main.async {
//                imageView.image = UIImage(data: data!)
//            }
//        }
        
        
        
//        if let cachedImage = self.cache.object(forKey: "CachedObject") {
//            imageView.image = cachedImage
//        } else {
//            if let preCachedImage = UIImage(named: image) {
//                self.cache.setObject(preCachedImage, forKey: "CachedObject")
//                imageView.image = UIImage(named: image)
//            }
//        }
        
//        if let preCachedImage = UIImage(named: image) {
//            self.cache.setObject(preCachedImage, forKey: "CachedObject")
//        }
//        let cachedImage = self.cache.object(forKey: "CachedObject")
//        imageView.image = cachedImage
    }
    
    private func layoutSlider() {
        slider.isContinuous = true
        slider.minimumValue = 2
        slider.maximumValue = 22
        slider.addTarget(self, action: #selector(configureAppropriateSectionWhenSliderValueChanged), for: .valueChanged)
    }
    
    @objc private func configureAppropriateSectionWhenSliderValueChanged() {
        movedSlider(Int(slider.value))
        setNeedsLayout()
    }
    
    private func layoutDemoInstructions() {
        demoInstructions.font = UIFont.systemFont(ofSize: 12)
        demoInstructions.numberOfLines = 0
        demoInstructions.textAlignment = .center
    }
    
    private func layoutSensor(cameraSensorSize: CGFloat, cameraOpeningSize: CGFloat) {
        cameraSensor.layer.cornerRadius = cameraSensorSize/2
        cameraSensor.backgroundColor = UIColor.sensorColor()
        cameraSensorOpening.layer.cornerRadius = cameraOpeningSize/2
        cameraSensorOpening.backgroundColor = UIColor.backgroundColor()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        let cameraPadding: CGFloat = 10
        let imagePadding: CGFloat = 40
        
        image.frame = CGRect(x: bounds.minX, y: TutorialView.segmentedHeight + imagePadding, width: bounds.width, height: bounds.height * 0.5)

        cameraSensor.frame = CGRect(x: bounds.midX - cameraSensorSize - cameraPadding, y: (image.frame.maxY + slider.frame.minY)/2 - cameraSensorSize/2, width: cameraSensorSize, height: cameraSensorSize)
        
        let cameraSensorTop = (image.frame.maxY + slider.frame.minY)/2 - cameraOpeningSize/2
        cameraSensorOpening.frame = CGRect(x: cameraSensor.frame.midX - cameraOpeningSize/2, y: cameraSensorTop, width: cameraOpeningSize, height: cameraOpeningSize)
        
        let iconSize: CGFloat = 44
        let iconTop = (image.frame.maxY + slider.frame.minY)/2 - iconSize/2
        icon.frame = CGRect(x: bounds.midX - iconSize - cameraPadding, y: iconTop, width: iconSize, height: iconSize)
        
        let cameraValueSize = cameraValue.sizeThatFits(bounds.size)
        let cameraValueTop = (image.frame.maxY + slider.frame.minY)/2 - cameraValueSize.height/2
        cameraValue.frame = CGRect(x: bounds.midX, y: cameraValueTop, width: ceil(cameraValueSize.width), height: ceil(cameraValueSize.height))
        
        let sliderWidth = TutorialView.segmentedWidth
        let sliderHeight = slider.sizeThatFits(bounds.size).height
        let sliderTop = (image.frame.maxY + bounds.maxY)/2 - sliderHeight/2
        slider.frame = CGRect(x: bounds.midX - sliderWidth/2, y: sliderTop, width: sliderWidth, height: sliderHeight)
        
        let demoInstructionHeight = demoInstructions.sizeThatFits(bounds.size).height
        let demoInstructionsTop = (slider.frame.maxY + bounds.maxY)/2 - demoInstructionHeight/2
        demoInstructions.frame = CGRect(x: bounds.midX - sliderWidth/2, y: demoInstructionsTop, width: ceil(sliderWidth), height: ceil(demoInstructionHeight))
    }
}
