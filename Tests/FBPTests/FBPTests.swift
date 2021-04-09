import XCTest
@testable import FBP

final class FBPTests: XCTestCase {
    func test_C1() {
        
        /*
         This test provides a simple C1 based fire with
         no slope.
        */
        
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
        XCTAssertEqual(mains.sfi, 2001.698466615336)
        XCTAssertEqual(mains.sf, 1)
        XCTAssertEqual(mains.raz, 180)
        XCTAssertEqual(mains.isi, 11.041630714156925)
        XCTAssertEqual(mains.wsv, 4.82802)
        XCTAssertEqual(mains.ff, 41.62104842399954)
        XCTAssertEqual(mains.jd, 83)
        XCTAssertEqual(mains.jd_min, 103)
        XCTAssertEqual(mains.covertype, "c")
        
        // Secondary Output Assertions
        XCTAssertEqual(secs.lb, 1.116338263490523)
        XCTAssertEqual(secs.lbt,1.1162210194837365)
        XCTAssertEqual(secs.area, 5.46657290525333)
        XCTAssertEqual(secs.perm, 830.7029965574588)
        XCTAssertEqual(secs.pgr, 16.17258839185758)
        
        // Head Fire Output Assertions
        XCTAssertEqual(heads.ros, 4.540518390451227)
        XCTAssertEqual(heads.dist, 232.98812497336058)
        XCTAssertEqual(heads.rost, 4.535942522177003)
        XCTAssertEqual(heads.rss, 4.540518390451227)
        XCTAssertEqual(heads.cfb, 0.5591011499503589)
        XCTAssertEqual(heads.fi, 2572.8855036465434)
        XCTAssertEqual(heads.fc, 1.8888338895821213)
        XCTAssertEqual(heads.cfc, 0.41932586246276915)
        XCTAssertEqual(heads.time, 0)
        XCTAssertEqual(heads.fd, "I")
        
        // Flank Fire Output Assertions
        XCTAssertEqual(flanks.ros, 2.432952218170714)
        XCTAssertEqual(flanks.dist, 124.85546067058968)
        XCTAssertEqual(flanks.rost, 2.4307556157485712)
        XCTAssertEqual(flanks.rss, 2.432952218170714)
        XCTAssertEqual(flanks.cfb, 0.2840891100800258)
        XCTAssertEqual(flanks.fi, 1228.0872711285615)
        XCTAssertEqual(flanks.fc, 1.6825748596793715)
        XCTAssertEqual(flanks.cfc, 0.21306683256001935)
        XCTAssertEqual(flanks.time, 0)
        XCTAssertEqual(flanks.fd, "I")
        
        // Back Fire Output Assertions
        XCTAssertEqual(backs.ros, 0.8914769183249943)
        XCTAssertEqual(backs.dist, 45.744454222313806)
        XCTAssertEqual(backs.rost, 0.8905785008763732)
        XCTAssertEqual(backs.rss, 0.8914769183249943)
        XCTAssertEqual(backs.cfb, 0)
        XCTAssertEqual(backs.fi, 393.00974624106067)
        XCTAssertEqual(backs.fc, 1.4695080271193521)
        XCTAssertEqual(backs.cfc, 0)
        XCTAssertEqual(backs.isi, 6.787650675325345)
        XCTAssertEqual(backs.time, 99)
        XCTAssertEqual(backs.fd, "S")
        
    }
    
    func test_C1_with_slope() {
        /*
         This test provides a simple C1 based fire with
         10% incline slope to the N.
        */
        
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
        XCTAssertEqual(mains.isi, 11.80884578388611)
        XCTAssertEqual(mains.raz, 180.00000011291033)
        XCTAssertEqual(mains.wsv, 6.161144702827244)
        XCTAssertEqual(mains.ff, 41.62104842399954)
        XCTAssertEqual(mains.jd, 83)
        XCTAssertEqual(mains.jd_min, 103)
        XCTAssertEqual(mains.covertype, "c")
        
        // Secondary Output Assertions
        XCTAssertEqual(secs.lb, 1.1886771678129722)
        XCTAssertEqual(secs.lbt, 1.1884870217124561)
        XCTAssertEqual(secs.area, 6.834943550717048)
        XCTAssertEqual(secs.perm, 931.9525127703135)
        XCTAssertEqual(secs.pgr, 18.143770339402113)
        
        // Head Fire Output Assertions
        XCTAssertEqual(heads.ros, 5.567918297096819)
        XCTAssertEqual(heads.dist, 285.7072106069668)
        XCTAssertEqual(heads.rost, 5.562307030166872)
        XCTAssertEqual(heads.rss, 5.567918297096819)
        XCTAssertEqual(heads.cfb, 0.6518917461636173)
        XCTAssertEqual(heads.fi, 3271.308185346477)
        XCTAssertEqual(heads.fc, 1.9584268367420652)
        XCTAssertEqual(heads.cfc, 0.488918809622713)
        XCTAssertEqual(heads.time, 0)
        XCTAssertEqual(heads.fd, "I")
        
        // Flank Fire Output Assertions
        XCTAssertEqual(flanks.ros, 2.636316131689734)
        XCTAssertEqual(flanks.dist, 135.29922583232502)
        XCTAssertEqual(flanks.rost, 2.6340806499929674)
        XCTAssertEqual(flanks.rss, 2.636316131689734)
        XCTAssertEqual(flanks.cfb, 0.3168038524086477)
        XCTAssertEqual(flanks.fi, 1350.1452142671246)
        XCTAssertEqual(flanks.fc, 1.707110916425838)
        XCTAssertEqual(flanks.cfc, 0.2376028893064858)
        XCTAssertEqual(flanks.time, 0)
        XCTAssertEqual(flanks.fd, "I")
        
        // Back Fire Output Assertions
        XCTAssertEqual(backs.ros, 0.6995392886563879)
        XCTAssertEqual(backs.dist, 35.895537291955165)
        XCTAssertEqual(backs.rost, 0.698834303154233)
        XCTAssertEqual(backs.rss, 0.6995392886563879)
        XCTAssertEqual(backs.cfb, 0)
        XCTAssertEqual(backs.fi, 308.3935799897771)
        XCTAssertEqual(backs.fc, 1.4695080271193521)
        XCTAssertEqual(backs.cfc, 0)
        XCTAssertEqual(backs.isi, 6.346660253274687)
        XCTAssertEqual(backs.time, 99)
        XCTAssertEqual(backs.fd, "S")
    }
    
