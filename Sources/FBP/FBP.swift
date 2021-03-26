//
//  FBPAlgorithm.swift
//  consumer-ios
//
//  Created by Scenarios Network of Alaska & Arctic Planning on 3/16/21.
//  Copyright © 2021 University of Alaska Fairbanks. All rights reserved.
//

// ISI = Initial Spread Index
// BUI = Build up index
// FFMC = Fine fuel moisture code
// FMC = Foilar moisture content

/* conversions

 heads ros = mmin2chph
 heads dist = m2ch
 heads flamelength = kwm2flft
 heads intensity = kwm2bfs
 heads consumption = kgmm2tpa
 effective wind = km2mi
 
*/

import Foundation

public class MainOutput {
    // Surface fuel consumption
    var sfc: Double = 0.0
    // Critical surface intensity
    var csi: Double = 0.0
    // Final rate of spread
    var rso: Double = 0.0
    // Foilar moisture content
    var fmc: Double = 0.0
    // Surface fire intensity
    var sfi: Double = 0.0
    // Initial rate of spread
    var rss: Double = 0.0
    // Initial spread index
    var isi: Double = 0.0
    
    var sf: Double = 1.0
    
    // Modified wind aziumth based on slope percentage and slope direction
    // in relation to the wind direction and speed
    var raz: Double = 0.0
    
    // Modified wind speed based on slope
    var wsv: Double = 0.0
    
    // Fine fuel?
    var ff: Double = 0.0
    
    // Julian date value
    var jd: Double = 0.0
    
    // Still don't know what this does for me
    var jd_min: Double  = 0.0
    
    // Specifies the covertype
    var covertype: String = ""
    
    init() {
        
    }
}

public class SecondaryOutput {
    // Length-to-Breadth
    var lb: Double = 0.0
    // Length-to-Breadth over time
    var lbt: Double = 0.0
    // Elliptical Fire Area
    var area: Double = 0.0
    // Elliptical Fire Perimeter
    var perm: Double = 0.0
    // Rate of Perimeter Growth
    var pgr: Double = 0.0
    
    init() {
        
    }
}

public class FireOutput {
    // Rate of spread
    var ros: Double = 0.0 // m/min
    
    // Distance
    var dist: Double = 0.0 // m
    
    // Rate of spread at period end?
    var rost: Double = 0.0
    
    // Rate of spread at start
    var rss: Double = 0.0
    
    // Crown burn fraction
    var cfb: Double = 0.0
    // Fire intensity
    var fi: Double = 0.0
    // Total fuel consumption
    var fc: Double = 0.0
    // Crown fuel consumption
    var cfc: Double = 0.0
    // Amount of time between start and finish
    var time: Double = 0.0
    // Fire descriptor code
    var fd: String = ""
    // Only used by back fire - Initial spread index
    var isi: Double?
    
    init() {
        
    }
}

public class InputSet {
    // Fuel Types
    var fueltype: String = "C1"
    
    // Fine Fuel Moisture Code
    var ffmc: Double = 0.0
    
    // Wind Speed
    var ws: Double = 0.0
    
    // Build up index
    var bui: Double = 0.0
    
    // Latitude
    var lat: Double = 0.0
    
    // Longitude
    var lon: Double = 0.0
    
    // Wind direction
    var wdir: Double = 0.0
    
    // Wind azimuth
    var waz: Double = 0.0
    
    // Percent slope
    var ps: Double = 0.0
    
    // Slope azimuth
    var saz: Double = 0.0
    
    // percentage conifer of mixedwood
    var pc: Double = 0.0
    
    // percentage dead fire in M3 or M4
    var pdf: Double = 0.0
    
    // degree of curing of grass for O1[a|b]
    var cur: Double = 0.0
    
    // grass fuel load for O1[a|b]
    var gfl: Double = 0.0
    
    // Prediction duration in minutes
    var time: Double = 0.0
    
    // Month of prediction start
    var mon: Double = 0.0
    
    // Julian calendar day
    var jd: Double = 0.0
    
    // Elevation of observation (optional)
    var elev: Double?
    
    // Foilar moisture content (optional)
    var fmc: Double?
    
    // No idea what this is or what it's used for at this point
    var jd_min: Double?
    
    init() {
        
    }
}

public class FBPAlgorithm {
    
    public let slopelimit_isi: Double = 0.01
    public let numfuels: Int = 18
    public var fbpc_mult: Double = 1.0
    public let input = InputSet()
    public let mains = MainOutput()
    public let secs = SecondaryOutput()
    public let heads = FireOutput()
    public let flanks = FireOutput()
    public let backs = FireOutput()
    
