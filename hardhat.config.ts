/**
 * @type import('hardhat/config').HardhatUserConfig
 */

import { HardhatUserConfig } from "hardhat/config";
import "hardhat-deploy";
import "hardhat-deploy-ethers";
import "@nomiclabs/hardhat-etherscan";
import { resolve } from "path";
import { config as envConfig } from "dotenv";
envConfig({ path: resolve(__dirname, ".env") });

// console.log(process.env.DEPLOYER_PRIVATE_KEY);

const apiKey = process.env.BSCSCAN_API_KEY;

const testnet = {
  url: "https://data-seed-prebsc-1-s1.binance.org:8545",
  accounts: [`0x${process.env.DEPLOYER_PRIVATE_KEY}`],
  chainId: 97,
  timeout: 10000,
} as any;

const config: HardhatUserConfig = {
  defaultNetwork: "hardhat",
  solidity: "0.8.2",
  namedAccounts: {
    deployer: {
      default: 0,
    },
  },
  paths: {
    deploy: "deploy",
    sources: "src",
  },
  networks: {
    hardhat: {
      forking: {
        url: "https://bsc-dataseed.binance.org/",
      },
      loggingEnabled: true,
      accounts: [
        {
          privateKey:
            "f5bebf7133e52cad8942cff8c0547e81f9e3239820a3dfed1a857cefd841d9f1",
          balance: "10000000000000000000000",
        },
      ],
    },
    testnet,
  },
  etherscan: {
    apiKey,
  },
};

export default config;
