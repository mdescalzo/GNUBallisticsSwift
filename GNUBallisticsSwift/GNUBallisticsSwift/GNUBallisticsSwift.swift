//
// GNU Ballistics Library
// Originally created by Derek Yates
// Swift port by Mark Descalzo
//
// Available under the GNU GPL 2.0
//

import Foundation

struct Solution {
    let range: Double // range in yard
    let path: Double // path in inches
    let correction: Double  // in MOA
    let time: Double // time in seconds
    let windage: Double // windage in inches
    let velocity: Double // combined velocity
    let velocityX: Double // velocity on X-axis
    let velocityY: Double // velocity on Y-axis
}

open class GNUBallisticsSwift {
    
    let kMaxRange: Double = 50001
    let kGravity: Double = -32.194
    
    var solutions: [Solution]? = nil
    var solved: Bool {
        get {
            return solutions != nil
        }
    }
    
    /**
     Integer representation of the drag function.  G3 and G4 are undefined placeholders.
     */
    public enum DragFunction: Int {
        case G1=1,
        G2,
        G3, // Undefined
        G4, // Undefined
        G5,
        G6,
        G7,
        G8
    }
    
    /**
     Calculates ballistic retardation values based on standard drag functions.
     
     - Parameters:
        - dragFunction: G1, G2, G3, G4, G5, G6, G7, or G8. Enumerated in DragFunction
        - dragCoefficient:  The coefficient of drag for the projectile for the given drag function.
        - velocity: The Velocity of the projectile.
     - Returns:
     The projectile drag retardation velocity, in ft/s per second.
     */
    open func retard(dragFunction: DragFunction, dragCoefficient: Double, velocity: Double) -> Double {
        
        let vp: Double = velocity
        var val: Double = -1
        var A: Double = -1
        var M: Double = -1
        
        switch dragFunction {
        case .G1:
            if (vp > 4230) {
                A = 1.477404177730177e-04
                M = 1.9565
            } else if (vp > 3680) {
                A = 1.920339268755614e-04
                M = 1.925
            } else if (vp > 3450) {
                A = 2.894751026819746e-04
                M = 1.875
            } else if (vp > 3295) {
                A = 4.349905111115636e-04
                M = 1.825
            } else if (vp > 3130) {
                A = 6.520421871892662e-04
                M = 1.775
            } else if (vp > 2960) {
                A = 9.748073694078696e-04
                M = 1.725
            } else if (vp > 2830) {
                A = 1.453721560187286e-03
                M = 1.675
            } else if (vp > 2680) {
                A = 2.162887202930376e-03
                M = 1.625
            } else if (vp > 2460) {
                A = 3.209559783129881e-03
                M = 1.575
            } else if (vp > 2225) {
                A = 3.904368218691249e-03
                M = 1.55
            } else if (vp > 2015) {
                A = 3.222942271262336e-03
                M = 1.575
            } else if (vp > 1890) {
                A = 2.203329542297809e-03
                M = 1.625
            } else if (vp > 1810) {
                A = 1.511001028891904e-03
                M = 1.675
            } else if (vp > 1730) {
                A = 8.609957592468259e-04
                M = 1.75
            } else if (vp > 1595) {
                A = 4.086146797305117e-04
                M = 1.85
            } else if (vp > 1520) {
                A = 1.954473210037398e-04
                M = 1.95
            } else if (vp > 1420) {
                A = 5.431896266462351e-05
                M = 2.125
            } else if (vp > 1360) {
                A = 8.847742581674416e-06
                M = 2.375
            } else if (vp > 1315) {
                A = 1.456922328720298e-06
                M = 2.625
            } else if (vp > 1280) {
                A = 2.419485191895565e-07
                M = 2.875
            } else if (vp > 1220) {
                A = 1.657956321067612e-08
                M = 3.25
            } else if (vp > 1185) {
                A = 4.745469537157371e-10
                M = 3.75
            } else if (vp > 1150) {
                A = 1.379746590025088e-11
                M = 4.25
            } else if (vp > 1100) {
                A = 4.070157961147882e-13
                M = 4.75
            } else if (vp > 1060) {
                A = 2.938236954847331e-14
                M = 5.125
            } else if (vp > 1025) {
                A = 1.228597370774746e-14
                M = 5.25
            } else if (vp >  980) {
                A = 2.916938264100495e-14
                M = 5.125
            } else if (vp >  945) {
                A = 3.855099424807451e-13
                M = 4.75
            } else if (vp >  905) {
                A = 1.185097045689854e-11
                M = 4.25
            } else if (vp >  860) {
                A = 3.566129470974951e-10
                M = 3.75
            } else if (vp >  810) {
                A = 1.045513263966272e-08
                M = 3.25
            } else if (vp >  780) {
                A = 1.291159200846216e-07
                M = 2.875
            } else if (vp >  750) {
                A = 6.824429329105383e-07
                M = 2.625
            } else if (vp >  700) {
                A = 3.569169672385163e-06
                M = 2.375
            } else if (vp >  640) {
                A = 1.839015095899579e-05
                M = 2.125
            } else if (vp >  600) {
                A = 5.71117468873424e-05
                M = 1.950
            } else if (vp >  550) {
                A = 9.226557091973427e-05
                M = 1.875
            } else if (vp >  250) {
                A = 9.337991957131389e-05
                M = 1.875
            } else if (vp >  100) {
                A = 7.225247327590413e-05
                M = 1.925
            } else if (vp >   65) {
                A = 5.792684957074546e-05
                M = 1.975
            } else if (vp >    0) {
                A = 5.206214107320588e-05
                M = 2.000
            }
        case .G2:
            if (vp > 1674 ) {
                A = 0.0079470052136733
                M = 1.36999902851493
            } else if (vp > 1172 ) {
                A = 1.00419763721974e-03
                M = 1.65392237010294
            } else if (vp > 1060 ) {
                A = 7.15571228255369e-23
                M = 7.91913562392361
            } else if (vp >  949 ) {
                A = 1.39589807205091e-10
                M = 3.81439537623717
            } else if (vp >  670 ) {
                A = 2.34364342818625e-04
                M = 1.71869536324748
            } else if (vp >  335 ) {
                A = 1.77962438921838e-04
                M = 1.76877550388679
            } else if (vp >    0 ) {
                A = 5.18033561289704e-05
                M = 1.98160270524632
            }
        case .G5:
            if (vp > 1730 ) {
                A = 7.24854775171929e-03
                M = 1.41538574492812
            } else if (vp > 1228 ) {
                A = 3.50563361516117e-05
                M = 2.13077307854948
            } else if (vp > 1116 ) {
                A = 1.84029481181151e-13
                M = 4.81927320350395
            } else if (vp > 1004 ) {
                A = 1.34713064017409e-22
                M = 7.8100555281422
            } else if (vp >  837 ) {
                A = 1.03965974081168e-07
                M = 2.84204791809926
            } else if (vp >  335 ) {
                A = 1.09301593869823e-04
                M = 1.81096361579504
            } else if (vp >    0 ) {
                A = 3.51963178524273e-05
                M = 2.00477856801111
            }
        case .G6:
            if (vp > 3236 ) {
                A = 0.0455384883480781
                M = 1.15997674041274
            } else if (vp > 2065 ) {
                A = 7.167261849653769e-02
                M = 1.10704436538885
            } else if (vp > 1311 ) {
                A = 1.66676386084348e-03
                M = 1.60085100195952
            } else if (vp > 1144 ) {
                A = 1.01482730119215e-07
                M = 2.9569674731838
            } else if (vp > 1004 ) {
                A = 4.31542773103552e-18
                M = 6.34106317069757
            } else if (vp >  670 ) {
                A = 2.04835650496866e-05
                M = 2.11688446325998
            } else if (vp >    0 ) {
                A = 7.50912466084823e-05
                M = 1.92031057847052
            }
        case .G7:
            if (vp > 4200 ) {
                A = 1.29081656775919e-09
                M = 3.24121295355962
            } else if (vp > 3000 ) {
                A = 0.0171422231434847
                M = 1.27907168025204
            } else if (vp > 1470 ) {
                A = 2.33355948302505e-03
                M = 1.52693913274526
            } else if (vp > 1260 ) {
                A = 7.97592111627665e-04
                M = 1.67688974440324
            } else if (vp > 1110 ) {
                A = 5.71086414289273e-12
                M = 4.3212826264889
            } else if (vp >  960 ) {
                A = 3.02865108244904e-17
                M = 5.99074203776707
            } else if (vp >  670 ) {
                A = 7.52285155782535e-06
                M = 2.1738019851075
            } else if (vp >  540 ) {
                A = 1.31766281225189e-05
                M = 2.08774690257991
            } else if (vp >    0 ) {
                A = 1.34504843776525e-05
                M = 2.08702306738884
            }
        case .G8:
            if (vp > 3571 ) {
                A = 0.0112263766252305
                M = 1.33207346655961
            } else if (vp > 1841 ) {
                A = 0.0167252613732636
                M = 1.28662041261785
            } else if (vp > 1120 ) {
                A = 2.20172456619625e-03
                M = 1.55636358091189
            } else if (vp > 1088 ) {
                A = 2.0538037167098e-16
                M = 5.80410776994789
            } else if (vp >  976 ) {
                A = 5.92182174254121e-12
                M = 4.29275576134191
            } else if (vp >    0 ) {
                A = 4.3917343795117e-05
                M = 1.99978116283334
            }
        case .G3,.G4:
            print("Undefined drag function: \(dragFunction)")
        @unknown default:
            print("Undefined drag function: \(dragFunction)")
        }
        
        if (A != -1 && M != -1 && vp > 0 && vp < 10000){
            val = A*pow(vp,M)/dragCoefficient
            return val
        } else {
            return -1
        }
        
    }
    
