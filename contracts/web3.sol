// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.18;

contract web3 {
   struct Access{
       address user;
       bool access; //true or false

   }
   mapping (address=> Access[]) acesslist;
   mapping  (address=> string[]) value;
   mapping  (address => mapping(address=>bool) ) ownership;
   mapping  (address=>mapping (address =>bool))previousData;

   function add (address _user, string memory url ) external {
       value[_user].push(url);
   }
   function allow(address user) external {
       ownership[msg.sender][user]=true;
       if (previousData[msg.sender][user]){
           for (uint i=0; i<acesslist[msg.sender].length;i++){
               if (acesslist[msg.sender][i].user==user){
               acesslist[msg.sender][i].access=true;
               }
           }
       }
       else{
           acesslist[msg.sender].push(Access(msg.sender,true));
           previousData[msg.sender][user]=true;
       }

   }
   function disallow (address user )public {
       ownership[msg.sender][user]=false;
       for (uint i=0; i<acesslist[msg.sender].length;i++){
           if (acesslist[msg.sender][i].user==user){
                acesslist[msg.sender][i].access=false;
           }
       }
   }

   function display (address _user) external view returns (string[] memory){
       require(_user==msg.sender || ownership[msg.sender][_user],"You don't have acess");
       return  value[_user];
   }

   function shareAcess() public view returns (Access[] memory){
       return  acesslist[msg.sender];
   }


}
