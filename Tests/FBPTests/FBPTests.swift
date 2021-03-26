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
        XCTAssertEqual(secs.area, 5.466572998503012)
        XCTAssertEqual(secs.perm, 830.7030107277245)
        XCTAssertEqual(secs.pgr, 16.1725886677322)
        
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
        XCTAssertEqual(mains.raz, 180)
        XCTAssertEqual(mains.wsv, 6.161144702827245)
        XCTAssertEqual(mains.ff, 41.62104842399954)
        XCTAssertEqual(mains.jd, 83)
        XCTAssertEqual(mains.jd_min, 103)
        XCTAssertEqual(mains.covertype, "c")
        
        // Secondary Output Assertions
        XCTAssertEqual(secs.lb, 1.1886771678129722)
        XCTAssertEqual(secs.lbt, 1.1884870217124561)
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
        XCTAssertEqual(secs.area, 0.31102504521793733)
        XCTAssertEqual(secs.perm, 198.06551307359243)
        XCTAssertEqual(secs.pgr, 14.635783143445767)
        
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
        XCTAssertEqual(secs.area, 111.06582208347926)
        XCTAssertEqual(secs.perm, 3744.383334850105)
        XCTAssertEqual(secs.pgr, 16.188123440124105)
        
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
    
    func test_M1() {
        
        /*
         This test an M1 mixed forest leafless boreal
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
        XCTAssertEqual(secs.area, 8.828159700381056)
        XCTAssertEqual(secs.perm, 1055.6581355604449)
        XCTAssertEqual(secs.pgr, 20.552140271175688)
        
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
         This test an M3 dead balsam fir mixedwood
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
        XCTAssertEqual(secs.area, 401.36502221615143)
        XCTAssertEqual(secs.perm, 7117.985463447058)
        XCTAssertEqual(secs.pgr, 139.88820215908893)
        
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

    static var allTests = [
        ("C1", test_C1), ("C1 with 10% slope N", test_C1_with_slope),
        ("C1 over 20 minutes", test_C1_over_20_min),
        ("C1 over 240 minutes", test_C1_over_240_min),
        ("M1 with 10% conifer", test_M1),
        ("M3 with 60% dead fir", test_M3)
    ]
}

