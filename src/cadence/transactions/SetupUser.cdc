import NonFungibleToken from "../contracts/NonFungibleToken.cdc"
import NFTStore from "../contracts/NFTStore.cdc"
import FungibleToken from "../contracts/FungibleToken.cdc"
import FlowToken from "../contracts/FlowToken.cdc"
import NFTMarketplace from "../contracts/NFTMarketplace.cdc"

transaction {
    prepare(acct: AuthAccount) {
        // Set up collection
        acct.save(<- NFTStore.createEmptyCollection(), to: /storage/NFTCollection)
        acct.link<&NFTStore.Collection{NFTStore.CollectionPublic, NonFungibleToken.CollectionPublic}>(/public/NFTCollection, target: /storage/NFTCollection)
        acct.link<&NFTStore.Collection>(/private/NFTCollection, target: /storage/NFTCollection)

        // Set up sale collection
        let collection = acct.getCapability<&NFTStore.Collection>(/private/NFTCollection)
        let vault = acct.getCapability<&FlowToken.Vault{FungibleToken.Receiver}>(/public/flowTokenReceiver)
        acct.save(<- NFTMarketplace.createSaleCollection(OwnerNFTCollection: collection, FlowTokenVault: vault), to: /storage/SaleCollection)
        acct.link<&NFTMarketplace.SaleCollection{NFTMarketplace.SaleCollectionPublic}>(/public/SaleCollection, target: /storage/SaleCollection)
    }

    execute {
        log("Transaction executed: collection and sale collection has been set up for user account")
    }
}