    /**
     Corrects a "standard" Drag Coefficient for differing atmospheric conditions.
     
     - Parameters:
        - dragCoefficient: The coefficient of drag for a given projectile.
        - altitude: The altitude above sea level (feet).  Standard altitude is 0 feet above sea level.
        - barometer: The barometric pressure in inches of mercury (in Hg).  This is not "absolute" pressure, it is the "standardized" pressure reported in the papers and news. Standard pressure is 29.53 in Hg.
        - temperature:  The temperature (Fahrenheit).  Standard temperature is 59 degrees.
        - humidity:  The relative humidity fraction.  Ranges from 0.00 to 1.00, with 0.50 being 50% relative humidity. Standard humidity is 78%
     - Returns:
     Ballistic coefficient corrected for the supplied atmospheric conditions.
     */
    open func atmosphericCorrection(dragCoefficient: Double, altitude: Double, barometer: Double, temperature: Double, humidity: Double) -> Double {
        
        let FA: Double = calcFA(altitude: altitude)
        let FT: Double = calcFT(temperature: temperature, altitude: altitude)
        let FR: Double = calcFR(temperature: temperature, pressure: barometer, humidity: humidity)
        let FP: Double = calcFP(pressure: barometer)
        
        // Calculate the atmospheric correction factor
        let CD: Double = (FA*(1+FT-FP)*FR)
        return dragCoefficient * CD
    }
    
