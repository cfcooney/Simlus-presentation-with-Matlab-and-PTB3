function prompt = get_prompt(name)
%----------------------------------------------------------------
% Function for returning the text, image or audio prompt for a given
% trial.
% Input: name (str): name of trial prompt e.g. 'pig_image'
%  
% Output: prompt (.jpg/.ogg/text): prompt in the format to be displayed

newString = split(name,'_');

if string(newString(2)) == 'image'
    prompt = get_image(char(newString(1)));
elseif string(newString(2)) == 'audio'
        prompt = get_audio(char(newString(1)));
else
    if strcmp(char(newString(1)),'redball')
        prompt = 'red ball';
    elseif strcmp(char(newString(1)),'bluehat')
        prompt = 'blue hat';
    elseif strcmp(char(newString(1)),'redblue')
        prompt = 'red blue';
    elseif strcmp(char(newString(1)),'ballhat')
        prompt = 'ball hat';
    else
        prompt = char(newString(1));
    end
end
end