    // All available fuel coefficients for differing fuel types
    // An array of dictionaries
    public let fuel_coefficients: [[String: Any]] = [["fueltype": "M1", "a": 110.0, "b": 0.0282, "c": 1.5, "q": 0.8, "bui0": 50.0, "cbh": 6.0, "cfl": 0.8], ["fueltype": "M2", "a": 110.0, "b": 0.0282, "c": 1.5, "q": 0.8, "bui0": 50.0, "cbh": 6.0, "cfl": 0.8],["fueltype": "M3", "a": 120.0, "b": 0.0572, "c": 1.4, "q": 0.8, "bui0": 50.0, "cbh": 6.0, "cfl": 0.8],["fueltype": "M4", "a": 100.0, "b": 0.0404, "c": 1.48, "q": 0.8, "bui0": 50.0, "cbh": 6.0, "cfl": 0.8],["fueltype": "C1", "a": 90.0, "b": 0.0649, "c": 4.5, "q": 0.9, "bui0": 72.0, "cbh": 2.0, "cfl": 0.75],["fueltype": "C2", "a": 110.0, "b": 0.0282, "c": 1.5, "q": 0.7, "bui0": 64.0, "cbh": 3.0, "cfl": 0.8],["fueltype": "C3", "a": 110.0, "b": 0.0444, "c": 3.0, "q": 0.75, "bui0": 62.0, "cbh": 8.0, "cfl": 1.15],["fueltype": "C4", "a": 110.0, "b": 0.0293, "c": 1.5, "q": 0.8, "bui0": 66.0, "cbh": 4.0, "cfl": 1.2],["fueltype": "C5", "a": 30.0, "b": 0.0697, "c": 4.0, "q": 0.8, "bui0": 56.0, "cbh": 18.0, "cfl": 1.2],["fueltype": "C6", "a": 30.0, "b": 0.08, "c": 3.0, "q": 0.8, "bui0": 62.0, "cbh": 7.0, "cfl": 1.8],["fueltype": "C7", "a": 45.0, "b": 0.0305, "c": 2.0, "q": 0.85, "bui0": 106.0, "cbh": 10.0, "cfl": 0.5],["fueltype": "D1", "a": 30.0, "b": 0.0232, "c": 1.6, "q": 0.9, "bui0": 32.0, "cbh": 0.0, "cfl": 0.0],["fueltype": "D2", "a": 6.0, "b": 0.0232, "c": 1.6, "q": 0.9, "bui0": 32.0, "cbh": 0.0, "cfl": 0.0],["fueltype": "S1", "a": 75.0, "b": 0.0297, "c": 1.3, "q": 0.75, "bui0": 38.0, "cbh": 0.0, "cfl": 0.0],["fueltype": "S2", "a": 40.0, "b": 0.0438, "c": 1.7, "q": 0.75, "bui0": 63.0, "cbh": 0.0, "cfl": 0.0],["fueltype": "S3", "a": 55.0, "b": 0.0829, "c": 3.2, "q": 0.75, "bui0": 31.0, "cbh": 0.0, "cfl": 0.0],["fueltype": "O1a", "a": 190.0, "b": 0.031, "c": 1.4, "q": 1.0, "bui0": 1.0, "cbh": 0.0, "cfl": 0.0],["fueltype": "O1b", "a": 250.0, "b": 0.035, "c": 1.7, "q": 1.0, "bui0": 1.0, "cbh": 0.0, "cfl": 0.0]]
    
    public init() {
        
        
//        input.fueltype = "C1"
//        input.ffmc = 95.0
//        input.ws = conversions(3.0, "mi2km")
//        input.bui = 120.0
//        input.lat = 35.00313
//        input.lon = 110.00087
//        input.wdir = 0.0
//        input.time = 60.0
//        input.mon = 2.0
//        input.jd = 83.0
//        input.ps = 10.0
//        input.saz = 180.0
//        
//        //sequence_calculate(input, mains, secs, heads, flanks, backs)
    }
    
    public func conversions(_ value: Double, _ conversion: String) -> Double {
        if (conversion == "mi2km") { return value * 1.60934 }
        if (conversion == "km2mi") { return value / 1.60934 }
        if (conversion == "km2ch") { return value * 49.7097 }
        if (conversion == "kgmm2tpa") { return value * 4.460897 }
        if (conversion == "mmin2chph") { return value * 2.98258 }
        if (conversion == "m2ch") { return value * 0.0497097 }
        if (conversion == "kwm2bfs") { return value * 0.28909 }
        if (conversion == "kwm2flft") { return 0.45 * pow(value * 0.28909, 0.46) }
        return value
    }
    
    // DONE
    public func ffmc_effect(_ ffmc: Double) -> Double {
        let mc: Double = 147.2 * (101.0 - ffmc) / (59.5 + ffmc)
        
        return 91.9 * exp(-0.1386 * mc) * (1 + pow(mc, 5.31) / 49300000.0)
    }
    
