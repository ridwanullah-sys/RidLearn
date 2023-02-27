const { network, getNamedAccounts } = require("hardhat")
//const { verify } = require("../utils/verify");

module.exports = async function ({ deployments }) {
    const { deploy, log } = deployments
    const { deployer } = await getNamedAccounts()

    log("-----------deploying profiler------------")
    const profiler = await deploy("Profiler", {
        from: deployer,
        args: [],
        log: true,
        waitConfirmations: network.config.blockConfirmations || 1,
    })

    log("---------deploying RLN NFT---------------------")
    const RLN = await deploy("RLNFT", {
        from: deployer,
        args: [profiler.address],
        log: true,
        waitConfirmations: network.config.blockConfirmations || 1,
    })

    log("--------------------------------")
}

module.exports.tags = ["all", "profiler", "main"]
