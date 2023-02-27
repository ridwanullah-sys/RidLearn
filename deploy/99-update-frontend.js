const { ethers, network } = require("hardhat")
const fs = require("fs")

const profilerABI = "../client/constants/profilerABI.json"
const RLNFTABI = "../client/constants/RLNFTABI.json"
const frontendAddress = "../client/constants/Addresses.json"

module.exports = async function (params) {
    if ([process.env.UPDATE_FRONT_END]) {
        console.log("updating....")
        await updateFrontEnd()
    }
}

async function updateFrontEnd() {
    const profiler = await ethers.getContract("Profiler")
    const RLNFT = await ethers.getContract("RLNFT")
    fs.writeFileSync(profilerABI, profiler.interface.format(ethers.utils.FormatTypes.json))
    fs.writeFileSync(RLNFTABI, RLNFT.interface.format(ethers.utils.FormatTypes.json))
    const Address = JSON.parse(fs.readFileSync(frontendAddress, "utf8"))
    Address["profiler_Address"] = profiler.address
    Address["RLNFT_Address"] = RLNFT.address
    fs.writeFileSync(frontendAddress, JSON.stringify(Address))
}

module.exports.tags = ["all", "frontend"]