    public func rate_of_spread(_ inputs: InputSet, _ fuels: Dictionary<String, Any>, _ mains: MainOutput) -> Double {
        var fw: Double
        var rsi: Double
        mains.ff = ffmc_effect(inputs.ffmc)
        mains.raz = inputs.waz
        
        let isz = 0.208*mains.ff
        if (inputs.ps > 0) {
            mains.wsv = slope_effect(inputs, fuels, mains, isz)
        } else {
            mains.wsv = inputs.ws
        }
        if (mains.wsv < 40.0) {
            fw = exp(0.05039*mains.wsv)
        } else {
            fw = 12.0 * (1.0 - exp(-0.0818 * (mains.wsv - 28)))
        }
        mains.isi = isz*fw
        rsi = ros_calc(inputs, fuels, mains.isi)
        mains.rss = rsi*bui_effect(fuels, mains, inputs.bui)
        return mains.rss
    }
    
    // TODO: Removed pointer to mult as it doesn't appear to be needed.
    public func ros_calc(_ inputs: InputSet, _ fuels: Dictionary<String, Any>, _ isi: Double) -> Double {
        let ft = fuels["fueltype"] as! String
        if (ft == "O1a" || ft == "O1b") {
            return grass(fuels, inputs.cur, isi)
        } else if (ft == "M1" || ft == "M2") {
            return mixed_wood(fuels, isi, inputs.pc)
        } else if (ft == "M3" || ft == "M4") {
            return dead_fir(fuels, inputs.pdf, isi)
        } else if (ft == "D2") {
            return D2_ROS(fuels, isi, inputs.bui)
        }
        return conifer(fuels, isi)
    }
    
    public func grass(_ fuels: Dictionary<String, Any>, _ cur: Double, _ isi: Double) -> Double {
        var mu: Double
        if (cur >= 58.8) {
            mu = 0.176 + 0.02 * (cur - 58.8)
        } else {
            mu = 0.005 * (exp(0.061*cur) - 1.0)
        }
        
        fbpc_mult = mu
        let a = fuels["a"] as! Double
        let b = fuels["b"] as! Double
        let c = fuels["c"] as! Double

        return mu * (a * pow((1.0-exp(-1.0 * b * isi)), c))
    }
    
    public func mixed_wood(_ fuels: Dictionary<String, Any>, _ isi: Double, _ pc: Double) -> Double {
        var mult: Double
        
        let mu = pc/100.0
        let ft = fuels["fueltype"] as! String
        let a = fuels["a"] as! Double
        let b = fuels["b"] as! Double
        let c = fuels["c"] as! Double
        
        let ros_c2 = a * pow(1.0-exp(-1.0 * b * isi), c)
        
        if (ft == "M2") {
            mult = 0.2
        } else {
            mult = 1.0
        }
        let fuels_d = fuel_coefficients[get_fueltype_index("D1")]
        
        let da = fuels_d["a"] as! Double
        let db = fuels_d["b"] as! Double
        let dc = fuels_d["c"] as! Double
        let ros_d1 = da * pow((1.0-exp(-1.0 * db * isi)), dc)
        
        fbpc_mult = mu
        
        return mu * ros_c2 + mult * (100.0-pc) / 100.0 * ros_d1
    }
    
    public func dead_fir(_ fuels: Dictionary<String, Any>, _ pdf: Double, _ isi: Double) -> Double {
        var greenness: Double = 1.0
        let ft = fuels["fueltype"] as! String
        let a = fuels["a"] as! Double
        let b = fuels["b"] as! Double
        let c = fuels["c"] as! Double
        
        if (ft == "M4") {
            greenness=0.2
        }
        let rosm3or4_max=a * pow((1.0-exp(-1.0 * b * isi)), c)
        
        let fuels_d = fuel_coefficients[get_fueltype_index("D1")]
        let da = fuels_d["a"] as! Double
        let db = fuels_d["b"] as! Double
        let dc = fuels_d["c"] as! Double
        
        let ros_d1 = da * pow((1.0-exp(-1.0 * db * isi)), dc)
        
        fbpc_mult = pdf/100.0
        
        return fbpc_mult * rosm3or4_max + (100.0 - pdf) / 100.0 * greenness * ros_d1
    }
    
    public func D2_ROS(_ fuels: Dictionary<String, Any>, _ isi: Double, _ bui: Double) -> Double {
        fbpc_mult = 1.0
        
        if (bui >= 80) {
            let a = fuels["a"] as! Double
            let b = fuels["b"] as! Double
            let c = fuels["c"] as! Double
            return a * pow((1.0-exp(-1.0 * b * isi)), c)
        }
        
        return 0.0
    }
    
