function [fileNameList, suffix] = getFileNames(pathName)
%GETFILES Summary of this function goes here
%   Detailed explanation goes here

tmp = dir(pathName);
fileNameList = arrayfun(@(x) x.name, tmp, 'UniformOutput', 0)';
fileNameList = fileNameList(cellfun(@(x) ~isdir(fullfile(pathName,x)), fileNameList));
[~, fileNameList, suffix] = cellfun(@(x) fileparts(x), fileNameList, 'UniformOutput', 0);
suffix = suffix{1};

end

