import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";

const func: DeployFunction = async ({
  getUnnamedAccounts,
  getNamedAccounts,
  deployments,
  getChainId,
  ethers,
}: HardhatRuntimeEnvironment) => {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  console.log("---------------");
  const accounts = await getUnnamedAccounts();

  const { deploy } = deployments;

  await deploy("Greeter", {
    from: accounts[0],
    gasLimit: 4000000,
    args: [],
    log: true,
  });
};

export default func;