    public func conifer(_ fuels: Dictionary<String, Any>, _ isi: Double) -> Double {
        fbpc_mult = 1.0
        
        let a = fuels["a"] as! Double
        let b = fuels["b"] as! Double
        let c = fuels["c"] as! Double
        
        return a * pow((1.0-exp(-1.0 * b * isi)), c)
    }
    
    // DONE
    public func bui_effect(_ fuels: Dictionary<String, Any>, _ mains: MainOutput, _ givenbui: Double) -> Double {
        let bui_avg: Double = 50.0
        var bui: Double
        if (givenbui == 0.0) { bui=1.0 } else { bui=givenbui }
  
        let q = fuels["q"] as! Double
        let bui0 = fuels["bui0"] as! Double
        
        let _a: Double = bui_avg * log(q)
        let _b: Double = (1.0/bui) - (1.0/bui0)
    
        return exp(_a * _b)
    }
    
    public func ISF_mixedwood(_ fuels: Dictionary<String, Any>, _ isz: Double, _ pc: Double, _ sf: Double) -> Double {
        var check: Double
        
        let ft = fuels["fueltype"] as! String
        let a = fuels["a"] as! Double
        let b = fuels["b"] as! Double
        let c = fuels["c"] as! Double
        
        let rsf_c2 = sf * a * pow((1.0 - exp(-1.0 * b * isz)), c)
        
        if (rsf_c2 > 0.0) {
            check = 1.0 - pow(rsf_c2 / a, 1.0 / c)
        } else {
            check = 1.0
        }
        
        if (check < slopelimit_isi) {
            check = slopelimit_isi
        }
        
        let isf_c2 = (1.0 / (-1.0 * (fuels["b"] as! Double))) * log(check)
        
        var mult: Double
        
        if (ft == "M2") {
            mult = 0.2
        } else {
            mult = 1.0
        }
        
        let fuels_d = fuel_coefficients[get_fueltype_index("D1")]
        let da = fuels_d["a"] as! Double
        let db = fuels_d["b"] as! Double
        let dc = fuels_d["c"] as! Double
        
        let rsf_d1 = sf * (mult * da) * pow((1.0 - exp(-1.0 * db * isz)), dc)
        
        if (rsf_d1 > 0.0) {
            check = 1.0 - pow(rsf_d1 / (mult * da), 1.0 / dc)
        } else {
            check = 1.0
        }
        
        if (check < slopelimit_isi) {
            check = slopelimit_isi
        }
        
        let isf_d1 = (1.0 / (-1.0 * db)) * log(check)
        
        return (pc / 100.0) * isf_c2 + (100 - pc) / 1000.0 * isf_d1
    }
    
    public func ISF_deadfir(_ fuels: Dictionary<String, Any>, _ isz: Double, _ pdf: Double, _ sf: Double) -> Double {
        var check: Double
        var mult: Double
        let ft = fuels["fueltype"] as! String
        let a = fuels["a"] as! Double
        let b = fuels["b"] as! Double
        let c = fuels["c"] as! Double
        
        let rsf_max = sf * a * pow((1.0 - exp(-1.0 * b * isz)), c)
        
        if (rsf_max > 0.0) {
            check = 1.0 - pow(rsf_max / a, 1.0 / c)
        } else {
            check = 1.0
        }
        
        if (check < slopelimit_isi) {
            check = slopelimit_isi
        }
        
        let isf_max = (1.0/(-1.0 * b)) * log(check)
        
        if (ft == "M4") {
            mult = 0.2
        } else {
            mult = 1.0
        }
        
        let fuels_d = fuel_coefficients[get_fueltype_index("D1")]
        let da = fuels_d["a"] as! Double
        let db = fuels_d["b"] as! Double
        let dc = fuels_d["c"] as! Double
        
        let rsf_d1 = sf * (mult * da) * pow((1.0 - exp(-1.0 * db * isz)), dc)
        
        if (rsf_d1 > 0.0) {
            check = 1.0 - pow((rsf_d1 / da), (1.0 / dc))
        } else {
            check = 1.0
        }
        
        if (check < slopelimit_isi) {
            check = slopelimit_isi
        }
        
        let isf_d1 = (1.0 / (-1.0 * db)) * log(check)
        
        return (pdf / 100.0) * isf_max + (100.0 - pdf) / 100.0 * isf_d1
    }
    
