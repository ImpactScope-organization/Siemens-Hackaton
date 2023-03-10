// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "operator-filter-registry/src/DefaultOperatorFilterer.sol";

contract SiemensHackathon is DefaultOperatorFilterer, ERC721Enumerable, Ownable {
    struct NFT {
        string imageIPFS;
        string proofIPFS;
        string totalEnergyConsumption;
        string shareOfRenewables;
        string totalEnergyConsumption2;
        string shareOfRenewables2;
        uint256 sensedDate;

    }
    NFT[100] nfts;
    address public admin;
    string public baseURI;
    modifier onlyAdmin {
        require(msg.sender == admin);
        _;
    }
    constructor(address _admin, string memory __baseURI) ERC721("Siemens Dynamic NFT", "SDNFT") {
        admin = _admin;
        baseURI = __baseURI;
    }
    function _baseURI() internal override view returns(string memory) {
        return baseURI;
    }
    function getNFT(uint id) external view returns(NFT memory) {
        require(id > 0 && id <= totalSupply());
        return nfts[id - 1];
    }
    function mint(string memory image, string memory proof,
    string memory totalEnergyConsumption2, string memory totalEnergyConsumption, uint256  sensedDate, string memory shareOfRenewables2, string memory shareOfRenewables) onlyAdmin external returns(uint id) {
        uint supply = totalSupply();
        require(supply < 100, "Maximum number of NFTs minted");
        id = supply + 1;
        _safeMint(msg.sender, id);
        nfts[id - 1].imageIPFS = image;
        nfts[id - 1].proofIPFS = proof;
        nfts[id - 1].sensedDate = sensedDate;
        nfts[id - 1].totalEnergyConsumption = totalEnergyConsumption;
        nfts[id - 1].totalEnergyConsumption2 = totalEnergyConsumption2;
        nfts[id - 1].shareOfRenewables = shareOfRenewables2;
        nfts[id - 1].shareOfRenewables = shareOfRenewables;
    }
    function setBaseUri(string memory str) external onlyOwner {
        baseURI = str;
    }
    function setAdmin(address _admin) external onlyOwner {
        admin = _admin;
    }
    function setImage(uint id, string memory image) external onlyAdmin {
        require(id > 0 && id <= totalSupply());
        nfts[id - 1].imageIPFS = image;
    }
    function setProof(uint id, string memory proof) external onlyAdmin {
        require(id > 0 && id <= totalSupply());
        nfts[id - 1].proofIPFS = proof;
    }
    function setDate(uint id, uint256 date) external onlyAdmin {
        require(id > 0 && id <= totalSupply());
        nfts[id - 1].sensedDate = date;
    }
    function setTotalEnergyConsumption(uint id, string memory totalEnergyConsumption) external onlyAdmin {
        require(id > 0 && id <= totalSupply());
        nfts[id - 1].totalEnergyConsumption = totalEnergyConsumption;
    }
    function setShareOfRenewables(uint id, string  memory val) external onlyAdmin {
        require(id > 0 && id <= totalSupply());
        nfts[id - 1].shareOfRenewables = val;
    }
    function setTotalEnergyConsumption2(uint id, string memory totalEnergyConsumption) external onlyAdmin {
        require(id > 0 && id <= totalSupply());
        nfts[id - 1].totalEnergyConsumption2 = totalEnergyConsumption;
    }
    function setShareOfRenewables2(uint id, string memory val) external onlyAdmin {
        require(id > 0 && id <= totalSupply());
        nfts[id - 1].shareOfRenewables2 = val;
    }

    function updateNFT(uint id, string memory proof, string memory image, uint256 sensedDate, string memory totalEnergyConsumption, string memory totalEnergyConsumption2, string memory shareOfRenewables, string memory shareOfRenewables2) external  onlyAdmin {
        require(id > 0 && id <= totalSupply());
        nfts[id - 1].imageIPFS = image;
        nfts[id - 1].proofIPFS = proof;
        nfts[id - 1].sensedDate = sensedDate;
        nfts[id - 1].totalEnergyConsumption = totalEnergyConsumption;
        nfts[id - 1].totalEnergyConsumption2 = totalEnergyConsumption2;
        nfts[id - 1].shareOfRenewables = shareOfRenewables2;
        nfts[id - 1].shareOfRenewables = shareOfRenewables;
    }
    // creator fee enforce
    function setApprovalForAll(address operator, bool approved)
        public
        override(ERC721, IERC721)
        onlyAllowedOperatorApproval(operator)
    {
        super.setApprovalForAll(operator, approved);
    }
    function approve(address operator, uint256 tokenId)
        public
        override(ERC721, IERC721)
        onlyAllowedOperatorApproval(operator)
    {
        super.approve(operator, tokenId);
    }
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public override(ERC721, IERC721) onlyAllowedOperator(from) {
        super.transferFrom(from, to, tokenId);
    }
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public override(ERC721, IERC721) onlyAllowedOperator(from) {
        super.safeTransferFrom(from, to, tokenId);
    }
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes memory data
    ) public override(ERC721, IERC721) onlyAllowedOperator(from) {
        super.safeTransferFrom(from, to, tokenId, data);
    }
}