clear all
close all

% Configure build folder structure
Simulink.fileGenControl('set', ...
    'CacheFolder', 'cache', ...
    'CodeGenFolder', 'build',...
    'createDir',true...
);

% Install by adding to path
addpath(genpath(pwd()));

% Load supply ship
load('supply.mat');
load('supplyABC.mat');

% Add properties required by Simscape lib
vessel = vessel2simscape(vessel);


% 1 st order filter time constant
tau = 10e-3;