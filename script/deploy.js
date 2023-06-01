
const hre = require("hardhat");

async function main() {
  
  const WEB3=await hre.ethers.getContractFactory("web3");
  const web3=await WEB3.deploy();
  await web3.deployed();
  console.log("web3 deployed to:",web3.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
