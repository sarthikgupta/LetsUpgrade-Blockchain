pragma solidity 0.4.18 <= 0.6.12;

contract Expenses {
    
    struct restaurantBill {
        string empname;
        int employeeId;
        string restaurantName;
        int restBillAmount;
        string date;
    }
    
    mapping (address => restaurantBill) restaurantBills;
    
function setTrainTicket(string newempname,int newid,string newresname,int billamt,string newdate) public
{
    restaurantBill memory resbill = restaurantBill(newempname,newid,newresname,billamt,newdate);
    restaurantBills[msg.sender] = resbill;
}
function getTrainTicket() public view returns(string,int,string,int,string){
    restaurantBill memory resbill = restaurantBills[msg.sender];
    return (resbill.empname,resbill.employeeId,resbill.restaurantName,resbill.restBillAmount,resbill.date);
}
}