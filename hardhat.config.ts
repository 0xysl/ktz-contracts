import { HardhatUserConfig } from "hardhat/config";
import "@nomiclabs/hardhat-waffle";
import "@nomiclabs/hardhat-ethers";
import "@nomiclabs/hardhat-etherscan";
import "hardhat-deploy-ethers";
import "hardhat-deploy";
import "./deploy/env";
import "dotenv/config";
import { deployerAccount } from "./utils/accounts";

const { DEPLOYER_PRIVATE_KEY, BSCSCAN_API_KEY } = process.env;

const accounts = {
  deployer: {
    default: 0,
    "*": `0x${DEPLOYER_PRIVATE_KEY}`,
  },
  feeCollector: {
    default: 1,
    31337: "0xa5610E1f289DbDe94F3428A9df22E8B518f65751",
  },
};

const testnet = {
  url: "https://data-seed-prebsc-1-s1.binance.org:8545",
  chainId: 97,
  accounts: [`0x${DEPLOYER_PRIVATE_KEY}`],
  timeout: 10000,
} as any;

const config: HardhatUserConfig = {
  paths: {
    deploy: "./deploy",
    deployments: "./deployments",
    artifacts: "./artifacts",
  },
  namedAccounts: {
    deployer: 0,
    peer: 1,
  },
  solidity: {
    compilers: [
      {
        version: "0.8.2",
      },
      {
        version: "0.7.0",
      },
      {
        version: "0.6.0",
      },
    ],
  },
  networks: {
    hardhat: {
      loggingEnabled: true,
      saveDeployments: true,
      forking: {
        url: "https://bsc-dataseed.binance.org/",
      },
      accounts: deployerAccount,
    },
  },
  etherscan: {
    apiKey: BSCSCAN_API_KEY,
  },
};

module.exports = config;
