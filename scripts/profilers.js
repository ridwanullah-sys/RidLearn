const { ethers } = require("hardhat")

const main = async () => {
    const { deployer } = await getNamedAccounts()
    const profiler = await ethers.getContract("Profiler", deployer)
    const RLNFT = await ethers.getContract("RLNFT", deployer)

    const provider = waffle.provider
    const ETHBalanceBeforeEmmition = await provider.getBalance(deployer)

    const tx = await profiler.addInstructor(
        "Ridwan",
        "programmer",
        "i deyCode ANyfn",
        ["facebook", "whatsapp"],
        "www.jdkdkdk.com",
        RLNFT.address
    )
    await tx.wait()
    const txreceipt = await RLNFT.tokenURI(3)

    console.log(txreceipt.toString())

    const ETHBalanceAfterEmmition = await provider.getBalance(deployer)
    console.log(ETHBalanceAfterEmmition - ETHBalanceBeforeEmmition)
}
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
    })
