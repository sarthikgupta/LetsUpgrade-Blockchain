pragma solidity >= 0.5.13;

contract LaxmiChitFuncLotterySystem {
    address[] lotteryparticipant;
    address contractOwner;
    uint256 public constant TICKET_AMOUNT = 1 ether;
    bool private operational = true;
    address winner;
    modifier requireIsOperational() {
        require(operational, "Contract is currently not operational");
        _;
    }

    modifier requireContractOwner() {
        require(msg.sender == contractOwner, "Caller is not contract owner");
        _;
    }

    constructor() public {
        contractOwner = msg.sender;
    }

    function setOperatingStatus(bool mode) external requireContractOwner {
        operational = mode;
    }

    function purchaseTicket() public payable requireIsOperational() {
        uint arrayLength = lotteryparticipant.length;
        uint flag = 0;
        for (uint i = 0; i < arrayLength; i++) {
            if (lotteryparticipant[i] == msg.sender) {
                flag = 1;
                break;
            }
        }
        require(flag == 0, "You have already purchased a ticket");
        require(msg.value >= TICKET_AMOUNT, "Please pay amount more than 1 ETH to purchase a lottery ticket.");
        lotteryparticipant.push(msg.sender);
    }

    function getLength() public returns(uint) {
        uint arrayLength = lotteryparticipant.length;
        return arrayLength;
    }

    function transferEtherToWinner() public requireIsOperational() requireContractOwner() {
        uint randomnum = randomNumberGenerator();
        winner = lotteryparticipant[randomnum];
        uint totalamount = address(this).balance;
        payable(winner).transfer(totalamount);
        lotteryparticipant = new address[](0);
    }

    function randomNumberGenerator() private view requireContractOwner() returns(uint) {
        uint randomnumber = uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, msg.sender))) % lotteryparticipant.length;
        return randomnumber;
    }


    function terminateLotterySystem() external requireContractOwner() {
        address payable to = payable(contractOwner);
        selfdestruct(to);
    }
}
