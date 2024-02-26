function rgb=hex2rgb(hex)
%% -- convert colors in hex format to rgb
% INPUTS - hex - hex string
% OUTPUT - rgb - color in rgb format
%% --

		r = double(hex2dec(hex(1:2)))/255;
		g = double(hex2dec(hex(3:4)))/255;
		b = double(hex2dec(hex(5:6)))/255;
		rgb = [r, g, b];


end