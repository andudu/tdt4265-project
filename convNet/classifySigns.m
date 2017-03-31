function classes = classifySigns(net, signs)

for i = 1:length(signs)
   classes{i} = classifyWindow(net, signs{i}); 
end
end