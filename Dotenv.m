classdef Dotenv
    % Copyright 2019-2019 The MathWorks, Inc.
    
    %Dotenv Implementation of common dotenv pattern
    %   See https://github.com/motdotla/dotenv for inspiration
    
    properties (SetAccess = immutable)
        fname
        env
    end
    
    methods
        function obj = Dotenv(location)
            obj.env = struct;
            switch nargin
                case 1 % if there is an argument load that file
                    obj.fname = location;
                case 0 % otherwise load the file from the current directory
                    obj.fname = '.env';
            end
            
            % load the .env file with name=value pairs into the 'env' struct
            try
                fid = fopen(obj.fname, 'r');
                assert(fid ~= -1);
            catch
                throw( MException('DOTENV:CannotOpenFile', "Cannot open file: " + obj.fname + ". Code: " + fid) );
            end
            
            lines = [];
            while ~feof(fid)
                tline = string(fgetl(fid));
                lines = [lines tline];
            end
            fclose(fid);

            notOK = startsWith(lines, '#');
            lines(notOK) = [];
                   
            expr = "(?<key>.+?)=(?<value>.*)";
            kvpair = regexp(lines, expr, 'names');
            
            % Deal with single entry case where regexp does not return a
            % cell array
            if iscell(kvpair)
                kvpair(cellfun(@isempty, kvpair)) = [];
                kvpair = cellfun(@(x) struct('key', x.key, 'value', x.value), kvpair);
            end
            
            obj.env = cell2struct(strtrim({kvpair.value}), [kvpair.key], 2);
            
        end
        
        function val = subsref(obj, s)
            if size(s, 2) == 1
                % this handles the case of d.env
                val=obj.env;
            else
                % this handles the case of d.env.KEY_NAME
                if isfield(obj.env, s(2).subs)
                    val = obj.env.(s(2).subs);
                else
                    val = "";
                end
            end
        end
        
    end
    
end

