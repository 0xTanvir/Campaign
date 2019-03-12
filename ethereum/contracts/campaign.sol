pragma solidity >=0.4.22 <0.6.0;

contract CampaignFactory {
    address[] public deployedCampaigns;
    
    function createCampaign(uint minimum) public {
        address newCampaign = new Campaign(minimum, msg.sender);
        deployedCampaigns.push(newCampaign);
    }
    
    function getDeployedCampaigns() public view returns(address[]) {
        return deployedCampaigns;
    }
    
}

contract Campaign {
    
    struct Request {
        string description;
        uint value;
        address recipient;
        bool complete;
        uint approvalCount;
        mapping(address => bool) approvals;
    }
    
    Request[] public requests;
    address public inventor;
    uint public minContribution;
    mapping (address => bool) public approvers;
    uint approversCount;
    
    modifier restricted() {
        require(msg.sender == inventor, "Sender is not authorized.");
        _;
    }
    
    constructor(uint min, address creator) public {
        inventor = creator;
        minContribution = min;
    }
    
    function contribute() public payable {
        require(msg.value >= minContribution, "Contribution amount is not enough");
        approvers[msg.sender] = true;
        approversCount++;
    }
    
    function createRequest(string description, uint value, address recipient) public restricted {
        Request memory newRequest = Request({
            description : description,
            value : value,
            recipient : recipient,
            complete : false,
            approvalCount : 0
        });
        
        requests.push(newRequest);
    }
    
    function approveRequest(uint index) public {
        Request storage request = requests[index];
        
        require(approvers[msg.sender], "Approver is not a donator.");
        require(!request.approvals[msg.sender], "Approver already voted.");
        
        request.approvals[msg.sender] = true;
        request.approvalCount++;
    }
    
    function finalizeRequest(uint index) public restricted {
        Request storage request = requests[index];
        
        require(request.approvalCount>(approversCount/2), "approvalCount should be getter then the half of approversCount.");
        require(!request.complete, "Request already completed.");
        
        request.recipient.transfer(request.value);
        request.complete = true;
    }
}