    private func calcFR(temperature: Double, pressure: Double, humidity: Double) -> Double {
        let VPw: Double = 4e-6*pow(temperature,3) - 0.0004*pow(temperature,2)+0.0234*temperature-0.2517
        let FRH: Double = 0.995*(pressure/(pressure-(0.3783)*(humidity)*VPw))
        return FRH
    }
    
    private func calcFP(pressure: Double) -> Double {
        let Pstd: Double = 29.53 // in-hg
        let FP: Double =  (pressure - Pstd)/(Pstd)
        return FP
    }
    
    private func calcFT(temperature: Double, altitude: Double) -> Double {
        let Tstd: Double = -0.0036 * altitude + 59
        let FT: Double = (temperature - Tstd) / (459.6 + Tstd)
        return FT
    }
    
    private func calcFA(altitude: Double) -> Double {
        let FA: Double = -4e-15 * pow(altitude,3) + 4e-10 * pow(altitude,2) - 3e-5 * altitude + 1
        return (1/FA)
    }
    
    /**
     Computes the windage deflection for a given crosswind speed.
     
     - Parameters:
        - windSpeed: The wind velocity (miles per hour).
        - Vi: The initial velocity of the projectile (feet per second).
        - range: The range at which you wish to determine windage (feet).
        - time: The time it has taken the projectile to traverse the range x (seconds).
     - Returns:
     The windage correction required to achieve zero on a target at the given range (inches).
     */
    open func windage(windSpeed: Double, Vi: Double, range: Double, time: Double) -> Double {
        let Vw: Double = windSpeed * 17.60 // Convert to inches per second.
        return (Vw * (time - range / Vi))
    }
    
    /**
     Calculates the headwind component of a wind speed and angle combination.
     
     - Parameters:
        - windSpeed: wind velocity (miles per hour).
        - windAngle: The angle from which the wind is coming (degrees). 0 degrees is from straight ahead. 90 degrees is from right to left. 180 degrees is from directly behind. 270 or -90 degrees is from left to right.
     - Returns:
     Headwind component in miles per hour.
     */
    open func headWind(windSpeed: Double, windAngle: Double) -> Double {
        let Wangle: Double = radians(degrees: windAngle)
        return (cos(Wangle) * windSpeed)
    }
    
