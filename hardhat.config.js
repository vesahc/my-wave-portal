require("@nomiclabs/hardhat-waffle");

module.exports = {
  solidity: "0.8.4",
  networks: {
    rinkeby: {
      url: 'https://eth-rinkeby.alchemyapi.io/v2/LcNspucsomrjEhPp2XAjdvrmXWLM1gOV',
      accounts: ["0x14f8a3d3255a44a24102455207012ca45ef537b226a4783032f3f033b566da97"]
    },
  },
};
