% Want more describing class names than 00001, 00002, ...
function modifiedClass = changeClassName(class)

switch class
    case '00000'
        modifiedClass = categorical({'Speed limit: 20'});
    case '00001'
        modifiedClass = categorical({'Speed limit: 30'});
    case '00002'
        modifiedClass = categorical({'Speed limit 50'});
    case '00003'
        modifiedClass = categorical({'Speed limit: 60'});
    case '00004'
        modifiedClass = categorical({'Speed limit: 70'});
    case '00005'
        modifiedClass = categorical({'Speed limit: 80'});
    case '00006'
        modifiedClass = categorical({'No longer 80'});
    case '00007'
        modifiedClass = categorical({'Speed limit: 100'});
    case '00008'
        modifiedClass = categorical({'Speed limit 120'});
    case '00009'
        modifiedClass = categorical({'???'});
    case '00010'
        modifiedClass = categorical({'???'});
    case '00011'
        modifiedClass = categorical({'Small road crossing'});
    case '00012'
        modifiedClass = categorical({'Right of Way'});
    case '00013'
        modifiedClass = categorical({'Yield'});
    case '00014'
        modifiedClass = categorical({'Stop'});
    case '00015'
        modifiedClass = categorical({'???'});
    case '00016'
        modifiedClass = categorical({'Trucks illegal'});
    case '00017'
        modifiedClass = categorical({'Wrong direction'});
    case '00018'
        modifiedClass = categorical({'???'});
    case '00019'
        modifiedClass = categorical({'???'});
    case '00020'
        modifiedClass = categorical({'Sharp right turn'});
    case '00021'
        modifiedClass = categorical({'Winding road'});
    case '00022'
        modifiedClass = categorical({'Bumpy road'});
    case '00023'
        modifiedClass = categorical({'???'});
    case '00024'
        modifiedClass = categorical({'???'});
    case '00025'
        modifiedClass = categorical({'Construction work'});
    case '00026'
        modifiedClass = categorical({'???'});
    case '00027'
        modifiedClass = categorical({'People crossing'});
    case '00028'
        modifiedClass = categorical({'???'});
    case '00029'
        modifiedClass = categorical({'???'});
    case '00030'
        modifiedClass = categorical({'???'});
    case '00031'
        modifiedClass = categorical({'Deer'});
    case '00032'
        modifiedClass = categorical({'???'});
    case '00033'
        modifiedClass = categorical({'Must turn right'});
    case '00034'
        modifiedClass = categorical({'Must turn left'});
    case '00035'
        modifiedClass = categorical({'Must go straight'});
    case '00036'
        modifiedClass = categorical({'Must turn right or go straight'});
    case '00037'
        modifiedClass = categorical({'Must turn left or go straight'});
    case '00038'
        modifiedClass = categorical({'Keep right'});
    case '00039'
        modifiedClass = categorical({'Keep left'});
    case '00040'
        modifiedClass = categorical({'Roundabout'});
    case '00041'
        modifiedClass = categorical({'???'});
    case '00042'
        modifiedClass = categorical({'???'});        
end

end