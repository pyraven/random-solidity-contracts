// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;

contract TaskList {

    struct Task {
        uint taskId;
        string name;
        string description;
    }

    uint private taskCount;
    Task[] private tasks;
    address private owner;

    constructor() {
        owner = msg.sender;
    }
    
    modifier ownerGuard() {
    require(msg.sender == owner, "You don't look to be the owner...");
    _;
    }

    function createTask(string calldata _name, string calldata _description) public ownerGuard {
        tasks.push(Task(taskCount, _name, _description));
        taskCount++;
    }

    function readTask(uint _index) public view returns(uint, string memory, string memory)  {
        uint index = idSearch(_index);
        return (tasks[index].taskId, tasks[index].name, tasks[index].description);
    }

    function updateTask(uint _index, string calldata _name, string calldata _description) public ownerGuard {
        uint index = idSearch(_index);
        tasks[index].name = _name;
        tasks[index].description = _description;
    }

    function deleteTask(uint _index) public ownerGuard{
        uint index = idSearch(_index);
        delete tasks[index];
    }

    function idSearch(uint _index) private view returns(uint) {
        for (uint i = 0; i < tasks.length; i++) {
            if(tasks[i].taskId == _index) {
                return i;
            }
        }
        revert("Entry Not found.");
    }
}