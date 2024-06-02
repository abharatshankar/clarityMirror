//
//  AutoCapture.h
//  AutoCapture
//
//  Created by Mac5Dev1 on 22/05/18.
//  Copyright © 2018 Mac5Dev1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMedia/CoreMedia.h>
#import <UIKit/UIKit.h>

@interface AutoCapture : NSObject
{}

@property (nonatomic) NSString* ModelPath;
@property (nonatomic) NSString* tagName;
@property (assign) BOOL isfldInitialized;
//@property NSMutableArray* landMarkPointsonFullRezBestFrame;
@property int stausCodeFinal;

//@property (nonatomic)

//landmark live variables
@property (nonatomic) bool isBRFAutocapture;
@property (nonatomic) bool isOFStability;//for setting OF stability
@property (nonatomic) bool isAvgStability;//for setting Avg stability
@property (nonatomic) bool isDlibFaceFox;//for setting dlib face box detectiio
@property (nonatomic) float stabilityFactor;//for stablization setting in landmark
@property (nonatomic) int Profile;//1-F,2-L,3-R
@property (nonatomic) double ProfileDeterminant;//1-F,2-L,3-R
@property (nonatomic) bool isManualCaptureTaken;
//@property (nonatomic) bool isLeftEyeBest;

//private

-(void)initializingFLDforAutoCapture:(int)imageWidth imageHeight:(int)imageHeight datFilePath:(NSString*)datFilePath;

-(void) n_calculatingFPS;

-(void) assigningLandmarkvariales;

//Autocapturemethods
-(int)performAutocapture:(CMSampleBufferRef)sampleBuffer inRects:(NSArray<NSValue *> *)rects  IQC_ThreshVals:(NSMutableArray*)IQC_ThreshVals;
-(int)performIQConCapture:(NSString*)imgInFile IQC_ThreshVals:(NSMutableArray*)IQC_ThreshVals;
-(int)performIQConUIImage:(UIImage*)imageUI IQC_ThreshVals:(NSMutableArray*)IQC_ThreshVals;

//releasing
-(void) n_releaseMemory:(int)mode;

//setting and getting brfFace initialization
-(void) setBRFInitialization:(bool)set;
-(bool) getBRFInitialization;

-(UIImage*) resizeUIImageinLib:(UIImage*)UIimage resizeto:(int)resolutioninMP;

@end
