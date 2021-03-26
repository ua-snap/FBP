import XCTest
@testable import FBP

final class FBPTests: XCTestCase {
    func C1() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let fbp = FBPAlgorithm()
        let input = InputSet()
        input.fueltype = "C1"
        input.ffmc = 95.0
        input.ws = fbp.conversions(3.0, "mi2km")
        input.bui = 120.0
        input.lat = 35.00313
        input.lon = 110.00087
        input.wdir = 0.0
        input.time = 60.0
        input.mon = 2.0
        input.jd = 83.0
        input.ps = 10.0
        input.saz = 180.0
        
        let mains = MainOutput()
        let secs = SecondaryOutput()
        let heads = FireOutput()
        let flanks = FireOutput()
        let backs = FireOutput()
        
        fbp.sequence_calculate(input, mains, secs, heads, flanks, backs)
      
        
        // Main Output Assertions
        XCTAssertEqual(mains.sfc, 1.4695080271193521)
        XCTAssertEqual(mains.csi, 431.9959420051409)
        XCTAssertEqual(mains.rso, 0.979910586928366)
        XCTAssertEqual(mains.fmc, 92.56)
        XCTAssertEqual(mains.sfi, 2454.630189578547)
        XCTAssertEqual(mains.sf, 1.249717130124279)
        XCTAssertEqual(mains.raz, 180)
        XCTAssertEqual(mains.wsv, 6.161144702827245)
        XCTAssertEqual(mains.ff, 41.62104842399954)
        XCTAssertEqual(mains.jd, 83)
        XCTAssertEqual(mains.jd_min, 103)
        XCTAssertEqual(mains.covertype, "c")
        
        // Secondary Output Assertions
        XCTAssertEqual(secs.lb, 1.188677167812972)
        XCTAssertEqual(secs.lbt, 1.188487021712456)
        XCTAssertEqual(secs.area, 6.834943667308616)
        XCTAssertEqual(secs.perm, 931.9525286677097)
        XCTAssertEqual(secs.pgr, 18.14377064890147)
        
        // Head Fire Output Assertions
        XCTAssertEqual(heads.ros, 5.567918297096819)
        XCTAssertEqual(heads.dist, 285.7072106069668)
        XCTAssertEqual(heads.rost, 5.562307030166872)
        XCTAssertEqual(heads.rss, 5.567918297096819)
        XCTAssertEqual(heads.cfb, 0.6518917461636173)
        XCTAssertEqual(heads.fi, 3271.308185346477)
        XCTAssertEqual(heads.fc, 1.958426836742065)
        XCTAssertEqual(heads.cfc, 0.488918809622713)
        XCTAssertEqual(heads.time, 0)
        XCTAssertEqual(heads.fd, "I")
        
        // Flank Fire Output Assertions
        XCTAssertEqual(flanks.ros, 2.636316131689734)
        XCTAssertEqual(flanks.dist, 135.299225832325)
        XCTAssertEqual(flanks.rost, 2.634080649992967)
        XCTAssertEqual(flanks.rss, 2.636316131689734)
        XCTAssertEqual(flanks.cfb, 0.3168038524086477)
        XCTAssertEqual(flanks.fi, 1350.145214267125)
        XCTAssertEqual(flanks.fc, 1.707110916425838)
        XCTAssertEqual(flanks.cfc, 0.2376028893064858)
        XCTAssertEqual(flanks.time, 0)
        XCTAssertEqual(flanks.fd, "I")
        
        // Back Fire Output Assertions
        XCTAssertEqual(backs.ros, 0.6995392886563879)
        XCTAssertEqual(backs.dist, 135.299225832325)
        XCTAssertEqual(backs.rost, 2.634080649992967)
        XCTAssertEqual(backs.rss, 2.636316131689734)
        XCTAssertEqual(backs.cfb, 0.3168038524086477)
        XCTAssertEqual(backs.fi, 1350.145214267125)
        XCTAssertEqual(backs.fc, 1.707110916425838)
        XCTAssertEqual(backs.cfc, 0.2376028893064858)
        XCTAssertEqual(backs.time, 0)
        XCTAssertEqual(backs.fd, "I")
        
    }

    static var allTests = [
        ("C1", C1),
    ]
}
