// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Taxi {
    string public name;
    uint public rideCount = 0;
    uint public requestCount = 0;
    mapping(uint => Request) public requests;
    mapping(uint => Ride) public rides;
    constructor()  {
        name = "CCT Taxi App";
            }


 struct Request {
        uint id;      
        string fromLocation;
        string toLocation;
        address rider;       
    }

    event reqCreated (
        uint id,
        string fromLocation,
        string toLocation,
        address rider       

    );

    struct Ride {
        uint id;
        Request req;
        uint price;
        address payable driver;       
    }

    event rideCreated (
        uint id,
        Request req,
        uint price,
        address payable  driver       

    );

    event rideStarted(
        uint id,       
        uint price,
        address payable driver  
    );

//from customers POV
    function createRequest(string memory _fromLocation, string memory _toLocation) public {
    // Require a valid location
    require(bytes(_fromLocation).length > 0);
    require(bytes(_toLocation).length > 0);     
    // Increment request count
    requestCount ++;
    // Create the request
    requests[requestCount] = Request(requestCount, _fromLocation, _toLocation, msg.sender);
    // Trigger an event
    emit reqCreated(requestCount, _fromLocation,_toLocation, msg.sender);
}

//from Drivers POV
function createRide(uint _id , uint _price) public {
    // Require a valid location
   
    Request memory _request = requests[_id];
    
    // Increment ride count
    rideCount ++;
    // Create the ride
    rides[rideCount] = Ride(rideCount, _request, _price, payable(msg.sender));
    // Trigger an event
    emit rideCreated(rideCount,_request, _price, payable(msg.sender));
}

//will start only when customer has accepted price  needs ride id
function startRide(uint _id) public payable {
    // Require a valid location
    require(_id > 0);       
    // Increment request count
    Ride memory _ride = rides[_id];
    // Fetch the owner
    address payable _driver = _ride.driver;
    // Make sure the product has a valid id
    require(_ride.id > 0 && _ride.id <= rideCount);
    // Require that there is enough Ether in the transaction
    require(msg.value >= _ride.price);    
    // Update the product
    rides[_id] = _ride;
    // Pay the seller by sending them Ether
    _driver.transfer(msg.value);
    // Trigger an event
    emit rideStarted(rideCount, _ride.price, payable(msg.sender));
}

   







}