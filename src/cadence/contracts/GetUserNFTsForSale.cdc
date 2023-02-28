import NonFungibleToken from "./NonFungibleToken.cdc"
import NFTStore from "./NFTStore.cdc"
import NFTMarketplace from "./NFTMarketplace.cdc"

pub fun main(account: Address): {UInt64: NFTMarketplace.SaleItem} {
  let saleCollection = getAccount(account).getCapability(/public/SaleCollection)
                        .borrow<&NFTMarketplace.SaleCollection{NFTMarketplace.SaleCollectionPublic}>()
                        ?? panic("Failed to borrow user's SaleCollection")
  let collection = getAccount(account).getCapability(/public/NFTCollection) 
                    .borrow<&NFTStore.Collection{NonFungibleToken.CollectionPublic, NFTStore.CollectionPublic}>()
                    ?? panic("Failed to get user's collection.")
  let saleIDs = saleCollection.getIDs()
  let ownedIDs = collection.getIDs()
  let res: {UInt64: NFTMarketplace.SaleItem} = {}
  for saleID in saleIDs {
    if ownedIDs.contains(saleID) {
      let price = saleCollection.getPrice(id: saleID)
      let nftRef = collection.borrowEntireNFT(id: saleID)
      res.insert(key: nftRef.id, NFTMarketplace.SaleItem(price: price, nftRef: nftRef))
    }
  }
  return res
}

// const IS_INITIALIZED = `
// import Domains from 0xDomains
// import NonFungibleToken from 0xNonFungibleToken

// pub fun main(account: Address): Bool {
//     let capability = getAccount(account).getCapability<&Domains.Collection{NonFungibleToken.CollectionPublic, Domains.CollectionPublic}>(Domains.DomainsPublicPath)
//     return capability.check()
// }
// `;