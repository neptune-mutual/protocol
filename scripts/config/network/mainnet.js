const DAYS = 86400

const config = {
  1: {
    network: 'Main Ethereum Network',
    chainId: 1,
    cover: {
      minLiquidityPeriod: 7 * DAYS,
      claimPeriod: 7 * DAYS
    },
    knownAccounts: {
      admins: null
    },
    uniswapV2Like: {
      description: 'Uniswap on Ethereum',
      addresses: {
        factory: null,
        router: null,
        masterChef: null
      }
    },
    aave: {
      description: 'Aave on Ethereum',
      addresses: {
        lendingPool: '0x398eC7346DcD622eDc5ae82352F02bE94C62d119'
      }
    }
  }
}

module.exports = config
