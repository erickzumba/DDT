// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Taxi {
    string public name;
    uint public rideCount = 0;
    uint public requestCount = 0;
    mapping(uint => Request) public requests;

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
        Request req;
        address driver;       
    }

    event rideCreated (
        Request req,
        address driver       

    );

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
   // function startRide(string memory _riderName, string _fromLocation, string _toLocation) public {
        // Require a valid name
       // require(bytes(_riderName).length > 0);
        // Increment product count
       // rideCount ++;
        // Create the product
      //  rides[rideCount] = Ride(rideCount, _riderName, _fromLocation, _toLocation,  msg.sender );
        // Trigger an event
//emit ProductCreated(productCount, _name, _price, msg.sender, false);
   // }







}