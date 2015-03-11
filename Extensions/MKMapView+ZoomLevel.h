//
//  MKMapView+ZoomLevel.h
//  Utils
//
//  Created by Mykola Denysyuk on 3/11/15.
//  Copyright (c) 2015 Mykola Denysyuk. All rights reserved.
//
// get from http://troybrant.net/blog/2010/01/set-the-zoom-level-of-an-mkmapview/
// Set the Zoom Level of an MKMapView
// By Troy on January 22, 2010


#import <MapKit/MapKit.h>

@interface MKMapView (ZoomLevel)
- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;
@end