    func test_C1_over_20_min() {
        
        /*
         This test provides a simple C1 based fire with
         no slope and over the course of 20 minutes.
        */
        
        let fbp = FBPAlgorithm()
        let input = InputSet()
        input.fueltype = "C1"
        input.ffmc = 95.0
        input.ws = fbp.conversions(3.0, "mi2km")
        input.bui = 120.0
        input.lat = 35.00313
        input.lon = 110.00087
        input.wdir = 0.0
        input.time = 20.0
        input.mon = 2.0
        input.jd = 83.0
        
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
        XCTAssertEqual(mains.sfi, 2001.698466615336)
        XCTAssertEqual(mains.sf, 1)
        XCTAssertEqual(mains.raz, 180)
        XCTAssertEqual(mains.isi, 11.041630714156925)
        XCTAssertEqual(mains.wsv, 4.82802)
        XCTAssertEqual(mains.ff, 41.62104842399954)
        XCTAssertEqual(mains.jd, 83)
        XCTAssertEqual(mains.jd_min, 103)
        XCTAssertEqual(mains.covertype, "c")
        
        // Secondary Output Assertions
        XCTAssertEqual(secs.lb, 1.116338263490523)
        XCTAssertEqual(secs.lbt, 1.1046743237122443)
        XCTAssertEqual(secs.area, 0.3110250399124221)
        XCTAssertEqual(secs.perm, 198.06550969495902)
        XCTAssertEqual(secs.pgr, 14.635782893786224)
        
        // Head Fire Output Assertions
        XCTAssertEqual(heads.ros, 4.540518390451227)
        XCTAssertEqual(heads.dist, 55.2860959244814)
        XCTAssertEqual(heads.rost, 4.085291266722462)
        XCTAssertEqual(heads.rss, 4.540518390451227)
        XCTAssertEqual(heads.cfb, 0.5591011499503589)
        XCTAssertEqual(heads.fi, 2572.8855036465434)
        XCTAssertEqual(heads.fc, 1.8888338895821213)
        XCTAssertEqual(heads.cfc, 0.41932586246276915)
        XCTAssertEqual(heads.time, 0)
        XCTAssertEqual(heads.fd, "I")
        
        // Flank Fire Output Assertions
        XCTAssertEqual(flanks.ros, 2.432952218170714)
        XCTAssertEqual(flanks.dist, 29.936816461785405)
        XCTAssertEqual(flanks.rost, 2.2121405536007264)
        XCTAssertEqual(flanks.rss, 2.432952218170714)
        XCTAssertEqual(flanks.cfb, 0.2840891100800258)
        XCTAssertEqual(flanks.fi, 1228.0872711285615)
        XCTAssertEqual(flanks.fc, 1.6825748596793715)
        XCTAssertEqual(flanks.cfc, 0.21306683256001935)
        XCTAssertEqual(flanks.time, 0)
        XCTAssertEqual(flanks.fd, "I")
        
        // Back Fire Output Assertions
        XCTAssertEqual(backs.ros, 0.8914769183249943)
        XCTAssertEqual(backs.dist, 10.854769033559347)
        XCTAssertEqual(backs.rost, 0.8020984732881621)
        XCTAssertEqual(backs.rss, 0.8914769183249943)
        XCTAssertEqual(backs.cfb, 0)
        XCTAssertEqual(backs.fi, 393.00974624106067)
        XCTAssertEqual(backs.fc, 1.4695080271193521)
        XCTAssertEqual(backs.cfc, 0)
        XCTAssertEqual(backs.isi, 6.787650675325345)
        XCTAssertEqual(backs.time, 99)
        XCTAssertEqual(backs.fd, "S")
        
    }
    
