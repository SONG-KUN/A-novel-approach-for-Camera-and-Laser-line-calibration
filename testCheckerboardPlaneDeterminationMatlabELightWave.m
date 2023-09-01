clearvars
close all
clc

%% checkerboard plane determination test
image=imread('scacchieraTest_0001.png');
[ rotationMatrix, translationVector,outputTarget,points3D,Zplane ] = findCheckerboard3DPosition( image,cameraParams,60 );
[RT,HorizPlaneLW] = transfLightwave2Matlab(0,0,0,0,0,2000,0,0,0,0,0,0);
disp(Zplane);
disp(HorizPlaneLW);
disp('-------------------------------------------------------');

%%
image=imread('scacchieraTest_0002.png');
[ rotationMatrix, translationVector,outputTarget,points3D,Zplane ] = findCheckerboard3DPosition( image,cameraParams,60 );
[RT,HorizPlaneLW] = transfLightwave2Matlab(10,20,30,0,0,2000,0,0,0,0,0,0);
disp(Zplane);
disp(HorizPlaneLW);
disp('-------------------------------------------------------');
image=imread('scacchieraTest_0003.png');
[ rotationMatrix, translationVector,outputTarget,points3D,Zplane ] = findCheckerboard3DPosition( image,cameraParams,60 );
[RT,HorizPlaneLW] = transfLightwave2Matlab(10,0,0,0,0,2000,0,0,0,0,0,0);
disp(Zplane);
disp(HorizPlaneLW);
disp('-------------------------------------------------------');
image=imread('scacchieraTest_0004.png');
[ rotationMatrix, translationVector,outputTarget,points3D,Zplane ] = findCheckerboard3DPosition( image,cameraParams,60 );
[RT,HorizPlaneLW] = transfLightwave2Matlab(0,20,0,0,0,2000,0,0,0,0,0,0);
disp(Zplane);
disp(HorizPlaneLW);
disp('-------------------------------------------------------');
image=imread('scacchieraTest_0005.png');
[ rotationMatrix, translationVector,outputTarget,points3D,Zplane ] = findCheckerboard3DPosition( image,cameraParams,60 );
[RT,HorizPlaneLW] = transfLightwave2Matlab(0,0,30,0,-100,2000,0,0,0,0,0,0);
disp(Zplane);
disp(HorizPlaneLW);
disp('-------------------------------------------------------');
image=imread('scacchieraTest_0006.png');
[ rotationMatrix, translationVector,outputTarget,points3D,Zplane ] = findCheckerboard3DPosition( image,cameraParams,60 );
[RT,HorizPlaneLW] = transfLightwave2Matlab(0,20,30,0,0,2000,0,0,0,0,0,0);
disp(Zplane);
disp(HorizPlaneLW);
disp('-------------------------------------------------------');
image=imread('scacchieraTest_0007.png');
[ rotationMatrix, translationVector,outputTarget,points3D,Zplane ] = findCheckerboard3DPosition( image,cameraParams,60 );
[RT,HorizPlaneLW] = transfLightwave2Matlab(30,30,30,-100,-200,2000,0,0,0,0,0,0);
disp(Zplane);
disp(HorizPlaneLW);
disp('-------------------------------------------------------');
image=imread('scacchieraTest_0008.png');
[ rotationMatrix, translationVector,outputTarget,points3D,Zplane ] = findCheckerboard3DPosition( image,cameraParams,60 );
[RT,HorizPlaneLW] = transfLightwave2Matlab(30,30,30,-100,-200,2000,20,5,-10,10,50,-30);
disp(Zplane);
disp(HorizPlaneLW);
disp('-------------------------------------------------------');
