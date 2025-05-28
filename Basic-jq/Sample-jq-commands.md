## Sample jq commands tested on sample.json


  - jq '.Reservations[].Instances' sample.json
  - jq '.Reservations[].Instances[].Architecture' sample.json
  - jq '.Reservations[].Instances[].BlockDeviceMappings[]' sample.json
  - jq '.Reservations[].Instances[].BlockDeviceMappings[].Ebs' sample.json
  - jq '.Reservations[].Instances[].NetworkInterfaces[].Association' sample.json
  - jq '.Reservations[].Instances[].NetworkInterfaces[].Association.PublicIp' sample.json
  - jq '.Reservations[].Instances[].VpcId' sample.json
  - jq '.User.UserId' sample.json
  - jq '.LoadBalancerDescriptions' sample.json
  - jq '.Reservations[].Instances[] | {InstanceId,InstanceType}' sample.json
  - jq '.Reservations[].Instances[].Placement.AvailabilityZone' sample.json
  - jq '.Reservations[].Instances[] | {AZ: .Placement.AvailabilityZone}' sample.json
  - jq '.Reservations[].Instances[] | select(.State.Name=="running") | .InstanceId' sample.json
  - jq '.Reservations[].Instances[] | select(.State.Name=="running") | .InstanceId, .InstanceType' sample.json
  - jq '.Reservations[].Instances[] | select(.State.Name=="running") | { InstanceId, InstanceType }' sample.json
  - jq '.Reservations[].Instances[] | select(.State.Name == "running") | { InstanceId, State: .State.Name }' sample.json
  - jq '.Reservations[0:2]' sample.json
  - jq '.Reservations[0]' sample.json

<!-- 
    #### Basic points on jq #####

  - jq '<filter>' <file>
    - <filter>: The operation you want to perform on the JSON data.
    - <file>: The JSON file you're working with (it could also be a stream of data).

  - The dot refers to the current object. Initially, it points to the root of the JSON data (the entire object).

  - In the above example, Instances + Architecture + Ebs + Association + PublicIp + VpcId + UserId . All of them are keys .

  - The select function in jq is used to filter or select elements from a stream of data based on a condition. It helps to pick out specific items from the input JSON that match a condition you define. When you use select, it checks each element against the given condition and keeps those that pass the filter.

  - jq '.Reservations[0:2]' sample.json : It will return the first two elements (indexes 0 and 1) from the Reservations array in the sample.json file.
  
 -->


