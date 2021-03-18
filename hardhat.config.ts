/**
 * @type import('hardhat/config').HardhatUserConfig
 */

import { HardhatUserConfig } from "hardhat/config";
import "hardhat-deploy";
import "hardhat-deploy-ethers";
const config: HardhatUserConfig = {
  defaultNetwork: "hardhat",
  solidity: {},
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
  },
};

export default config;