    func test_C1_over_240_min() {
        
        /*
         This test provides a simple C1 based fire with
         no slope and over the course of 240 minutes.
        */
        
        let fbp = FBPAlgorithm()
        let input = InputSet()
        input.fueltype = "C1"
        input.ffmc = 95.0
        input.ws = fbp.conversions(3.0, "mi2km")
        input.bui = 120.0
        input.lat = 35.00313
        input.lon = 110.00087
        input.wdir = 0.0
        input.time = 240.0
        input.mon = 2.0
        input.jd = 83.0
        
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
        XCTAssertEqual(mains.sfi, 2001.698466615336)
        XCTAssertEqual(mains.sf, 1)
        XCTAssertEqual(mains.raz, 180)
        XCTAssertEqual(mains.isi, 11.041630714156925)
        XCTAssertEqual(mains.wsv, 4.82802)
        XCTAssertEqual(mains.ff, 41.62104842399954)
        XCTAssertEqual(mains.jd, 83)
        XCTAssertEqual(mains.jd_min, 103)
        XCTAssertEqual(mains.covertype, "c")
        
        // Secondary Output Assertions
        XCTAssertEqual(secs.lb, 1.116338263490523)
        XCTAssertEqual(secs.lbt,1.116338263490403)
        XCTAssertEqual(secs.area, 111.0658201889006)
        XCTAssertEqual(secs.perm, 3744.3832709778117)
        XCTAssertEqual(secs.pgr, 16.188123163984493)
        
        // Head Fire Output Assertions
        XCTAssertEqual(heads.ros, 4.540518390451227)
        XCTAssertEqual(heads.dist, 1050.241645095716)
        XCTAssertEqual(heads.rost, 4.540518390446544)
        XCTAssertEqual(heads.rss, 4.540518390451227)
        XCTAssertEqual(heads.cfb, 0.5591011499503589)
        XCTAssertEqual(heads.fi, 2572.8855036465434)
        XCTAssertEqual(heads.fc, 1.8888338895821213)
        XCTAssertEqual(heads.cfc, 0.41932586246276915)
        XCTAssertEqual(heads.time, 0)
        XCTAssertEqual(heads.fd, "I")
        
        // Flank Fire Output Assertions
        XCTAssertEqual(flanks.ros, 2.432952218170714)
        XCTAssertEqual(flanks.dist, 562.7524261160909)
        XCTAssertEqual(flanks.rost, 2.4329522181684657)
        XCTAssertEqual(flanks.rss, 2.432952218170714)
        XCTAssertEqual(flanks.cfb, 0.2840891100800258)
        XCTAssertEqual(flanks.fi, 1228.0872711285615)
        XCTAssertEqual(flanks.fc, 1.6825748596793715)
        XCTAssertEqual(flanks.cfc, 0.21306683256001935)
        XCTAssertEqual(flanks.time, 0)
        XCTAssertEqual(flanks.fd, "I")
        
        // Back Fire Output Assertions
        XCTAssertEqual(backs.ros, 0.8914769183249943)
        XCTAssertEqual(backs.dist, 206.20248719518062)
        XCTAssertEqual(backs.rost, 0.8914769183240747)
        XCTAssertEqual(backs.rss, 0.8914769183249943)
        XCTAssertEqual(backs.cfb, 0)
        XCTAssertEqual(backs.fi, 393.00974624106067)
        XCTAssertEqual(backs.fc, 1.4695080271193521)
        XCTAssertEqual(backs.cfc, 0)
        XCTAssertEqual(backs.isi, 6.787650675325345)
        XCTAssertEqual(backs.time, 99)
        XCTAssertEqual(backs.fd, "S")
        
    }
    