    /**
     Calculates the crosswind component of a wind speed and angle combination.
     
     - Parameters:
        - windSpeed: wind velocity (miles per hour).
        - windAngle: The angle from which the wind is coming (degrees). 0 degrees is from straight ahead. 90 degrees is from right to left. 180 degrees is from directly behind. 270 or -90 degrees is from left to right.
     - Returns:
     Crosswind component in miles per hour.
     */
    open func crossWind(windSpeed: Double, windAngle: Double) -> Double {
        let Wangle: Double = radians(degrees: windAngle)
        return (sin(Wangle) * windSpeed)
        
    }
    
    /**
     Determines the bore angle needed to achieve a target zero at range. (at standard conditions and on level ground)
     
     - Parameters:
        - dragFunction: The drag function to use (G1, G2, G3, G5, G6, G7, G8)
        - dragCoefficient: The coefficient of drag for the projectile, for the supplied drag function.
        - Vi: The initial velocity of the projectile.  (feet per second)
        - sightHeight: The height of the sighting system above the bore centerline. (inches)
                       Most scopes fall in the 1.6 to 2.0 inch range.
        - zeroRange: The range  at which you wish the projectile to intersect yIntercept. (yards)
        - yIntercept: The height you wish for the projectile to be when it crosses ZeroRange. (inches)
                     This is usually 0 for a target zero, but could be any number.  For example if you wish
                     to sight your rifle in 1.5" high at 100 yds, then you would set yIntercept to 1.5, and ZeroRange to 100
     - Returns:
         Angle of the bore relative to the sighting system. (degrees)
     */
    open func zeroAngle(dragFunction: DragFunction, dragCoefficient: Double, Vi: Double,
                   sightHeight: Double, zeroRange: Double, yIntercept: Double) -> Double {
        // Numerical Integration variables
        var t: Double = 0
        var dt: Double = 1 / Vi // The solution accuracy generally doesn't suffer if its within a foot for each second of time.
        var y: Double = -sightHeight / 12
        var x: Double = 0
        var da: Double // The change in the bore angle used to iterate in on the correct zero angle.
        
        // State variables for each integration loop.
        var v: Double = 0
        var vx: Double = 0
        var vy: Double = 0 // velocity
        var vx1: Double = 0
        var vy1: Double = 0 // Last frame's velocity, used for computing average velocity.
        var dv: Double = 0
        var dvx: Double = 0
        var dvy: Double = 0 // acceleration
        var Gx: Double = 0
        var Gy: Double = 0 // Gravitational acceleration
        
        var angle: Double = 0 // The actual angle of the bore.
        
        var quit: Bool = false // We know it's time to quit our successive approximation loop when this is 1.
        
        // Start with a very coarse angular change, to quickly solve even large launch angle problems.
        da = radians(degrees: 14)
        
        
        // The general idea here is to start at 0 degrees elevation, and increase the elevation by 14 degrees
        // until we are above the correct elevation.  Then reduce the angular change by half, and begin reducing
        // the angle.  Once we are again below the correct angle, reduce the angular change by half again, and go
        // back up.  This allows for a fast successive approximation of the correct elevation, usually within less
        // than 20 iterations.
        repeat {
            vy=Vi*sin(angle);
            vx=Vi*cos(angle);
            Gx=kGravity*sin(angle);
            Gy=kGravity*cos(angle);
            
            repeat {
                vy1 = vy
                vx1 = vx
                v = pow((pow(vx,2) + pow(vy,2)), 0.5)
                dt = 1 / v;
                
                dv = retard(dragFunction: dragFunction, dragCoefficient: dragCoefficient, velocity: v)
                dvy = -dv * vy / v * dt
                dvx = -dv * vx / v * dt
                
                vx = vx + dvx
                vy = vy + dvy
                vy = vy + dt * Gy
                vx = vx + dt * Gx
                
                x = x + dt * (vx + vx1) / 2
                y = y + dt * (vy + vy1) / 2
                // Break early to save CPU time if we won't find a solution.
                if (vy < 0 && y < yIntercept) {
                    break
                }
                if ( vy > 3 * vx) {
                    break
                }
                
                t += dt
            } while(x <= zeroRange * 3)
            
            if (y > yIntercept && da > 0){
                da = -da / 2
            }
            
            if (y < yIntercept && da < 0){
                da = -da / 2
            }
            
            if (fabs(da) < radians(moa: 0.01)) {
                quit = true  // If our accuracy is sufficient, we can stop approximating.
            }
            if (angle > radians(degrees: 45)) {
                quit = true // If we exceed the 45 degree launch angle, then the projectile just won't get there, so we stop trying.
            }
            
            angle += da
        } while(!quit)
        
        return degrees(radians: angle) // Convert to degrees for return value.
    }
    
