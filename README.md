# Democratic Proof Of Humanity

<!-- TOC -->
* [Democratic Proof Of Humanity](#democratic-proof-of-humanity)
  * [Overview](#overview)
  * [Goals](#goals)
    * [Sybil resistance](#sybil-resistance)
    * [Censorship resistance](#censorship-resistance)
    * [Sustainability](#sustainability)
    * [Credible decentralization](#credible-decentralization)
    * [Fairness](#fairness)
* [Design Proposal](#design-proposal)
  * [Registry](#registry)
    * [Web Of Trust (Needs more research)](#web-of-trust--needs-more-research-)
      * [Direct Connection](#direct-connection)
      * [Relative Connection Distance](#relative-connection-distance)
      * [Global Centrality](#global-centrality)
      * [Proof of Physical Contact](#proof-of-physical-contact)
        * [Notes](#notes)
    * [Privacy](#privacy)
    * [Notes](#notes-1)
  * [Universal Basic Income](#universal-basic-income)
    * [Overview](#overview-1)
      * [Funding Example](#funding-example)
      * [Utility & Charity Burn](#utility--charity-burn)
    * [Universal Burn Rate](#universal-burn-rate)
      * [Example](#example)
      * [Notes](#notes-2)
    * [Security Deposit](#security-deposit)
      * [PID Controller for SDF](#pid-controller-for-sdf)
      * [Example](#example-1)
      * [Notes](#notes-3)
  * [Court](#court)
      * [Challenges](#challenges)
      * [Protect against honest mistakes](#protect-against-honest-mistakes)
    * [Court](#court-1)
      * [Jury Selection](#jury-selection)
      * [Jury Delegation](#jury-delegation)
      * [Court Proceedings](#court-proceedings)
        * [Jury Privacy](#jury-privacy)
    * [Specific courts](#specific-courts)
  * [Multi-chain](#multi-chain)
<!-- TOC -->

## Overview
This document is a draft specification of a sustainable and self-contained Proof Of Humanity design on top of Ethereum blockchain.

Proof Of Humanity is a high level idea of applying blockchain technology to create a decentralized Human registry that helps people to deal with the problems surrounding Human identity on the internet. In the wake of current problems, like: A.I. bots, paid shills, organized campaigns of misinformation, media bias, it seems more critical for the internet community to develop standards that allow people to gain higher level of confidence that opinions they meet with come from sincere people, even if hidden behind pseudonymous identities.

Such system must meet multiple criteria to be considered credibly neutral, especially when it comes to governance processes, oversight of executive team and day to day decision-making (courts). Ignoring conflicts of interests, compromising on decentralization in any aspects of the protocol or not scaling it along similar trajectory as registry population is not sustainable long-term. Based on above criteria, none of the current registries seem to be sufficiently decentralized, therefore a new project is needed.

## Goals
### Sybil resistance
A [Sybil](https://en.wikipedia.org/wiki/Sybil_attack) in PoH Registry could be considered any person or other entity that violates rule of one Human -> one Entry mapping in order to gain some benefit, like:
1. Gaining monetary value from owning multiple sources of UBI.
2. Manipulating this or another DAO voting if defined by Quadratic Voting or similar approaches aimed at encouraging direct involvement more than delegated.
3. Gaining an increased influence over Social Media integrating with the PoH Registry by manipulating its members opinions by normalizing certain viewpoints.
4. Benefiting in another way from the Registry destruction or simply trolling / griefing it.

Common types of Sybils, include:
1. Duplicate - multiple submissions of the same person pretending to be different people. The easiest one to discover due to wide availability of face-recognition software.
2. Fake - A.I. Deep-Fakes. It's possible to Deep-Fake external Evidence, like a photo or a video with made-up faces.
3. Puppet - it's also possible to bribe or force some real people to record a video on behalf of an Attacker. We must ensure to keep Applicants well-informed about benefits of PoH and UBI.

In order for the registry to be viable, it must have builtin protections from such actors that will make these attacks expensive, slow and economically unfeasible to pull off at large scale and in longer time-frame. The system should penalize Sybils and their Vouchers disproportionately more than benefits they could potentially gain. It should also account for the fact, that good fake detection software may not be available for some time even after the registration, therefore any security deposit should be permanent bounty.

### Censorship resistance
Any living Human has a right to register. No ethnic, citizenship, religious, political, medical socioeconomic status or any other categorization should be any ground to deny access to the service. The system design should aim for long-term decentralization of all powers (governance, court system).

### Sustainability
Ensure that the protocol will maintain its core properties even after many years through proper incentive mechanisms.

### Credible decentralization
Open Source all software and facilitate multiple frontends. Ensure decentralizing structure of all aspects of the registry along population trajectory, meaning that no single centralized entity or external DAO has permanent control over any aspect of the system.

### Fairness
All rules make every participant equal and UBI distribution is even for all registered humans and may vary up to 50% between participants, depending on other transparently defined incentives targeting security (WOT). No organization has ability to print UBI or force taxation to benefit it. All protocol properties, like: income, fees, burn rate and required deposit sizing apply equally to everyone.

# Design Proposal
Most points assume some prior knowledge of proofofhumanity.org specification. This document focuses primarily on important differences with previous implementation and harmonization of PoH Registry, UBI and Court subsystems.

## Registry
The Registry is the main purpose of PoH. Every person may join and manage its associated entry and records. The registry is built on ethereum L1, but allows entry from cheap L2s, which then synchronize back to L1, making it the single source of truth.

### Web Of Trust (Needs more research)
Previous implementation of PoH did not utilize any advanced Web Of Trust mechanics other than a single Vouch.

WoT purpose is to enable better protection measures from Sybils that would attempt to infiltrate social network by reducing its "connectiveness". An obvious example of it impersonating Twitter account with lots of followers (all bots). Absolute number of followers is meaningless and easy to fake in this context, because none of these bot accounts are connected to you in any significant way.

On top of current mechanics, we may add increased flow of UBI to incentive people to Link for distant (in graph theoretical terms) relationships. Let's say that linking requires committing additional deposit due to impact on the network, but at the same time, it increases UBI rate very slightly and up to a certain limit, e.g. people with no connections receive 1 UBI/h, but people with a significant network, receive even up to 2 UBI/h. Clustering connections within family members gives significantly smaller boost than connecting with coworkers or someone you've randomly met at an airport, because such "clustering" connection doesn't bring other people in the network any closer.

#### Direct Connection
Mutually confirmed relationship rooted in real world (Vouch-like). In Graph terms it's an Edge between People who both openly confirm that they know each other.

It's also worth ensuring that if a connection is one-sided (follower), then a person targeted still gets the benefits of connectivity, but the follower doesn't. This is useful to prop-up local politicians or celebrities, etc. within your local network.

#### Relative Connection Distance
Any pair of people has a distance assigned between them, which tells us what's the distance of the shortest path in 
Social Graph between them. Distance between you and a person you're directly connected with is exactly 1. Distance between you and any other person is the smallest Distance to that person from any person directly connected to you plus 1. Special value +Infinity applies to completely disconnected people, which should be rare.

Additional useful metric to point connection rank "Connection Strength": how many direct connections (links) would need to break in order for Connection Distance between these 2 people to increase. Let's use notation `(Distance, Strength)`. If Alice and Bob connection is `(2, 5)`. It means they have 5 common friends and should probably hang out. At the same time, `(2, 1)` could be a fluke or an attempt at social engineering and should be considered weaker than `(3, 20)`. Other scoring metric can be used as well to simplify above findings.

Social Distance between each pair of people varies over time as people join and connect, and it should include last recalculated timestamp/block to let people see if that information isn't stale.


#### Global Centrality
May be useful for calculating rewards for connecting people or global confidence scoring.
Explore options https://en.wikipedia.org/wiki/Centrality . Incentivising connectiveness allows for better security scoring thanks to high number of redundant connections.

#### Proof of Physical Contact
It is possible to prove Physical contact with a variant of intertwining [Proof Of History](https://tokens-economy.gitbook.io/consensus/chain-based-proof-of-capacity-space/proof-of-history) method to prove low latency (e.g. <2ms or <5ms) between two wallet holders with NFC/Bluetooth technology. Example:
1. Initiator looks up at the tip of the blockchain and hashes message: `"PoH Connect 0x1 with 0x2 on block: " + start_block`. Instead of using Signer and Wallet application directly, which may require confirmation on every exchange, one can deterministically and provably derive a new one-time private key based on message and signature.
2. Sequentially exchange signed hash of peer message and recursive ZK-Proof back and forth thousands of times for ~5-10 seconds. Parameters depend on block time, link throughput, Hashing, Signing and ZK Proving compute overhead and allowed latency error.
3. Calculate average exchange time and submit transaction with public parameters and proof on the blockchain for 
   contract to verify it. Since it's a time-sensitive transaction, Proof of Humanity application should use high gas limit.

Proof generation may take some time, which could potentially render latency irrelevant. Instead of running everything at once, it's possible to make the operation of establishing Connection 2-phase.
1. Run the procedure with proving disabled, submitting last hash as commitment in timely manner (should take <10s for 2000 exchanges).
2. Re-run the same exchange with proving enabled. Once the proof is generated, send it on-chain.

##### Notes
Unless there is hardware acceleration, proof generation may be too slow to be tolerable even in 2-step process.

This method is only practical on cheap and fast L2/L3 with block time ~1s-2s. In order to verify L1 (12s block time), we'd need a much higher block inclusion tolerance, so the exchange would need to run for 1 minute or more.

It's still possible to cheat by uploading wallet to a datacenter specific region and zone.


### Privacy
Private profile can create following attestations / badges:
- I'm a verified human and I haven't created another pseudonymous profile for this site (semaphore, Sismo badge).
- I'm within immediate social circle of this person. Verifiable whistleblower.
- I'm closer than distance 3 to 80% of people registered on this forum. Honest opinion, whistle blowing.

Base PoH doesn't need to provide these features from the start, but the DAO should facilitate and encourage standards.

### Notes
PoH V1 model doesn't incentivize extensive graph building, because most people only care about single vouch.

Granting additional UBI for maintaining connections may come up as unfair, but if videos aren't enough (A.I. generation improves), it may become required for the system to rely on additional information, like graph analysis and global confidence scoring to properly secure it. Instead of assigning binary flag: Human / Non-Human, attempt to express confidence in Humanity as probability or estimated cost of attack and automatically resize UBI stream based on that scoring.

Calculating Web Of Trust matrix requires significant amount of off-chain computation. Final on-chain results or subset of them may need to be provided with ZK proof.

We can't really verify that people know each other, unless they both provide transparent and verifiable proof that they know each other. We should not attempt to verify each connection transparently. A successful Sybil would not only need to create fake profile, but get connected with sufficiently dispersed groups of people in order to be plausible globally. In case, a Sybil is detected, each Connection is not only slashed, but also barred for some time (a year?) from creating new Connections, so any bribery attacks would be very costly. This system may be overlayed by other social networks, but since these allow non-humans or operate on Follower (IG, Twitter) basis than Connection, it seems there is some composable vacuum to be filled.

In addition to scoring confidence in another person being Human, a Relative Connection Distance / Strength scoring may be a very useful tool for ranking relevancy of another Person in various social contexts.


## Universal Basic Income
### Overview
In short UBI - it is a main token of the PoH Registry used to drive its incentive mechanisms. Its goal is to secure the Registry in form of required deposit and provide opportunity of fairly distributed wealth transfer.

Every registered Human receives approximately 1 UBI per hour. Depending on market situation, some of it may be committed to Security Deposit and the remaining Surplus is left with receiver who may use it freely: create substream to stream to a person / organization of choice, transfer it, sell it or burn it.

UBI is required to fund Deposit of new Humans in the registry, which allows it to act as a rate-limiter for new registrations. Having a UBI-based deposit is also beneficial for people who are anxious about risks of depositing harder assets, like ETH or stablecoins into unknown contracts just to register. Since UBI is tightly connected to PoH, the risk is removed, because if PoH was a scam, UBI that is printed by it would turn out to be worthless anyway.

All operations on the registry, like updating own records (name, bio, other text records), requires some UBI to be burned (destroyed), which also adds additional friction to any spam attempts. This is especially important in L2 environments, where gas is cheap.

#### Funding Example
![](docs/images/Funding%20Registry%20with%20UBI%201.png)

Alice is registered in PoH system, and she has accrued 1500 units of spendable UBI.

![](docs/images/Funding%20Registry%20with%20UBI%202.png)

1. Alice decides to Vouch and Fund Bob, because he is her close friend. Since UBI she got was free anyway, she doesn't experience any meaningful sense of loss.
2. After Bob gets accepted into the Registry, he starts accruing UBI at the same rate as Alice. He decides, he wants to onboard his friend Charlie, but he hasn't yet accrued spendable amount of UBI to cover Charlies deposit. Charlie doesn't want to wait a month for Bob to accrue UBI.
3. Charlie decides to buy it off the free market for DAI; and
4. Begin registration process immediately.

#### Utility & Charity Burn
UBIs value doesn't come from nothing. At first, it's measured in utility of getting into the registry. Many people may be willing to buy UBI in order to self-fund their application. Once the registry gets sizeable, it should be relatively easy to influence businesses, like marketplaces, to self-tax and stream small portion of profits back to Humanity by simply passing it to smart contract, like UBI Burner that smooths buying into UBI and burns it.

POH DAO or another related organization could promote UBI-friendly initiatives, like:
1. Marketplaces that pass e.g. % of sales fees to UBI Burner
2. Artists, who commit % of their revenue from their art to UBI Burner
3. Many european countries allow passing 1% of their income tax to charity organization of choice. Non-profits registered there, could convert this 1% of fiat to stables and pass it directly to UBI Burner.
4. Award individual burners with collectibles, POAPs, etc
5. Allow committing UBI Substream to burn income immediately or direct it to the PoH DAO.

### Universal Burn Rate
UBI is only increasing with time and Humans registered in the Registry, which makes it a highly inflationary token. In case utility and charity burn don't exceed supply increase, we have a system that spirals down in security and UBI-price.

In order to combat this and to protect value coming from it to people who need it promptly, we need to introduce some mechanism that will limit hoarding. One such idea could be per-person limit, but because everyone is free to transfer their tokens to another address or lock them in a liquidity pool, we need a more universal approach of limiting Total Supply of UBI tokens.

Universal Burn Rate or UBR is similar to "Negative Interest Rates" known from [traditional Central Banking](https://www.ecb.europa.eu/ecb/educational/explainers/tell-me-more/html/why-negative-interest-rate.en.html) or [decentralized collateralized stablecoin design](https://dankradfeist.de/ethereum/2021/09/27/stablecoins-supply-demand.html). Unlike examples above, UBI isn't a loan in either direction, therefore calling it "Negative Interest Rates" would be misleading, so we need more precise and intuitive terminology. Alternative name could be "Negative Savings Rate".

While on every block people accrue small amount of UBI, a small portion of all their UBI holdings is being burned at the same time. This means that at some point, unattended Total Balance should stabilize around equlibrium value. Following formula allows calculating per person Max Total Accrual pretty accurately:
```
import math

def max_total_accrual(ubr: float) -> float:
    return 1.0/(1.0-math.pow(1.0-ubr, 1.0/(365*24)))
```

#### Example
Alice has saved up 10k UBI (>1 year worth). We don't want to consider new UBI inflow (1 UBI/h), so let's assume that Alice transfers 10_000 UBI to a different wallet not used in registration. After a year, she only has 7_500 UBI on this wallet and a year later, only ~5_600 and so on. Note that she is still accruing it on her main account with rate 1 UBI/h, so while she has lost 2_500 UBI during that year, she has still gained almost 8_700 UBI of new UBI in her main wallet.

How would the situation look like, if she has saved up 30 000 UBI, instead of 10 000 UBI? It turns out, she'd be close to net-zero, because at a constant rate of +1 UBI/h she'd be losing a similar amount in her account due to Universal Burn. That would basically stabilize her savings at max ~3.5 years of UBI, including locked Deposit.

#### Notes
Main reason for Negative Rates existence is incentivizing "shorting" (betting against) the currency when it's worth more than its target value, either expressed in $, CPI or other indicator. Having a constant Burn rate of UBI incentives selling it as soon as it is received, which may cause additional selling pressure, since savers are aware that it's more profitable to sell it every day or week (assuming cheap gas on L2s), rather than holding it for long. This is something we have to accept, otherwise we're faced with an infinite growth of average per-person supply.

This is not so different if compared to debasing currencies, like USD, which from 2010 to 2022 debased on average ~9% yearly (and ~7% before 2020-2021 Quantitative Easing). In UBI, since there is no physical cash, and it's all "electronic money" and with it there is no need to freeze numerical value of any note - we have the flexibility of being more straightforward and rebase it instead of debasing, thus allowing maintaining similar purchasing power of a single UBI token even after 50 years of operating the system, where each country with fiat currency must periodically increase minimum wage, social benefits, etc. in numerical terms.

### Security Deposit
A mandatory portion of UBI balance is always locked as Security Deposit to ensure proper incentives - bounties, court fees, fines, etc. Security Deposit size aims to target governance set value, e.g. $50 with some bounds, e.g. minimum of 720UBI (1 month) and maximum value dependent on UBR value, which should be close to maximum of organic accrual, e.g. `~3.5y` for `UBR = 25%`.

#### PID Controller for SDF
Since price of UBI is dynamic, and we'd like to keep the security of UBI tied to global economy, we're targeting Deposit worth in USD. The amount of UBI locked in Security Deposit is automatically being adjusted and is continuously affected by its own Security Deposit Flow rate - `SDF`, which may take any value between `[-1:1]`. The remainder of Total Balance is called Surplus or Spendable Balance, which may be used by its owner as a form of currency, to fund other people Security Deposits, trade, yield farm, save, etc.

In case of a sudden price drop, Security Deposit may grow even at a rate of `1 UBI/h`, which means that all the newly accrued UBI is being forcefully committed to Security Deposit instead of Surplus Balance. Hopefully, `SDF = 1 UBI/h` is an extreme scenario - PID Controller should increase flow slowly over weeks or months and give early warning signal to activists or other people willing to support the cause to gather resources and fund UBI. At the same time, frequent spenders have limited capacity to flood the market with new UBI due to lower Surplus accrual rate, which should definitely lower the overall selling pressure over time.

#### Example
This example shows three scenarios and visual explanations of Flows and SDF PID Controller.

![](docs/images/Security%20Deposit%20PID%20Controller.png)

#### Notes
It's possible that due to lack of charity and utility buing pressure, the registry will basically grind to a halt and stop any growth.

We shouldn't be worried about UBI value at first. If the registry is successful, there will be high demand for UBI in order to fund new peoples deposits. This "growth phase" may take many years. After the growth phase ends, high deposit expressed in UBI-time is justifiable, because, assuming the registry success, the only new people joining will be children of people already present there.

Due to Dynamic nature of Security Deposit flow current, it's not possible to predict if it won't overlap with totality of UBI Substreams. Because it's not possible to efficiently readjust or freeze batches of Substreams, we'll need to create condition where subflows are respected and Security Deposit is filled from Surplus. Violation of Security Deposit balance allows bots to freeze all Substreams automatically and receive a small reward (e.g. 1/12 Deposit).

## Court
Court is a mechanism allowing to resolve conflicts in the registry using random quorum of juries. It mainly evaluates evidence provided by Seekers who aim at disrupting

#### Challenges
We should come up with variety of challenges that could make certain Sybils less likely to be successful. An example, could be:

Seekers should be able to challenge Puppets to record updated video with Time Proof (recent eth block hash). This should eliminate cases where Puppets are recruited en-masse on the street.

Suspected Fakes can be requested to record a video under conditions that usually confuse Deep Fake algorithms, take multiple angles, record live session (requires time coordination) with juries, etc.

These challenges should have cool downs, like 6 months and consecutive prosecution failures should increase required amount of time between challenges exponentially with some limit, like up to 4 years.

#### Protect against honest mistakes
A different approach should be considered when dealing with minor issues. Unless the application isn't fully inadmissible (griefing cases), minor issues, like mistake in spoken phrase or poor quality of video / audio, partially hidden face details, etc. should be resolvable pre-trial with a guarantee of a tip.

If a Seeker finds an issue with application, they may decide to open a challenge the same way as usual and select specific type of issue. Applicant may then choose to either agree with it or not. If the challenge is not acknowledged, it is directed to a court and Applicant may lose full amount of their deposit and get removed. On the other hand, if the person agrees with the challenge, a 10% tip is secured on behalf of the challenger and Applicant may re-upload their Submission. The challenger may then Accept new submission or not. If the challenger accepts it as resolved, normal registration process is resumed. Otherwise, it ends up in Court. It may take multiple rounds of pre-trial corrections before all issues are resolved.

Once the person successfully registers, all tips are redistributed from Applicants deposit to Seekers who found them. In those cases, it may take some time before Applicant starts accruing any spendable UBI, because the Deposit needs to be refilled first, and it always takes priority.

### Court
#### Jury Selection
Every registrant becomes a Jury be default, similarly to how post-revolutionary French and American courts function. Their UBI Deposit acts as stake in court. Since all court activity will be present on L2s, there should be no problem of having courts consisting of multiple people, i.e. 5 or more juries.

When issue is created, more than needed (2x?) random juries are called for "jury duty". In case, some of them don't respond, they're penalized and the court is selected from people who responded to jury-duty. Non-responders are penalized by having some of their Deposit slashed (1/3?). If no sufficient group has gathered, repeat random sampling.

#### Jury Delegation
It's possible for some juries to specialize and mark themselves as Court Delegates and specify delegation fee as %. People who prefer not to participate in court directly may choose to opt out and point their stake at a Delegate, whose weight in the system is increased quadratically. Each Delegate then splits the received rewards to himself (fee) and among people who delegate to him. Penalty only affects Delegate, but no income or poor performance means Delegators may choose to replace them.

Note that, large Delegates become less profitable with increased number of delegators, because with QF, having 100 vs 121 delegators increases chances of being picked as Jury only by 10%.

#### Court Proceedings
After court juries are selected, they are checking the evidence and discuss the issue. Only Applicant, Juries, Seekers (prosecutors) and people who contributed to a Defence Deposit have a right to discuss the matter.

Optional Defendant, who stakes equivalent in UBI and then splits profits with the Applicant should be allowed to speak as well.

Appeals are possible by exponentially increasing stake on both sides and number of juries, which should serve as a good anti-corruption mechanism.

##### Jury Privacy
It may be a good idea to allow hiding jury identity, except Delegates, in order to have some protection from selling votes, collusion or threats. Many such schemes are being developed, so we should definitely look into that.

### Specific courts
Once there is a significant group (10k+?), we should be able to create language-specific filters to allow registering people who do not speak english or spanish. People who declare proficiency in given language should prove it.

## Multi-chain
We should ensure that there is a single source - ethereum L1 seems like a good bet. Other chains, specifically L2s can run their own contracts, but should be orchestrated from Main Registry on L1 and push registrants originating in L2s back to L1. This way, mainnet can still set UBI parameters, like target deposit, oracles, etc. in single place and not spread it across multiple chains.

It also makes easier migrations of registrants in bulk in case there is an issue with L2 without need to re-register.

It's also better to have a single source of truth and not-conflicting separate domains. PoHv2 is built for multi-domain PoH, which isn't hierarchical.

TODO: complete