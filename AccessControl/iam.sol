//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract AdminPanel {

    event GrantRole(bytes32 indexed role, address indexed account);
    event RevokeRole(bytes32 indexed role, address indexed account);

    // ADMIN 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
    // USER  0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db
    // USER  0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2

    mapping(bytes32 => mapping(address => bool)) public roles;
    
    // 0xdf8b4c520ffe197c5343c6f5aec59570151ef9a492f2c624fd45ddde6135ec42
    bytes32 private constant ADMIN = keccak256(abi.encodePacked("ADMIN"));
    // 0x2db9fd3d099848027c2383d0a083396f6c41510d7acfd92adc99b6cffcf31e96
    bytes32 private constant USER = keccak256(abi.encodePacked("USER"));

    modifier onlyAdmin(bytes32 _role) {
        require(roles[_role][msg.sender], "not admin, access denied");
        _;
    }

    constructor() {
        _grantRole(ADMIN, msg.sender);
    }

    function _grantRole(bytes32 _role, address _account) internal {
        roles[_role][_account] = true;
        emit GrantRole(_role, _account);
    }

    function grantRole(bytes32 _role, address _account) external onlyAdmin(ADMIN) {
        _grantRole(_role, _account);
    }

    function _revokeRole(bytes32 _role, address _account) internal {
        roles[_role][_account] = false;
        emit GrantRole(_role, _account);
    }

    function revokeRole(bytes32 _role, address _account) external onlyAdmin(ADMIN) {
        _revokeRole(_role, _account);
    }
}