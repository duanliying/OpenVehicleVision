classdef LabelImg
    
    %% Public properties
    properties (GetAccess = public, SetAccess = private)
        data
    end
    
    %% Public methods
    methods (Access = public)
	
		function obj = LabelImg(data)
			obj.data = data;
		end
		
		% rewrite the imshow methods
        function h = imshow(obj, varargin)
			h = imshow(label2rgb(obj.data), varargin{:});
        end
		
		function [bw,index] = maxarea(obj)
		% max connected area
		% http://stackoverflow.com/questions/20725603/how-to-select-the-object-with-the-largest-area
			stat = regionprops(obj.data,'Centroid','Area','PixelIdxList');
			[maxValue,index] = max([stat.Area]);
			bw = BwImg(obj.data == index);
        end
        
        function c = uplus(a)
            c = a.data;
        end
    end% methods
    
    methods(Static)
        function [bw,index] = maxareaOf(obj)
		% max connected area
		% http://stackoverflow.com/questions/20725603/how-to-select-the-object-with-the-largest-area
			stat = regionprops(obj,'Centroid','Area','PixelIdxList');
			[~,index] = max([stat.Area]);
			bw = (obj == index);
		end
    end
end% classdef

% æåæ?¤§èé?åé

% åèè?¨è?¸ä¸ï¼å»é¤æç¹ ä¹å¯ä»¥å¨åé¢ç°åº¦è¨è
% æ¾åºæ?¤§çè¿éåéå³ä¸ºè·¯é¢åºåã? æéç¨è¨è?è?®æ³æ¶å»åªç?
% [L, num] = bwlabel(SaturateMap, 4); % TODO 4è¿é?å¯¹æ¯
% x=zeros(1,num);
% for idx=1:num
%    x(idx)=sum(sum(L == idx));
% end
% [m, idx] = max(x);
% Connected = (L == idx);
% DLDæåçä¸ºåé¨ï¼è?Cannyä¸ºè¾¹çï¼æ±ç¹ä¹å°±æ²¡æäºã?ãã?