    func test_D1() {
        
        /*
         This tests D1 leafless aspen forest fire.
        */
        
        let fbp = FBPAlgorithm()
        let input = InputSet()
        input.fueltype = "D1"
        input.ffmc = 95.0
        input.ws = fbp.conversions(3.0, "mi2km")
        input.bui = 120.0
        input.lat = 35.00313
        input.lon = 110.00087
        input.wdir = 0.0
        input.time = 60.0
        input.mon = 2.0
        input.jd = 83.0
        
        let mains = MainOutput()
        let secs = SecondaryOutput()
        let heads = FireOutput()
        let flanks = FireOutput()
        let backs = FireOutput()
        
        fbp.sequence_calculate(input, mains, secs, heads, flanks, backs)
      
        
        // Main Output Assertions
        XCTAssertEqual(mains.sfc, 1.3331291120938)
        XCTAssertEqual(mains.csi, 0)
        XCTAssertEqual(mains.rso, 0)
        XCTAssertEqual(mains.rss, 3.1338874426931334)
        XCTAssertEqual(mains.fmc, 0)
        XCTAssertEqual(mains.sfi, 1253.362975163822)
        XCTAssertEqual(mains.sf, 1)
        XCTAssertEqual(mains.raz, 180)
        XCTAssertEqual(mains.isi, 11.041630714156925)
        XCTAssertEqual(mains.wsv, 4.82802)
        XCTAssertEqual(mains.ff, 41.62104842399954)
        XCTAssertEqual(mains.jd, 0)
        XCTAssertEqual(mains.jd_min, 0)
        XCTAssertEqual(mains.covertype, "n")
        
        // Secondary Output Assertions
        XCTAssertEqual(secs.lb, 1.116338263490523)
        XCTAssertEqual(secs.lbt, 1.1162210194837365)
        XCTAssertEqual(secs.area, 4.069220005968843)
        XCTAssertEqual(secs.perm, 716.7105384484076)
        XCTAssertEqual(secs.pgr, 13.953319757443504)
        
        // Head Fire Output Assertions
        XCTAssertEqual(heads.ros, 3.1338874426931334)
        XCTAssertEqual(heads.dist, 160.80951476513488)
        XCTAssertEqual(heads.rost, 3.130729156592109)
        XCTAssertEqual(heads.rss, 3.1338874426931334)
        XCTAssertEqual(heads.cfb, 0)
        XCTAssertEqual(heads.fi, 1253.362975163822)
        XCTAssertEqual(heads.fc, 1.3331291120938)
        XCTAssertEqual(heads.cfc, 0)
        XCTAssertEqual(heads.time, 0)
        XCTAssertEqual(heads.fd, "S")
        
        // Flank Fire Output Assertions
        XCTAssertEqual(flanks.ros, 2.0990925776488014)
        XCTAssertEqual(flanks.dist, 107.72228439801073)
        XCTAssertEqual(flanks.rost, 2.097197401982824)
        XCTAssertEqual(flanks.rss, 2.0990925776488014)
        XCTAssertEqual(flanks.cfb, 0)
        XCTAssertEqual(flanks.fi, 839.5084272730899)
        XCTAssertEqual(flanks.fc, 1.3331291120938)
        XCTAssertEqual(flanks.cfc, 0)
        XCTAssertEqual(flanks.time, 0)
        XCTAssertEqual(flanks.fd, "S")
        
        // Back Fire Output Assertions
        XCTAssertEqual(backs.ros, 1.5527072833834847)
        XCTAssertEqual(backs.dist, 79.6742414585942)
        XCTAssertEqual(backs.rost, 1.5511424876077133)
        XCTAssertEqual(backs.rss, 1.5527072833834847)
        XCTAssertEqual(backs.cfb, 0)
        XCTAssertEqual(backs.fi, 620.9877846115804)
        XCTAssertEqual(backs.fc, 1.3331291120938)
        XCTAssertEqual(backs.cfc, 0)
        XCTAssertEqual(backs.isi, 6.787650675325345)
        XCTAssertEqual(backs.time, 0)
        XCTAssertEqual(backs.fd, "S")
        
    }
    
