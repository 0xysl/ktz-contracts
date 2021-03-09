import { HardhatNetworkHDAccountsUserConfig } from "hardhat/types";
import "dotenv";

const deployer: HardhatNetworkHDAccountsUserConfig = {
  mnemonic: process.env.DEPLOYER_MNEMONIC,
};

export { deployer as deployerAccount };
