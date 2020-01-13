import XCTest
@testable import GNUBallisticsSwift

class GNUBallisticsSwiftTests: XCTestCase {
    
    let testObject = GNUBallisticsSwift()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDegreesToRadians() {
        let input = Double.random(in: 0...1000.0)
        let result = testObject.radians(degrees: input)
        let target = input * Double.pi / 180.0
        XCTAssert(result == target, "Conversion from degrees to radians failed!\nExpected: \(target)\n  Result: \(result)")
    }

    func testMOAToRadians() {
        let input = Double.random(in: 0...1000.0)
        let result = testObject.radians(moa: input)
        let target = input * Double.pi / (180.0 * 60.0)
        XCTAssert(result == target, "Conversion from MOA to radians failed!\nExpected: \(target)\n  Result: \(result)")
    }
    
    func testRadiansToDegrees() {
        let input = Double.random(in: 0...(8 * Double.pi))
        let result = testObject.degrees(radians: input)
        let target = input * 180.0 / Double.pi
        XCTAssert(result == target, "Conversion from radians to degrees failed!\nExpected: \(target)\n  Result: \(result)")
    }
    
    func testMOAToDegrees() {
        let input = Double.random(in: 0...1000.0)
        let result = testObject.degrees(moa: input)
        let target = input / 60.0
        XCTAssert(result == target, "Conversion from MOA to radians failed!\nExpected: \(target)\n  Result: \(result)")
    }

    func testDegreesToMOA() {
        let input = Double.random(in: 0...1000.0)
        let result = testObject.moa(degrees: input)
        let target = input * 60.0
        XCTAssert(result == target, "Conversion from degrees to MOA failed!\nExpected: \(target)\n  Result: \(result)")
    }
    func testRadiansToMOA() {
        let input = Double.random(in: 0...(8 * Double.pi))
        let result = testObject.moa(radians: input)
        let target = input * (180.0 * 60.0) / Double.pi
        XCTAssert(result == target, "Conversion from radians to MOA failed!\nExpected: \(target)\n  Result: \(result)")
    }


    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