    public func slope_effect(_ inputs: InputSet, _ fuels: Dictionary<String, Any>, _ mains: MainOutput, _ isi: Double) -> Double {
        var ps = inputs.ps
        var isf: Double
        var rsz: Double
        var rsf: Double
        var check: Double
        
        let ft = fuels["fueltype"] as! String
        let a = fuels["a"] as! Double
        let b = fuels["b"] as! Double
        let c = fuels["c"] as! Double
        
        if (ps > 70.0) {
            ps = 70.0
        }
        mains.sf = exp(3.533*pow(ps/100.0, 1.2))
        if (mains.sf > 10.0) {
            mains.sf = 10.0
        }
        
        if ((ft == "M1") || (ft == "M2")) {
            isf = ISF_mixedwood(fuels, isi, inputs.pc, mains.sf)
        } else if ((ft == "M3") || (ft == "M4")) {
            isf = ISF_deadfir(fuels, isi, inputs.pdf, mains.sf)
        } else {
            rsz = ros_calc(inputs, fuels, isi)
            rsf = rsz * mains.sf
            
            if (rsf > 0.0) {
                check = 1.0 - pow((rsf/(fbpc_mult * a)), (1.0 / c))
            } else {
                check = 1.0
            }
            
            if (check < slopelimit_isi) {
                check = slopelimit_isi
            }
            isf = (1.0/(-1.0 * b)) * log(check)
        }
        if (isf == 0.0) {
            isf = isi
        }
        
        var wse: Double
        let wse1 = log(isf / (0.208 * mains.ff)) / 0.05039
        
        if (wse1 <= 40.0) {
            wse = wse1
        } else {
            if (isf > (0.999 * 2.496 * mains.ff)) {
                isf = 0.999 * 2.496 * mains.ff
            }
            wse = 28.0 - log(1.0 - isf/(2.496 * mains.ff)) / 0.0818
        }
        
        let wrad = inputs.waz / 180.0 * Double.pi
        let wsx = inputs.ws * sin(wrad)
        let wsy = inputs.ws * cos(wrad)
        let srad = inputs.saz / 180.0 * Double.pi
        let wsex = wse * sin(srad)
        let wsey = wse * cos(srad)
        let wsvx = wsx + wsex
        let wsvy = wsy + wsey
        let wsv = sqrt(wsvx * wsvx + wsvy * wsvy)
        var raz = acos(wsvy/wsv)
        raz = (raz/Double.pi) * 180.0
        if (wsvx < 0) {
            raz = 360 - raz
        }
        mains.raz = raz
        return wsv
    }
    
    // DONE
    public func fire_intensity(_ fc: Double, _ ros: Double) -> Double {
        return 300.0 * fc * ros
    }
    
    public func foilar_moisture(_ inputs: InputSet, _ mains: MainOutput) -> Double {
        mains.jd = inputs.jd
        
        if (inputs.fmc != nil) {
            return inputs.fmc!
        }

        if (inputs.jd_min == nil || inputs.jd_min! <= 0.0) {
            if (inputs.elev == nil || inputs.elev! < 0.0) {
                let latn = 23.4 * exp(-0.0360 * (150 - inputs.lon)) + 46.0
                mains.jd_min = floor(0.5 + 151.0 * inputs.lat / latn)
            } else {
                let latn = 33.7 * exp(-0.0351 * (150 - inputs.lon)) + 43.0
                mains.jd_min = floor(0.5 + 142.1 * inputs.lat / latn + (0.0172 * inputs.elev!))
            }
        } else {
            mains.jd_min = inputs.jd_min!
        }
        let nd = abs(inputs.jd - mains.jd_min)
        
        if (nd >= 50) {
            return 120.0
        } else if (nd >= 30 && nd < 50) {
            return 32.9 + 3.17 * nd - 0.0288 * nd * nd
        } else {
            return 85.0 + 0.0189 * nd * nd
        }
    }
    
