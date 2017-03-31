function accuracy = checkAccuracy(testData, net)

testLabels = classify(net, testData);
accuracy = sum(testLabels == testData.Labels)/numel(testData.Labels);
end