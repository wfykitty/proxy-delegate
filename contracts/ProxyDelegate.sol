pragma solidity ^0.5.0;

contract ProxyDelegate {
    uint256 public version;
    address public delegate;  // contract to delegate calls to
    address public owner;
    
    event LogResult(bytes result);

    constructor(address delegateAddress) public {
        owner = msg.sender;
        delegate = delegateAddress;
    }

    function() external {
        (bool success, bytes memory returnData) = delegate.delegatecall(msg.data);
        require(success, "external call failed");
        emit LogResult(returnData);
    }
}