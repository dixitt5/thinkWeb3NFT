import NonFungibleToken from "../contracts/NonFungibleToken.cdc"
import NFTStore from "../contracts/NFTStore.cdc"
import FlowToken from "../contracts/FlowToken.cdc"
import NFTMarketplace from "../contracts/NFTMarketplace.cdc"

transaction(account: Address, id: UInt64) {
    prepare(acct: AuthAccount) {
        let saleCollection = getAccount(account).getCapability(/public/SaleCollection)
                        .borrow<&NFTMarketplace.SaleCollection{NFTMarketplace.SaleCollectionPublic}>()
                        ?? panic("Failed to borrow user's SaleCollection")
        let recipientCollection = getAccount(acct.address).getCapability(/public/NFTCollection) 
                        .borrow<&NFTStore.Collection{NonFungibleToken.CollectionPublic}>()
                        ?? panic("Failed to get User's collection.")
        let price = saleCollection.getPrice(id: id)
        let payment <- acct.borrow<&FlowToken.Vault>(from: /storage/flowTokenVault)!.withdraw(amount: price) as! @FlowToken.Vault
        saleCollection.purchaseNFT(id: id, recipientCollection: recipientCollection, payment: <- payment)
    }
    
    execute {
        log("Transaction executed: purchased NFT")
    }
}