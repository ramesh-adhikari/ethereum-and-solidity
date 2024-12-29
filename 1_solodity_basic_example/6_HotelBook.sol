// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract HotelBook {

    enum status {Vaccant, Occupied}

    status public  currentStatus;

    event Occupy(address _occupant, uint _value);

    address payable public  owner;

    constructor() {
        owner = payable (msg.sender);
        currentStatus = status.Vaccant ;
    }

    modifier onlyWhileVaccant() {
        require(currentStatus == status.Vaccant, "Currently Occupied");
        _;
    }

    modifier price(uint _amount) {
        require(msg.value >= _amount, "Not enought amount provided");
        _;
    }

    function book() public payable onlyWhileVaccant price(2 ether) {
        currentStatus = status.Occupied;

        (bool sent, bytes memory data) = owner.call{value: msg.value}("");
        require(true);
        
        emit Occupy(msg.sender, msg.value);
    }

}