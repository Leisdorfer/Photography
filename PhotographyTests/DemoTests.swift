import XCTest
import Photography

class DemoTests: XCTestCase {
    var content: Content?
    let model = PhotographyModel()

    func testNoImageDisplayedWhenNotDemo() {
        var testObject: String?
        model.fetchContent { self.content = $0.0 }
        guard let content = content else { return }
        let setUp = TutorialSetUp(currentPage: .aperture, currentSegment: .intro)
        let demo = DemoModel(setUp: setUp, content: content)
        demo.shareInformation = { testObject = $0.image }
        demo.configureDemo(sliderValue: nil)
        XCTAssertEqual(testObject, nil)
    }
    
    func testNoTextDisplayedWhenNotDemo() {
        var testObject: String?
        guard let content = content else { return }
        let setUp = TutorialSetUp(currentPage: .aperture, currentSegment: .intro)
        let demo = DemoModel(setUp: setUp, content: content)
        demo.shareInformation = { testObject = $0.text }
        demo.configureDemo(sliderValue: nil)
        XCTAssertEqual(testObject, nil)
    }
    
    func testImageDisplayedWhenDemo() {
        var testObject: String?
        guard let content = content else { return }
        let setUp = TutorialSetUp(currentPage: .shutter, currentSegment: .demo)
        let demo = DemoModel(setUp: setUp, content: content)
        demo.shareInformation = { testObject = $0.image }
        demo.configureDemo(sliderValue: 0)
        XCTAssertEqual(testObject, "waterfall2.8")
    }
    
    func testCorrectShutterImageDisplayedWhenSliderValueChanged() {
        var testObject: String?
        guard let content = content else { return }
        let setUp = TutorialSetUp(currentPage: .shutter, currentSegment: .demo)
        let demo = DemoModel(setUp: setUp, content: content)
        demo.shareInformation = { testObject = $0.image }
        demo.configureDemo(sliderValue: 8)
        XCTAssertEqual(testObject, "waterfall8")
    }
    
    func testCorrectApertureImageDisplayedWhenSliderValueChanged() {
        var testObject: String?
        guard let content = content else { return }
        let setUp = TutorialSetUp(currentPage: .aperture, currentSegment: .demo)
        let demo = DemoModel(setUp: setUp, content: content)
        demo.shareInformation = { testObject = $0.image }
        demo.configureDemo(sliderValue: 6)
        XCTAssertEqual(testObject, "fountain5.6")
    }
    
    func testCorrectISOTextDisplayedWhenSliderValueChanged() {
        var testObject: String?
        guard let content = content else { return }
        let setUp = TutorialSetUp(currentPage: .iso, currentSegment: .demo)
        let demo = DemoModel(setUp: setUp, content: content)
        demo.shareInformation = { testObject = $0.text }
        demo.configureDemo(sliderValue: 16)
        XCTAssertEqual(testObject, "3200")
    }
    
    func testCorrectCameraSizeWhenApertureSliderValueChanged() {
        var testObject: Int?
        guard let content = content else { return }
        let setUp = TutorialSetUp(currentPage: .aperture, currentSegment: .demo)
        let demo = DemoModel(setUp: setUp, content: content)
        demo.shareInformation = { testObject = $0.cameraOpeningSize }
        demo.configureDemo(sliderValue: 22)
        XCTAssertEqual(testObject, 8)
    }
    

}
