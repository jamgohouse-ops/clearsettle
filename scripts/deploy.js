// Importación compatible con ESM y Hardhat CommonJS
import hardhat from "hardhat";
const { ethers } = hardhat;

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying with account:", deployer.address);

  // Dirección ficticia de MNEE para local
  const fakeMNEE = deployer.address;

  const ClearSettle = await ethers.getContractFactory("ClearSettle");
  const clearSettle = await ClearSettle.deploy(fakeMNEE);

  await clearSettle.waitForDeployment();

  console.log("ClearSettle deployed to:", await clearSettle.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