    public func surf_fuel_consump(_ inputs: InputSet) -> Double {
        if (inputs.fueltype == "C1") {
            var sfc: Double
            if (inputs.ffmc > 84) {
                sfc = 0.75 + 0.75 * sqrt(1 - exp(-0.23 * (inputs.ffmc - 84)))
            } else {
                sfc = 0.75 - 0.75 * sqrt(1 - exp(0.23 * (inputs.ffmc - 84)))
            }
            return sfc > 0 ? sfc : 0.0
        } else if (inputs.fueltype == "C2" || inputs.fueltype == "M3" || inputs.fueltype == "M4") {
            return 5.0 * (1.0 - exp(-0.0115 * inputs.bui))
        } else if (inputs.fueltype == "C3" || inputs.fueltype == "C4") {
            return 5.0 * pow((1.0 - exp(-0.0164 * inputs.bui)), 2.24)
        } else if (inputs.fueltype == "C5" || inputs.fueltype == "C6") {
            return 5.0 * pow((1.0 - exp(-0.0149 * inputs.bui)), 2.48)
        } else if (inputs.fueltype == "C7") {
            var ffc = 2.0 * (1.0 - exp(-0.104 * (inputs.ffmc - 70.0)))
            if (ffc < 0) {
                ffc = 0.0
            }
            let wfc = 1.5 * (1.0 - exp(-0.0201 * inputs.bui))
            return ffc + wfc
        } else if (inputs.fueltype == "O1a" || inputs.fueltype == "O1b") {
            return inputs.gfl
        } else if (inputs.fueltype == "M1" || inputs.fueltype == "M2") {
            let sfc_c2 = 5.0 * (1.0 - exp(-0.0115 * inputs.bui))
            let sfc_d1 = 1.5 * (1.0 - exp(-0.0183 * inputs.bui))
            return inputs.pc / 100.0 * sfc_c2 + (100.0 - inputs.pc) / 100.0 * sfc_d1
        } else if (inputs.fueltype == "S1") {
            let ffc = 4.0 * (1.0 - exp(-0.025 * inputs.bui))
            let wfc = 4.0 * (1.0 - exp(-0.034 * inputs.bui))
            return ffc + wfc
        } else if (inputs.fueltype == "S2") {
            let ffc = 10.0 * (1.0 - exp(-0.013 * inputs.bui))
            let wfc = 6.0 * (1.0 - exp(-0.06 * inputs.bui))
            return ffc + wfc
        } else if (inputs.fueltype == "S3") {
            let ffc = 12.0 * (1.0 - exp(-0.0166 * inputs.bui))
            let wfc = 20.0 * (1.0 - exp(-0.0210 * inputs.bui))
            return ffc + wfc
        } else if (inputs.fueltype == "D1") {
            return 1.5 * (1.0 - exp(-0.0183 * inputs.bui))
        } else if (inputs.fueltype == "D2") {
            return inputs.bui >= 80 ? 1.5 * (1.0 - exp(-0.0183 * inputs.bui)) : 0.0
        } else {
            return(-99.0)
        }
    }
    
    // DONE
    public func crit_surf_intensity(_ fuels: Dictionary<String, Any>, _ fmc: Double) -> Double {
        let cbh = fuels["cbh"] as! Double
        return 0.001 * pow(cbh * (460.0+25.9 * fmc), 1.5)
    }
    
    // DONE
    public func critical_ros(_ sfc: Double, _ csi: Double) -> Double {
        if (sfc > 0) {
            return csi / (300.0*sfc)
        } else {
            return 0.0
        }
    }
    
    // DONE
    public func crown_frac_burn(_ rss: Double, _ rso: Double) -> Double {
        let cfb = 1.0-exp(-0.230*(rss-rso))
        if (cfb > 0) {
            return cfb
        } else {
            return 0.0
        }
    }
    
    // DONE
    public func fire_type(_ csi: Double, _ sfi: Double) -> String {
        return sfi > csi ? "c" : "s"
    }
    
    // DONE
    public func fire_description(_ cfb: Double) -> String {
        if (cfb < 0.1) { return "S" }
        if (cfb < 0.9) { return "I" }
        if (cfb >= 0.9) { return "C" }
        return "*"
    }
    
    // DONE
    public func final_ros(_ inputs: InputSet, _ fmc: Double, _ isi: Double, _ cfb: Double, _ rss: Double) -> Double {
        if (inputs.fueltype == "C6") {
            let rsc: Double = foilar_mois_effect(isi, fmc)
            return rss+cfb*(rsc-rss)
        } else {
            return rss
        }
    }
    
    // DONE
    public func foilar_mois_effect(_ isi: Double, _ fmc: Double) -> Double {
        let fme_avg: Double = 0.778
        let fme: Double = 1000.0*pow(1.5-0.00275*fmc, 4.0)/(460.0 + 25.9*fmc)
        return 60.0*(1.0-exp(-0.0497*isi))*fme/fme_avg
    }
    
    // DONE
    public func crown_consump(_ inputs: InputSet, _ fuels: Dictionary<String, Any>, _ cfb: Double) -> Double {
        let ft = fuels["fueltype"] as! String
        let cfl = fuels["cfl"] as! Double
        let cfc = cfl * cfb
        if (ft == "M1" || ft == "M2") {
            return inputs.pc / 100.0 * cfc
        }
        if (ft == "M3" || ft == "M4") {
            return inputs.pdf / 100.0 * cfc
        }
        return cfc
    }
    
    // DONE
    public func l_to_b(_ fueltype: String, _ ws: Double) -> Double {
        if (fueltype == "O1a" || fueltype == "O1b") {
            return ws < 1.0 ? 1.0 : (1.1 * pow(ws, 0.464))
        }
        return 1.0 + 8.729 * pow(1.0 - exp(-0.030 * ws), 2.155)
    }
    
    public func set_all(_ fire: FireOutput, _ time: Double) {
        fire.time = 0
        fire.rost = fire.ros
        fire.dist = time * fire.ros
    }
    