    func test_M1() {
        
        /*
         This tests M1 mixed forest leafless boreal
         forest fire with 10% conifer.
        */
        
        let fbp = FBPAlgorithm()
        let input = InputSet()
        input.fueltype = "M1"
        input.ffmc = 95.0
        input.ws = fbp.conversions(3.0, "mi2km")
        input.bui = 120.0
        input.lat = 35.00313
        input.lon = 110.00087
        input.wdir = 0.0
        input.time = 60.0
        input.mon = 2.0
        input.jd = 83.0
        input.pc = 10.0
        
        let mains = MainOutput()
        let secs = SecondaryOutput()
        let heads = FireOutput()
        let flanks = FireOutput()
        let backs = FireOutput()
        
        fbp.sequence_calculate(input, mains, secs, heads, flanks, backs)
      
        
        // Main Output Assertions
        XCTAssertEqual(mains.sfc, 1.5740269243545417)
        XCTAssertEqual(mains.csi, 2244.7167606494463)
        XCTAssertEqual(mains.rso, 4.753660236932167)
        XCTAssertEqual(mains.rss, 4.581280251176898)
        XCTAssertEqual(mains.fmc, 92.56)
        XCTAssertEqual(mains.sfi, 2163.3175390098527)
        XCTAssertEqual(mains.sf, 1)
        XCTAssertEqual(mains.raz, 180)
        XCTAssertEqual(mains.isi, 11.041630714156925)
        XCTAssertEqual(mains.wsv, 4.82802)
        XCTAssertEqual(mains.ff, 41.62104842399954)
        XCTAssertEqual(mains.jd, 83)
        XCTAssertEqual(mains.jd_min, 103)
        XCTAssertEqual(mains.covertype, "c")
        
        // Secondary Output Assertions
        XCTAssertEqual(secs.lb, 1.116338263490523)
        XCTAssertEqual(secs.lbt, 1.1162210194837365)
        XCTAssertEqual(secs.area, 8.828159549788886)
        XCTAssertEqual(secs.perm, 1055.6581175528584)
        XCTAssertEqual(secs.pgr, 20.55213992059397)
        
        // Head Fire Output Assertions
        XCTAssertEqual(heads.ros, 4.581280251176898)
        XCTAssertEqual(heads.dist, 235.07974286458457)
        XCTAssertEqual(heads.rost, 4.576663303693374)
        XCTAssertEqual(heads.rss, 4.581280251176898)
        XCTAssertEqual(heads.cfb, 0)
        XCTAssertEqual(heads.fi, 2163.3175390098527)
        XCTAssertEqual(heads.fc, 1.5740269243545417)
        XCTAssertEqual(heads.cfc, 0)
        XCTAssertEqual(heads.time, 99)
        XCTAssertEqual(heads.fd, "S")
        
        // Flank Fire Output Assertions
        XCTAssertEqual(flanks.ros, 3.0917978740582237)
        XCTAssertEqual(flanks.dist, 158.66643207491168)
        XCTAssertEqual(flanks.rost, 3.0890064297182125)
        XCTAssertEqual(flanks.rss, 3.0917978740582237)
        XCTAssertEqual(flanks.cfb, 0)
        XCTAssertEqual(flanks.fi, 1459.9719295289328)
        XCTAssertEqual(flanks.fc, 1.5740269243545417)
        XCTAssertEqual(flanks.cfc, 0)
        XCTAssertEqual(flanks.time, 99)
        XCTAssertEqual(flanks.fd, "S")
        
        // Back Fire Output Assertions
        XCTAssertEqual(backs.ros, 2.3217042884027976)
        XCTAssertEqual(backs.dist, 119.13387027242538)
        XCTAssertEqual(backs.rost, 2.3193645086503856)
        XCTAssertEqual(backs.rss, 2.3217042884027976)
        XCTAssertEqual(backs.cfb, 0)
        XCTAssertEqual(backs.fi, 1096.3275181006215)
        XCTAssertEqual(backs.fc, 1.5740269243545417)
        XCTAssertEqual(backs.cfc, 0)
        XCTAssertEqual(backs.isi, 6.787650675325345)
        XCTAssertEqual(backs.time, 99)
        XCTAssertEqual(backs.fd, "S")
        
    }
    
    func test_M3() {
        
        /*
         This tests M3 dead balsam fir mixedwood
         forest fire with 60% dead fir.
        */
        
        let fbp = FBPAlgorithm()
        let input = InputSet()
        input.fueltype = "M3"
        input.ffmc = 95.0
        input.ws = fbp.conversions(3.0, "mi2km")
        input.bui = 120.0
        input.lat = 35.00313
        input.lon = 110.00087
        input.wdir = 0.0
        input.time = 60.0
        input.mon = 2.0
        input.jd = 83.0
        input.pdf = 60.0
        
        let mains = MainOutput()
        let secs = SecondaryOutput()
        let heads = FireOutput()
        let flanks = FireOutput()
        let backs = FireOutput()
        
        fbp.sequence_calculate(input, mains, secs, heads, flanks, backs)
      
        
        // Main Output Assertions
        XCTAssertEqual(mains.sfc, 3.7421072347012174)
        XCTAssertEqual(mains.csi, 2244.7167606494463)
        XCTAssertEqual(mains.rso, 1.9995122354536803)
        XCTAssertEqual(mains.rss, 29.61406232507023)
        XCTAssertEqual(mains.fmc, 92.56)
        XCTAssertEqual(mains.sfi, 33245.69906266142)
        XCTAssertEqual(mains.sf, 1)
        XCTAssertEqual(mains.raz, 180)
        XCTAssertEqual(mains.isi, 11.041630714156925)
        XCTAssertEqual(mains.wsv, 4.82802)
        XCTAssertEqual(mains.ff, 41.62104842399954)
        XCTAssertEqual(mains.jd, 83)
        XCTAssertEqual(mains.jd_min, 103)
        XCTAssertEqual(mains.covertype, "c")
        
        // Secondary Output Assertions
        XCTAssertEqual(secs.lb, 1.116338263490523)
        XCTAssertEqual(secs.lbt, 1.116166467854431)
        XCTAssertEqual(secs.area, 401.3650153696023)
        XCTAssertEqual(secs.perm, 7117.985342027316)
        XCTAssertEqual(secs.pgr, 139.88819977285345)
        
        // Head Fire Output Assertions
        XCTAssertEqual(heads.ros, 29.61406232507023)
        XCTAssertEqual(heads.dist, 1504.6386086463535)
        XCTAssertEqual(heads.rost, 29.570331513540452)
        XCTAssertEqual(heads.rss, 29.61406232507023)
        XCTAssertEqual(heads.cfb, 0.9982556033119429)
        XCTAssertEqual(heads.fi, 37502.685188669006)
        XCTAssertEqual(heads.fc, 4.22126992429095)
        XCTAssertEqual(heads.cfc, 0.47916268958973257)
        XCTAssertEqual(heads.time, 0)
        XCTAssertEqual(heads.fd, "C")
        
        // Flank Fire Output Assertions
        XCTAssertEqual(flanks.ros, 21.053741393521324)
        XCTAssertEqual(flanks.dist, 1069.8683482001054)
        XCTAssertEqual(flanks.rost, 21.0258872464948)
        XCTAssertEqual(flanks.rss, 21.053741393521324)
        XCTAssertEqual(flanks.cfb, 0.9875055746525812)
        XCTAssertEqual(flanks.fi, 26629.466322916433)
        XCTAssertEqual(flanks.fc, 4.216109910534456)
        XCTAssertEqual(flanks.cfc, 0.47400267583323896)
        XCTAssertEqual(flanks.time, 0)
        XCTAssertEqual(flanks.fd, "C")
        
        // Back Fire Output Assertions
        XCTAssertEqual(backs.ros, 17.392131889374046)
        XCTAssertEqual(backs.dist, 883.6637419131783)
        XCTAssertEqual(backs.rost, 17.3664490893108)
        XCTAssertEqual(backs.rss, 17.392131889374046)
        XCTAssertEqual(backs.cfb, 0.9709954487136705)
        XCTAssertEqual(backs.fi, 21956.792821784762)
        XCTAssertEqual(backs.fc, 4.208185050083779)
        XCTAssertEqual(backs.cfc, 0.4660778153825619)
        XCTAssertEqual(backs.isi, 6.787650675325345)
        XCTAssertEqual(backs.time, 0)
        XCTAssertEqual(backs.fd, "C")
        
    }
    
