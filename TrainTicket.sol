pragma solidity 0.4.18 <= 0.6.12;

contract TrainTicket {
    struct Ticket {
        string PassengerName;
        int PassengerAge;
        string PassengerGender;
        string To;
        string From;
        string berthPreference;
    }
    
    mapping (address => Ticket) passengerTicket;
    
function setTrainTicket(string newname,int newage,string newgender,string newTo,string newFrom,string newberthpreference) public returns (int)
{
    Ticket memory ticket = Ticket(newname,newage,newgender,newTo,newFrom,newberthpreference);
    passengerTicket[msg.sender] = ticket;
}
function getTrainTicket() public view returns(string,int,string,string,string,string){
    Ticket memory ticket = passengerTicket[msg.sender];
    return (ticket.PassengerName,ticket.PassengerAge,ticket.PassengerGender,ticket.To,ticket.From,ticket.berthPreference);
}
}