    // DONE
    public func backfire_isi(_ mains: MainOutput) -> Double {
        let bfw = exp(-0.05039 * mains.wsv)
        return 0.208 * mains.ff * bfw
    }
    
    // DONE
    public func backfire_ros(_ inputs: InputSet, _ fuels: Dictionary<String, Any>, _ mains: MainOutput, _ bisi: Double) -> Double {
        let bros: Double = ros_calc(inputs,fuels,bisi)
        return bros*bui_effect(fuels, mains, inputs.bui)
    }
    
    // DONE
    public func area(_ dt: Double, _ df: Double) -> Double {
        let a = dt/2.0
        return a*df*Double.pi/10000.0
    }
    
    public func perimeter(_ h: FireOutput, _ b: FireOutput, _ sec: SecondaryOutput, _ lb: Double) -> Double {
        let mult: Double = Double.pi*(1.0+1.0/lb)*(1.0+pow(((lb-1.0)/(2.0*(lb+1.0))),2.0))

        sec.pgr = (h.rost + b.rost)/2.0*mult
        
        return (h.dist + b.dist)/2.0*mult
    }
    
    // DONE
    public func acceleration(_ inputs: InputSet, _ cfb: Double) -> Double {
        let open_list = ["O1a","O1b","C1","S1","S2","S3"]
        if (open_list.firstIndex(of: inputs.fueltype) != nil) {
            return 0.115
        }
        
        return 0.115 - 18.8 * pow(cfb, 2.5) * exp(-8.0 * cfb)
    }
    
    // DONE
    public func flankfire_ros(_ ros: Double, _ bros: Double, _ lb: Double) -> Double {
        return (ros+bros)/(lb*2.0)
    }
    
    // Make sure I don't need sec.lbt or fuels.rost set in future functions
    // TODO: Rost isn't used here, is it important anywhere?
    public func flank_spread_distance(_ inputs: InputSet, _ fire: FireOutput, _ sec: SecondaryOutput, _ hrost: Double, _ brost: Double, _ hd: Double, _ bd: Double, _ a: Double) -> Double {
        sec.lbt = (sec.lb - 1.0) * (1.0 - exp(-a * inputs.time)) + 1.0
        fire.rost = (hrost + brost)/(sec.lbt * 2.0)
        return (hd + bd)/(2.0 * sec.lbt)
    }
    
    // TODO Determine if fuels.rost is important for any future output
    public func spread_distance(_ inputs: InputSet, _ fire: FireOutput, _ a: Double) -> Double {
        fire.rost = fire.ros * (1.0 - exp(-a * inputs.time))
        return fire.ros * (inputs.time + (exp(-a * inputs.time) / a) - 1.0 / a)
    }
    
    // DONE
    public func time_to_crown(_ ros: Double, _ rso: Double, _ a: Double) -> Double {
        var ratio: Double
        if (ros > 0) { ratio = rso / ros }
        else { ratio = 1.1 }
        
        if (ratio > 0.9 && ratio <= 1.0) { ratio = 0.9 }
        if (ratio < 1.0) { return floor(log(1.0-ratio) / -1*a) }
        else { return (99.0) }
    }
    
    // How british a function name :)
    public func fire_behaviour(_ inputs: InputSet, _ fuels: Dictionary<String, Any>, _ mains: MainOutput, _ fire: FireOutput) -> Double {
        let sfi = fire_intensity(mains.sfc, fire.rss)
        let firetype = fire_type(mains.csi, sfi)
        if (firetype == "c") {
            fire.cfb = crown_frac_burn(fire.rss, mains.rso)
            fire.fd = fire_description(fire.cfb)
            fire.ros = final_ros(inputs, mains.fmc, fire.isi!, fire.cfb, fire.rss)
            fire.cfc = crown_consump(inputs, fuels, fire.cfb)
            fire.fc = fire.cfc + mains.sfc
            fire.fi = fire_intensity(fire.fc, fire.ros)
        }
        if (firetype != "c" || mains.covertype == "n") {
            fire.fc = mains.sfc
            fire.cfb = 0.0
            fire.fd = "S"
            fire.ros = fire.rss
            fire.fi = sfi
        }
        return fire.fi
    }
    
    public func flank_fire_behaviour(_ inputs: InputSet, _ fuels: Dictionary<String, Any>, _ mains: MainOutput, _ flanks: FireOutput) -> Double {
        let sfi = fire_intensity(mains.sfc, flanks.rss)
        let firetype = fire_type(mains.csi, sfi)

        if (firetype == "c") {
            flanks.cfb = crown_frac_burn(flanks.rss, mains.rso)
            flanks.fd = fire_description(flanks.cfb)
            flanks.cfc = crown_consump(inputs, fuels, flanks.cfb)
            flanks.fc = flanks.cfc + mains.sfc
            flanks.fi = fire_intensity(flanks.fc, flanks.ros)
        }

        if (firetype != "c" || mains.covertype == "n") {
            flanks.fc = mains.sfc
            flanks.cfb = 0.0
            flanks.fd = "S"
            flanks.fi = sfi
        }
        return flanks.fi
    }
    
