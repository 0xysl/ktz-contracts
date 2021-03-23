import deployToken from "./token/token";

const func = async ({ getNamedAccounts, deployments, getChainId }: any) => {
  const token = await deployToken({ getNamedAccounts, deployments });
};

export default func;
