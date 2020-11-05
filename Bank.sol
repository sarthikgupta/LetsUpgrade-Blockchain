pragma solidity >=0.4.25;

contract Bank{
    mapping (address => uint256) bankBalance;
    address contractOwner;
    bool private operational = true;  
    
    modifier requireIsOperational()
    {
        require(operational, "Contract is currently not operational");
        _;  // All modifiers require an "_" which indicates where the function body will be added
    }
    
        modifier requireContractOwner()
    {
        require(msg.sender == contractOwner, "Caller is not contract owner");
        _;
    }
    constructor() public{
        contractOwner = msg.sender;
    }   
    function setOperatingStatus
                            (
                                bool mode
                            )
                            external
                            requireContractOwner
    {
        operational = mode;
    }
    function addMoney() public payable requireIsOperational(){
        bankBalance[msg.sender] = msg.value;
    }
    
    function withdrawMoney(address _add) public requireIsOperational() {
        require(msg.sender == _add,"You are not the owner of this account. You cannot withdraw the amount");
        uint256 balance = bankBalance[msg.sender];
        bankBalance[msg.sender] = 0;
        msg.sender.transfer(balance);
    }
    
    function checkBalance(address _add) public view requireIsOperational() returns(uint256){
        require(msg.sender == _add,"You are not the owner of this account. You cannot check the balance.");
        return bankBalance[msg.sender];
    }
    
    function terminateBank() public requireContractOwner(){
        address payable to = payable(contractOwner);
        selfdestruct(to);
    }
}
