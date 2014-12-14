function [H] = ComputeWarpMapping(img1pts, img2pts)

H = img1pts\img2pts;
end
