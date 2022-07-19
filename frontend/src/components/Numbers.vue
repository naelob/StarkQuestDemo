<script setup>
import { onMounted, ref } from 'vue'
import { connect } from '@argent/get-starknet'
import {} from '@argent/get-starknet'
import ContractInterface from '../contracts/secretNumber.json'
let starknet = null
// Let the user pick a wallet (on button click)
// const starknet = connect()
// or try to connect to an approved wallet silently (on mount probably)
// const starknet = connect({ showList: false })
defineProps({
  msg: String,
})

const walletConnected = ref(false)
const savedReputation = ref(0)
const toIncrease = ref(0)
const toDecrease = ref(0)
const ethPrice = ref(0)
const bnbPrice = ref(0)
const maticPrice = ref(0)
const solPrice = ref(0)

const USER_CONTRACT_ADDRESS = 
  '0x0078f995c4e3b47c2c082c0b206dfbdd31b24514186189a8587b032893e836c5'
const ORACLE_CONTRACT_ADDRESS = 
"0x04e5350a29abd2455ff4f4ab54b96ff85f036eb892e6b8102eaef51426dae1f7"

const increaseReputation = async () => {
  try {
    const trxDetails = await starknet.account.execute(
      {
        contractAddress: USER_CONTRACT_ADDRESS,
        entrypoint: 'increase_reputation',
        calldata: [toIncrease.value],
      }

    )
    console.log('trxDetails', trxDetails)
    await getReputationScore();
  } catch (error) {
    console.error(error)
  }
}
const decreaseReputation = async () => {
  try {
    const trxDetails = await starknet.account.execute(
      {
        contractAddress: USER_CONTRACT_ADDRESS,
        entrypoint: 'decrease_reputation',
        calldata: [toDecrease.value],
      }
    )
    console.log('trxDetails', trxDetails)
    await getReputationScore();
  } catch (error) {
    console.error(error)
  }
}
const getEthPrice = async () => {
  try {
    const res = await starknet.provider.callContract(
      {
        contractAddress: ORACLE_CONTRACT_ADDRESS,
        entrypoint: 'get_eth',
      }
    )
    ethPrice.value = Number(`${res.result[0]}`) / Number(10**18)

  } catch (error) {
    console.error(error)
  }
}
const getBnbPrice = async () => {
  try {
    const res = await starknet.provider.callContract(
      {
        contractAddress: ORACLE_CONTRACT_ADDRESS,
        entrypoint: 'get_bnb',
      }
    )
    bnbPrice.value = Number(`${res.result[0]}`) / Number(10**18)

  } catch (error) {
    console.error(error)
  }
}
const getMaticPrice = async () => {
  try {
    const res = await starknet.provider.callContract(
      {
        contractAddress: ORACLE_CONTRACT_ADDRESS,
        entrypoint: 'get_matic',
      }
    )
    maticPrice.value = Number(`${res.result[0]}`) / Number(10**18)

  } catch (error) {
    console.error(error)
  }
}
const getSolanaPrice = async () => {
  try {
    const res = await starknet.provider.callContract(
      {
        contractAddress: ORACLE_CONTRACT_ADDRESS,
        entrypoint: 'get_sol',
      }
    )
    solPrice.value = Number(`${res.result[0]}`) / Number(10**18)

  } catch (error) {
    console.error(error)
  }
}
const hexToDecimal = hex => parseInt(hex, 16);

const getReputationScore = async () => {
  try {
    const res = await starknet.provider.callContract(
      {
        contractAddress: USER_CONTRACT_ADDRESS,
        entrypoint: 'get_reputation_score',
        calldata: ["3483267860424498572784476647572533100336474322486193658764786385985433822416"]
      }
    )
    savedReputation.value = Number(`${res.result[0]}`)

  } catch (error) {
    console.error(error)
  }
}
const connectWallet = async () => {
  starknet = await connect()
  console.log('startknet >>', starknet)
  if (!starknet) {
    throw Error(
      'User rejected wallet selection or silent connect found nothing'
    )
  }
  // (optional) connect the wallet
  await starknet.enable()
  // Check if connection was successful
  if (starknet.isConnected) {
    console.log('starknet connected')
    walletConnected.value = true
    // If the extension was installed and successfully connected, you have access to a starknet.js Signer object to do all kinds of requests through the user's wallet contract.
    // starknet.account.execute({  })
    await getEthPrice()
    await getBnbPrice()
    await getMaticPrice()
    await getSolanaPrice()
    await getReputationScore()
  } else {
    console.log('starknet wallet not connected')
    // In case the extension wasn't successfully connected you still have access to a starknet.js Provider to read starknet states and sent anonymous transactions
    // starknet.provider.callContract( ... )
  }
}

</script>

<template>
  <li type="button" @click="connectWallet" v-if="!walletConnected"><a><i class="far fa-edit"></i>  Connect wallet</a></li>
  <div class="" v-else>
    Wallet connected
    <ul>
      <li> eth price : {{ethPrice}} </li>
      <li> bnb price : {{bnbPrice}} </li>
      <li> solana price : {{solPrice}} </li>
      <li> matic price : {{maticPrice}} </li>
    </ul>
    <input v-model="text" placeholder="enter the number">
    <button @click="increaseReputation"> Increase Reputation</button>
    
    <input v-model="text" placeholder="enter the number">
    <button @click="decreaseReputation"> Decrease Reputation</button>

  </div>
</template>
