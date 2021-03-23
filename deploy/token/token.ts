import hre from "hardhat";

const deployToken = async ({ getNamedAccounts, deployments }: any) => {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  console.log(deployer);

  const token = await deploy("KtzToken", {
    from: deployer,
    gasLimit: 4000000,
  });

  await hre.run("verify:verify", {
    address: token.address,
    constructorArguments: [],
  });

  console.log(
    "Token successfully deployed at address: ",
    token.address,
    "\n",
    "Token successfully verified in blockchain explorer."
  );

  return token;
};

export default deployToken;
