pragma solidity >=0.5.0 <0.6.0;
import "libraries/SafeMath.sol";
import "libraries/ERC721.sol";

contract ProjectFactory is ERC271 {
    event NewProject(uint ProjectId, string ProjectName, address creatorAddress);

    using SafeMath for uint256;
    enum ProjectStatus{ PROPOSED, APPROVED, REJECTED }

    struct Project {
      string projectName;
      string description;
      uint256 creationTime;
      uint256 deadlineTime;
      address creatorAddress;
      ProjectStatus projectStatus;
      uint256 requestedAmountInWei;
      uint256 currentDepositedBalance;
    }

    Project[] public projects;

    mapping (uint => address) public projectToOwner;
    mapping (address => uint) projectCount;

    function _createProject(string memory _projectName, string memory _description, uint _daysToDeadline, address _creatorAddress, uint _requestedAmountInWei) internal {
        uint256 _creationTime = now;
        projects.push(Project(_projectName, _description, _creationTime, _creationTime + _daysToDeadline days, _creatorAddress, ProjectStatus.PROPOSED, _requestedAmountInWei, 0) - 1;
        uint id = uint(keccak256(abi.encodePacked(_projectName, _creationTime, _creatorAddress)))
        projectToOwner[id] = msg.sender;
        projectCount[msg.sender]++;
        emit NewProject(id, _name, _creatorAddress, _creationTime, _deadlineTime, _projectStatus, _requestedAmountInWei);
    }


}