    func test_O1a() {
        
        /*
         This tests M3 dead balsam fir mixedwood
         forest fire with 60% dead fir.
        */
        
        let fbp = FBPAlgorithm()
        let input = InputSet()
        input.fueltype = "O1a"
        input.ffmc = 95.0
        input.ws = fbp.conversions(3.0, "mi2km")
        input.bui = 120.0
        input.lat = 35.00313
        input.lon = 110.00087
        input.wdir = 0.0
        input.time = 60.0
        input.mon = 2.0
        input.jd = 83.0
        input.cur = 20.0
        input.gfl = 100.0
        
        let mains = MainOutput()
        let secs = SecondaryOutput()
        let heads = FireOutput()
        let flanks = FireOutput()
        let backs = FireOutput()
        
        fbp.sequence_calculate(input, mains, secs, heads, flanks, backs)
      
        
        // Main Output Assertions
        XCTAssertEqual(mains.sfc, 100)
        XCTAssertEqual(mains.csi, 0)
        XCTAssertEqual(mains.rso, 0)
        XCTAssertEqual(mains.rss, 0.4005621595072791)
        XCTAssertEqual(mains.fmc, 0)
        XCTAssertEqual(mains.sfi, 12016.864785218373)
        XCTAssertEqual(mains.sf, 1)
        XCTAssertEqual(mains.raz, 180)
        XCTAssertEqual(mains.isi, 11.041630714156925)
        XCTAssertEqual(mains.wsv, 4.82802)
        XCTAssertEqual(mains.ff, 41.62104842399954)
        XCTAssertEqual(mains.jd, 0)
        XCTAssertEqual(mains.jd_min, 0)
        XCTAssertEqual(mains.covertype, "n")
        
        // Secondary Output Assertions
        XCTAssertEqual(secs.lb, 2.283818198160697)
        XCTAssertEqual(secs.lbt, 2.282524384887043)
        XCTAssertEqual(secs.area, 0.03504188161173123)
        XCTAssertEqual(secs.perm, 74.84019465398441)
        XCTAssertEqual(secs.pgr, 1.4570305732870565)
        
        // Head Fire Output Assertions
        XCTAssertEqual(heads.ros, 0.4005621595072791)
        XCTAssertEqual(heads.dist, 20.554090624354142)
        XCTAssertEqual(heads.rost, 0.4001584787994994)
        XCTAssertEqual(heads.rss, 0.4005621595072791)
        XCTAssertEqual(heads.cfb, 0)
        XCTAssertEqual(heads.fi, 12016.864785218373)
        XCTAssertEqual(heads.fc, 100)
        XCTAssertEqual(heads.cfc, 0)
        XCTAssertEqual(heads.time, 0)
        XCTAssertEqual(heads.fd, "S")
        
        // Flank Fire Output Assertions
        XCTAssertEqual(flanks.ros, 0.13615594628015065)
        XCTAssertEqual(flanks.dist, 6.990545445601988)
        XCTAssertEqual(flanks.rost, 0.13609583039282522)
        XCTAssertEqual(flanks.rss, 0.13615594628015065)
        XCTAssertEqual(flanks.cfb, 0)
        XCTAssertEqual(flanks.fi, 4084.6783884045194)
        XCTAssertEqual(flanks.fc, 100)
        XCTAssertEqual(flanks.cfc, 0)
        XCTAssertEqual(flanks.time, 0)
        XCTAssertEqual(flanks.fd, "S")
        
        // Back Fire Output Assertions
        XCTAssertEqual(backs.ros, 0.22134869629751758)
        XCTAssertEqual(backs.dist, 11.358090262141054)
        XCTAssertEqual(backs.rost, 0.22112562430665003)
        XCTAssertEqual(backs.rss, 0.22134869629751758)
        XCTAssertEqual(backs.cfb, 0)
        XCTAssertEqual(backs.fi, 6640.460888925527)
        XCTAssertEqual(backs.fc, 100)
        XCTAssertEqual(backs.cfc, 0)
        XCTAssertEqual(backs.isi, 6.787650675325345)
        XCTAssertEqual(backs.time, 0)
        XCTAssertEqual(backs.fd, "S")
        
    }
    
