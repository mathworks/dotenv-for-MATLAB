classdef Dotenv < handle
    % Copyright 2019-2019 The MathWorks, Inc.
    
    %Dotenv Implementation of common dotenv pattern
    %   See https://github.com/motdotla/dotenv for inspiration
    
    properties (Access = private)
        fname
    end
    
    properties
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
            
        end
        
        function delete(obj)
            obj.env = {};
            obj.fname = "";
        end
        
        function val = subsref(obj, s)
            operator = s(1).subs;
            
            switch operator
                case "configure"
                    configure(obj);
                case "env"
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
        
        
        
        
        
        function configure(obj)
            % load the .env file with name=value pairs into the 'env' struct
            try
                fid = fopen(obj.fname, 'r');
                assert(fid ~= -1);
            catch
                msgID = 'DOTENV:CannotOpenFile';
                msg = "Cannot open file: " + obj.fname + ". Code: " +fid;
                baseException = MException(msgID, msg);
                throw(baseException);
            end
            
            expr = "(?<key>.+?)=(?<value>.*)";
            fline = [];
            while ~feof(fid)
                tline = string(fgetl(fid));
                fline = [fline tline];
            end
            kvpair = regexp(fline, expr, 'names');
            
            % remove blank lines
            kvpair = kvpair(~cellfun('isempty', kvpair));
            
            for k = 1:length(kvpair)
                key = kvpair{1,k}(1).key;
                if startsWith(key, "#") == true
                    continue
                end
                value = strtrim(kvpair{1,k}(1).value);
                
                obj.env.(key) = value;
            end
            
            fclose(fid);
            clear T fid;
        end
        
    end
    
end