    public func get_fueltype_index(_ fueltype: String) -> Int {
        var count: Int = 0
        
        for fuel in fuel_coefficients {
            if ((fuel["fueltype"] as! String).trimmingCharacters(in: .newlines) == fueltype.trimmingCharacters(in: .newlines)) {
                return count
            }
            count += 1
        }
        return 0
    }
    
    public func get_fueltype_number(_ fueltype: String) -> String {
        let ftp = String(fueltype.prefix(1))
        if (ftp == "C" || ftp == "M") {
            return "c"
        } else {
            return "n"
        }
    }
    
    public func sequence_calculate(_ inputs: InputSet, _ mains: MainOutput, _ secs: SecondaryOutput, _ heads: FireOutput, _ flanks: FireOutput, _ backs: FireOutput) {
        
        inputs.waz = inputs.wdir + 180
        if (inputs.waz >= 360) {
            inputs.waz -= 360
        }
        
        let fuel_type_pointer = fuel_coefficients[get_fueltype_index(inputs.fueltype)]
        
        fbpc_mult = 1.0

        mains.covertype = get_fueltype_number(inputs.fueltype)

        mains.ff = ffmc_effect(inputs.ffmc)
        mains.rss = rate_of_spread(inputs, fuel_type_pointer, mains)
        heads.rss = mains.rss
        mains.sfc = surf_fuel_consump(inputs)
        mains.sfi = fire_intensity(mains.sfc, mains.rss)

        if (mains.covertype == "c") {
            mains.fmc = foilar_moisture(inputs, mains)
            mains.csi = crit_surf_intensity(fuel_type_pointer, mains.fmc)
            mains.rso = critical_ros(mains.sfc, mains.csi)
            let firetype = fire_type(mains.csi, mains.sfi)

            if (firetype == "c") {
                heads.cfb = crown_frac_burn(mains.rss, mains.rso)
                heads.fd = fire_description(heads.cfb)
                heads.ros = final_ros(inputs, mains.fmc, mains.isi, heads.cfb, mains.rss)
                heads.cfc = crown_consump(inputs, fuel_type_pointer, heads.cfb)
                heads.fc = heads.cfc + mains.sfc
                heads.fi = fire_intensity(heads.fc, heads.ros)
            } else if (firetype == "s") {
                heads.fd = "S"
                heads.ros = mains.rss
                heads.fc = mains.sfc
                heads.fi = mains.sfi
                heads.cfb = 0.0
            }
        } else if (mains.covertype == "n") {
            heads.fd = "S"
            heads.ros = mains.rss
            heads.fc = mains.sfc
            heads.fi = mains.sfi
            heads.cfb = 0.0
        }

        secs.lb = l_to_b(inputs.fueltype, mains.wsv)
        backs.isi = backfire_isi(mains)
        backs.rss = backfire_ros(inputs, fuel_type_pointer, mains, backs.isi!)
        flanks.rss = flankfire_ros(heads.rss, backs.rss, secs.lb)
        backs.fi = fire_behaviour(inputs, fuel_type_pointer, mains, backs)
        flanks.ros = flankfire_ros(heads.ros, backs.ros, secs.lb)
        flanks.fi = flank_fire_behaviour(inputs, fuel_type_pointer, mains, flanks)

        if (inputs.time > 0.0) {
            let accn = acceleration(inputs, heads.cfb)
            heads.dist = spread_distance(inputs, heads, accn)
            backs.dist = spread_distance(inputs, backs, accn)
            flanks.dist = flank_spread_distance(inputs, flanks, secs, heads.rost, backs.rost, heads.dist, backs.dist, accn)
            heads.time = time_to_crown(heads.ros, mains.rso, accn)
            flanks.time = time_to_crown(flanks.ros, mains.rso, accn)
            backs.time = time_to_crown(backs.ros, mains.rso, accn)
        } else {
            set_all(heads, inputs.time)
            set_all(flanks, inputs.time)
            set_all(backs, inputs.time)
        }

        secs.area = area((heads.dist + backs.dist), flanks.dist)

        if (inputs.time > 0.0) {
            secs.perm = perimeter(heads, backs, secs, secs.lbt)
        } else {
            secs.perm = perimeter(heads, backs, secs, secs.lb)
        }

        let accn = acceleration(inputs, heads.cfb)
        secs.lbt = (secs.lb - 1.0) * (1.0 - exp(-accn * inputs.time)) + 1.0
    }
}
