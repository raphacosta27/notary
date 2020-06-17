pragma solidity >=0.5.0 <0.7.0;


contract Notary {

    struct Document {
        address signature;
        uint256 timestamp;
    }

    mapping(bytes32 => Document) documents;

    function getDocument(bytes32 docHash) public view returns(address, uint256) {
        address owner = documents[docHash].signature;
        uint256 timestamp = documents[docHash].timestamp;
        return (owner, timestamp);
    }

    function writeDocument(bytes32 docHash) public returns(bool) {
        require(documents[docHash].timestamp == 0, "Document already exists, to update use updateOwner");
        documents[docHash].signature = msg.sender;
        documents[docHash].timestamp = now;
        return true;
    }

    function updateOwner(bytes32 docHash) public returns (bool) {
        require(documents[docHash].timestamp != 0, "Document doesn't exist, use writeDocument to create new");
        documents[docHash].signature = msg.sender;
        documents[docHash].timestamp = now;
        return true;
    }
}