    func test_S1() {
        
        /*
         This tests S1 jack or lodgepole pine slash forest fire.
        */
        
        let fbp = FBPAlgorithm()
        let input = InputSet()
        input.fueltype = "S1"
        input.ffmc = 95.0
        input.ws = fbp.conversions(3.0, "mi2km")
        input.bui = 120.0
        input.lat = 35.00313
        input.lon = 110.00087
        input.wdir = 0.0
        input.time = 60.0
        input.mon = 2.0
        input.jd = 83.0
        
        let mains = MainOutput()
        let secs = SecondaryOutput()
        let heads = FireOutput()
        let flanks = FireOutput()
        let backs = FireOutput()
        
        fbp.sequence_calculate(input, mains, secs, heads, flanks, backs)
      
        
        // Main Output Assertions
        XCTAssertEqual(mains.sfc, 7.7332218639177235)
        XCTAssertEqual(mains.csi, 0)
        XCTAssertEqual(mains.rso, 0)
        XCTAssertEqual(mains.rss, 18.53006966637588)
        XCTAssertEqual(mains.fmc, 0)
        XCTAssertEqual(mains.sfi, 42989.14196518096)
        XCTAssertEqual(mains.sf, 1)
        XCTAssertEqual(mains.raz, 180)
        XCTAssertEqual(mains.isi, 11.041630714156925)
        XCTAssertEqual(mains.wsv, 4.82802)
        XCTAssertEqual(mains.ff, 41.62104842399954)
        XCTAssertEqual(mains.jd, 0)
        XCTAssertEqual(mains.jd_min, 0)
        XCTAssertEqual(mains.covertype, "n")
        
        // Secondary Output Assertions
        XCTAssertEqual(secs.lb, 1.116338263490523)
        XCTAssertEqual(secs.lbt, 1.1162210194837365)
        XCTAssertEqual(secs.area, 157.72688893049968)
        XCTAssertEqual(secs.perm, 4462.118231129019)
        XCTAssertEqual(secs.pgr, 86.87100179836868)
        
        // Head Fire Output Assertions
        XCTAssertEqual(heads.ros, 18.53006966637588)
        XCTAssertEqual(heads.dist, 950.8355249202324)
        XCTAssertEqual(heads.rost, 18.511395332166853)
        XCTAssertEqual(heads.rss, 18.53006966637588)
        XCTAssertEqual(heads.cfb, 0)
        XCTAssertEqual(heads.fi, 42989.14196518096)
        XCTAssertEqual(heads.fc, 7.7332218639177235)
        XCTAssertEqual(heads.cfc, 0)
        XCTAssertEqual(heads.time, 0)
        XCTAssertEqual(heads.fd, "S")
        
        // Flank Fire Output Assertions
        XCTAssertEqual(flanks.ros, 13.068594302842895)
        XCTAssertEqual(flanks.dist, 670.6606688828947)
        XCTAssertEqual(flanks.rost, 13.056795260640085)
        XCTAssertEqual(flanks.rss, 13.068594302842895)
        XCTAssertEqual(flanks.cfb, 0)
        XCTAssertEqual(flanks.fi, 30318.70175802458)
        XCTAssertEqual(flanks.fc, 7.7332218639177235)
        XCTAssertEqual(flanks.cfc, 0)
        XCTAssertEqual(flanks.time, 0)
        XCTAssertEqual(flanks.fd, "S")
        
        // Back Fire Output Assertions
        XCTAssertEqual(backs.ros, 10.64787407421968)
        XCTAssertEqual(backs.dist, 546.3755461759865)
        XCTAssertEqual(backs.rost, 10.637143301877337)
        XCTAssertEqual(backs.rss, 10.64787407421968)
        XCTAssertEqual(backs.cfb, 0)
        XCTAssertEqual(backs.fi, 24702.71177849949)
        XCTAssertEqual(backs.fc, 7.7332218639177235)
        XCTAssertEqual(backs.cfc, 0)
        XCTAssertEqual(backs.isi, 6.787650675325345)
        XCTAssertEqual(backs.time, 0)
        XCTAssertEqual(backs.fd, "S")
        
    }
    
