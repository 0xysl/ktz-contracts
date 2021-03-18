import { resolve } from "path";
import { config } from "dotenv";

config({ path: resolve(__dirname, "../.env") });

const func = async ({ getNamedAccounts, deployments, getChainId }: any) => {
  /**
 * 


  


 
 */

  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  console.log(getChainId);

  await deploy("KtzToken", {
    from: deployer,
    gasLimit: 4000000,
  });
};

export default func;
