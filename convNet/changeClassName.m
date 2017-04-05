% Want more describing class names than 00001, 00002, ...
function modifiedClass = changeClassName(class)

switch class
    case '00001'
        modifiedClass = categorical({'Speed limit: 30'});
    case '00002'
        modifiedClass = categorical({'Speed limit: 50'});
    case '00003'
        modifiedClass = categorical({'Speed limit 80'});
end

end