local foldername = ...;

local HttpService = cloneref(game:GetService('HttpService'));
local Fonts = {
    _registry = {};
};

if not isfolder(foldername.. '/fonts') then
    makefolder(foldername.. '/fonts');
end;

function Fonts.Append(Name, Data, ENCODED)
    local Path = foldername.. `/fonts/{Name}`;

    if not isfile(`{Path}.ttf`) then
        writefile(`{Path}.ttf`, (ENCODED and base64.decode(Data) or Data));
    end;

    if not isfile(`{Path}.json`) then
        local FontData = HttpService:JSONEncode({
            ['name'] = Name;
            ['faces'] = {{
                ['name'] = 'Regular';
                ['style'] = 'normal';
                ['weight'] = 400;
                ['assetId'] = getcustomasset(`{Path}.ttf`);
            }}
        })

        writefile(`{Path}.json`, FontData);
    end;

    return Font.new(getcustomasset(`{Path}.json`), Enum.FontWeight.Regular, Enum.FontStyle.Normal);
end;

return Fonts;