    func test_M1_FMC() {
        
        /*
         This tests S1 jack or lodgepole pine slash forest fire.
        */
        
        let fbp = FBPAlgorithm()
        let input = InputSet()
        input.fueltype = "M1"
        input.ffmc = 97.0
        input.ws = fbp.conversions(6.0, "mi2km")
        input.bui = 120.0
        input.pc = 15.0
        input.fmc = 5.0
        input.lat = 64.8378
        input.lon = -147.7164
        input.wdir = 45
        input.time = 60.0
        input.mon = 3.0
        input.jd = 99.0
        input.ps = 10.0
        input.saz = 180.0
        
        let mains = MainOutput()
        let secs = SecondaryOutput()
        let heads = FireOutput()
        let flanks = FireOutput()
        let backs = FireOutput()
        
        fbp.sequence_calculate(input, mains, secs, heads, flanks, backs)
      
        
        // Main Output Assertions
        XCTAssertEqual(mains.sfc, 1.6944758304849126)
        XCTAssertEqual(mains.csi, 210.3548790805671)
        XCTAssertEqual(mains.rso, 0.4138052120034652)
        XCTAssertEqual(mains.rss, 11.909719448582615)
        XCTAssertEqual(mains.fmc, 5.0)
        XCTAssertEqual(mains.sfi, 6054.219526043803)
        XCTAssertEqual(mains.sf, 1.249717130124279)
        XCTAssertEqual(mains.raz, 214.11722357679082)
        XCTAssertEqual(mains.isi, 20.95681908753616)
        XCTAssertEqual(mains.wsv, 12.173288824737837)
        XCTAssertEqual(mains.ff, 54.55826767723967)
        XCTAssertEqual(mains.jd, 99.0)
        XCTAssertEqual(mains.jd_min, 0)
        XCTAssertEqual(mains.covertype, "c")
        
        // Secondary Output Assertions
        XCTAssertEqual(secs.lb, 1.680008679635945)
        XCTAssertEqual(secs.lbt, 1.6788140901936326)
        XCTAssertEqual(secs.area, 24.290918563307613)
        XCTAssertEqual(secs.perm, 1835.0780541415877)
        XCTAssertEqual(secs.pgr, 36.231790246973915)
        
        // Head Fire Output Assertions
        XCTAssertEqual(heads.ros, 11.909719448582615)
        XCTAssertEqual(heads.dist, 602.1472003985743)
        XCTAssertEqual(heads.rost, 11.888797325762367)
        XCTAssertEqual(heads.rss, 11.909719448582615)
        XCTAssertEqual(heads.cfb, 0.9289278893509791)
        XCTAssertEqual(heads.fi, 6452.497265848633)
        XCTAssertEqual(heads.fc, 1.8059471772070301)
        XCTAssertEqual(heads.cfc, 0.1114713467221175)
        XCTAssertEqual(heads.time, 0)
        XCTAssertEqual(heads.fd, "C")
        
        // Flank Fire Output Assertions
        XCTAssertEqual(flanks.ros, 4.241658238029177)
        XCTAssertEqual(flanks.dist, 214.607914181383)
        XCTAssertEqual(flanks.rost, 4.237219727199958)
        XCTAssertEqual(flanks.rss, 4.241658238029177)
        XCTAssertEqual(flanks.cfb, 0.5853855372582116)
        XCTAssertEqual(flanks.fi, 2245.6044035705377)
        XCTAssertEqual(flanks.fc, 1.764722094955898)
        XCTAssertEqual(flanks.cfc, 0.07024626447098539)
        XCTAssertEqual(flanks.time, 0)
        XCTAssertEqual(flanks.fd, "I")
        
        // Back Fire Output Assertions
        XCTAssertEqual(backs.ros, 2.342325863294038)
        XCTAssertEqual(backs.dist, 118.426379990969)
        XCTAssertEqual(backs.rost, 2.3382110367770528)
        XCTAssertEqual(backs.rss, 2.342325863294038)
        XCTAssertEqual(backs.cfb, 0.3582521117172205)
        XCTAssertEqual(backs.fi, 1220.9135234682146)
        XCTAssertEqual(backs.fc, 1.737466083890979)
        XCTAssertEqual(backs.cfc, 0.04299025340606646)
        XCTAssertEqual(backs.isi, 6.145007964355635)
        XCTAssertEqual(backs.time, 0)
        XCTAssertEqual(backs.fd, "I")
        
    }

    static var allTests = [
        ("C1", test_C1), ("C1 with 10% slope N", test_C1_with_slope),
        ("C1 over 20 minutes", test_C1_over_20_min),
        ("C1 over 240 minutes", test_C1_over_240_min),
        ("D1", test_D1),
        ("M1 with 10% conifer", test_M1),
        ("M1 with 15% conifer, 5% FMC and 10% slope", test_M1_FMC),
        ("M3 with 60% dead fir", test_M3),
        ("O1a with 20% cured grass & 100 grass fuel load", test_O1a)
    ]
}

