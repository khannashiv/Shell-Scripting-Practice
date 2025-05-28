## Sample jq Commands (Tested on sample.json)

Below are useful jq commands to process and extract information from AWS-style JSON files like sample.json.

---

### Instances & Reservations

```bash
# List all Instances arrays
jq '.Reservations[].Instances' sample.json

# List Architectures of all instances
jq '.Reservations[].Instances[].Architecture' sample.json

# Show BlockDeviceMappings for each instance
jq '.Reservations[].Instances[].BlockDeviceMappings[]' sample.json

# Show EBS details for each BlockDeviceMapping
jq '.Reservations[].Instances[].BlockDeviceMappings[].Ebs' sample.json

# Get VPC IDs for each instance
jq '.Reservations[].Instances[].VpcId' sample.json

# Get all LoadBalancerDescriptions
jq '.LoadBalancerDescriptions' sample.json

# Get Placement Availability Zones for each instance
jq '.Reservations[].Instances[].Placement.AvailabilityZone' sample.json

# List Instances with their InstanceId and InstanceType
jq '.Reservations[].Instances[] | {InstanceId, InstanceType}' sample.json

# List Availability Zones with alias
jq '.Reservations[].Instances[] | {AZ: .Placement.AvailabilityZone}' sample.json
```

---

### Filtering & Selecting Instances

```bash
# Show running instance IDs
jq '.Reservations[].Instances[] | select(.State.Name=="running") | .InstanceId' sample.json

# Show InstanceId and InstanceType for running instances
jq '.Reservations[].Instances[] | select(.State.Name=="running") | .InstanceId, .InstanceType' sample.json

# Show object with InstanceId and InstanceType for running instances
jq '.Reservations[].Instances[] | select(.State.Name=="running") | { InstanceId, InstanceType }' sample.json

# Show object with InstanceId and State for running instances
jq '.Reservations[].Instances[] | select(.State.Name == "running") | { InstanceId, State: .State.Name }' sample.json
```

---

### Network Details

```bash
# Show Network Interface Associations
jq '.Reservations[].Instances[].NetworkInterfaces[].Association' sample.json

# Show public IPs associated with network interfaces
jq '.Reservations[].Instances[].NetworkInterfaces[].Association.PublicIp' sample.json
```

---

### User Details

```bash
# Show UserId
jq '.User.UserId' sample.json
```

---

### Array Slicing

```bash
# Get the first two Reservations
jq '.Reservations[0:2]' sample.json

# Get the first Reservation
jq '.Reservations[0]' sample.json
```

---

## Notes on jq

- Format: jq '<filter>' <file>
    - <filter>: Operation to perform on the JSON data.
    - <file>: The JSON file (or stream) to be processed.
- The dot (.) refers to the current object (initially the root of the JSON).
- Keys in the above examples include Instances, Architecture, Ebs, Association, PublicIp, VpcId, UserId, etc.
- select(...) is used to filter elements by a condition.
- Example:  
    jq '.Reservations[0:2]' sample.json  
    Returns the first two elements of the Reservations array.


