//
//  pthelpers.c
//  CMTest
//
//  Created by David Messing on 10/27/14.
//  Copyright (c) 2014 iMagicLab. All rights reserved.
//

#include "pthelpers.h"

#include "Math.h"

/** Degrees to Radian **/
#define convertDegreesToRadians( degrees ) ( ( degrees ) / 180.0 * M_PI )

/** Radians to Degrees **/
#define convertRadiansToDegrees( radians ) ( ( radians ) * ( 180.0 / M_PI ) )

double degreesToRadians(double d) {
    return convertDegreesToRadians(d);
}

double radiansToDegrees(double r) {
    return convertRadiansToDegrees(r);
}

double normalise( const double value, const double start, const double end )
{
    const double width       = end - start   ;   //
    const double offsetValue = value - start ;   // value relative to 0
    
    return ( offsetValue - ( floor( offsetValue / width ) * width ) ) + start ;
    // + start to reset back to start of original range
}