    /**
     Generate a ballistic solution table in 1 yard increments, up to kMaxRange.  Stored in solutions array.
     
     - Parameters:
        - dragFunction: The drag function you wish to use for the solution (G1, G2, G3, G5, G6, G7, or G8)
        - dragCoefficient: The coefficient of drag for the projectile you wish to model.
        - Vi: The projectile initial velocity. (feet per second)
        - sightHeight:  The height of the sighting system above the bore centerline. (inches)
                         Most scopes are in the 1.5"-2.0" range.
        - shootingAngle:  The uphill or downhill shooting angle. (degrees)  Usually 0, but can be anything from
                         90 (directly up), to -90 (directly down).
        - zeroAngle:  The angle of the sighting system relative to the bore. (degrees)  This can be easily computed
                     using the zeroAngle() function.
        - windSpeed:  The wind velocity. (miles per hour)
        - windAngle:  The angle at which the wind is approaching from, in degrees.
                     0 degrees is a straight headwind
                     90 degrees is from right to left
                     180 degrees is a straight tailwind
                     -90 or 270 degrees is from left to right.
     - Returns:
                     A Double  representing the maximum valid range of the
                     solution.  This also indicates the maximum number of rows in the solutions collection,
                     and should not be exceeded.
    */
    open func solveAll(dragFunction: DragFunction, dragCoefficient: Double, Vi: Double,
                  sightHeight: Double, shootingAngle: Double, zeroAngle: Double,
                  windSpeed: Double, windAngle: Double) -> Double {
        solutions = []
        
        var t: Double = 0
        var dt: Double = 0.5 / Vi
        var v: Double = 0
        var vx: Double = 0, vx1: Double = 0, vy: Double = 0, vy1: Double = 0
        var dv: Double = 0, dvx: Double = 0, dvy: Double = 0
        var x: Double = 0, y: Double = 0
        
        let headwind: Double = headWind(windSpeed: windSpeed, windAngle: windAngle)
        let crosswind: Double = crossWind(windSpeed: windSpeed, windAngle: windAngle)
        
        let Gy: Double = kGravity * cos(radians(degrees: (shootingAngle + zeroAngle)))
        let Gx: Double = kGravity * sin(radians(degrees: (shootingAngle + zeroAngle)))
        
        vx = Vi * cos(radians(degrees: zeroAngle))
        vy = Vi * sin(radians(degrees: zeroAngle))
        
        y = -sightHeight / 12
        
        var n: Double = 0
        repeat {
            
            vx1 = vx
            vy1 = vy
            v=pow(pow(vx,2)+pow(vy,2),0.5)
            dt=0.5/v
            
            // Compute acceleration using the drag function retardation
            dv = retard(dragFunction: dragFunction,dragCoefficient: dragCoefficient,velocity: (v + headwind))
            dvx = -(vx / v) * dv
            dvy = -(vy / v) * dv

            // Compute velocity, including the resolved gravity vectors.
            vx = vx + dt * dvx + dt * Gx
            vy = vy + dt * dvy + dt * Gy

            t = t + dt

            if (x / 3 >= n){
                solutions?.append( Solution(range: x / 3,
                                            path: y * 12,
                                            correction: -moa(radians: y / x),
                                            time: t,
                                            windage: windage(windSpeed: crosswind,
                                                             Vi: Vi,
                                                             range: x,
                                                             time: t),
                                            velocity: Vi,
                                            velocityX: vx,
                                            velocityY: vy) )
                n += 1;
            }
            
            // Compute position based on average velocity.
            x=x+dt*(vx+vx1)/2;
            y=y+dt*(vy+vy1)/2;
        } while(fabs(vy) <= fabs(3 * vx) && n <= kMaxRange)
                
        return n;
    }
    
    // MARK: - Helpers
    private func degrees(radians: Double) -> Double {
        //        return radians * 180 / Double.pi
        return radians * 57.295779513082320876798154814105
    }
    
    private func moa(degrees: Double) -> Double {
        return degrees * 60.0
    }
    
    private func radians(degrees: Double) -> Double {
        //        return degrees * Double.pi / 180
        return degrees * 0.01745329251994329576923690768489
    }
    
    private func degrees(moa: Double) -> Double {
        return moa / 60.0
    }
    
    private func radians(moa: Double) -> Double {
        return moa * 0.00029088820866572159615394846141477
    }
    
    private func moa(radians: Double) -> Double {
        return radians * 3437.7467707849392526078892888463
    }
}
