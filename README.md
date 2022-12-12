# Democratic Proof Of Humanity

## Overview
This document is a draft specification of a sustainable and self-contained Proof Of Humanity design on top of Ethereum blockchain.

Proof Of Humanity is a high level idea of applying blockchain technology to create a decentralized Human registry that helps people to deal with the problems surrounding Human identity on the internet. In the wake of current problems, like: A.I. bots, paid shills, organized campaigns of misinformation, media bias, it seems more critical for the internet community to develop standards that allow people to gain higher level of confidence that opinions they meet with come from sincere people, even if hidden behind pseudonymous identities.

Such system must meet multiple criteria to be considered credibly neutral, especially when it comes to governance processes, oversight of executive team and day to day decision-making (courts). Ignoring conflicts of interests, compromising on decentralization in any aspects of the protocol or not scaling it along similar trajectory as registry population is not sustainable long-term. Based on above criteria, none of the current registries seem to be sufficiently decentralized, therefore a new project is needed.

## Goals
### Sybil resistance
Provide incentives that result in registry that is free from Sybil attacks. Any registered Human needs to provide Proof of Humanity, which is subject to scrutiny by economically incentivized Seekers.

### Censorship resistance
Any living Human has a right to register. No ethnic, citizenship, religious, political, medical socioeconomic status or any other categorization should be any ground to deny access to the service.

### Sustainability
Ensure that the protocol will maintain its core properties even after many years through proper incentive mechanisms.

### Credible decentralization
Open Source all software and facilitate multiple frontends. Ensure decentralizing structure of all aspects of the registry along population trajectory, meaning that no single centralized entity or external DAO has permanent control over any aspect of the system.

### Fairness
All rules make every participant equal and UBI distribution is even for all registered humans and may vary up to 50% (we might decrease it or remove it) between participants, depending on other transparently defined incentives targeting security (WOT). No organization has ability to print UBI or force taxation to benefit it. Fees, Burn and required Deposits mechanisms apply equally to everyone.

# Design Proposal
Most points assume some prior knowledge of proofofhumanity.org specification. This document focuses primarily on important differences with previous implementation and harmonization of PoH Registry, UBI and Court subsystems.

## Registry
The Registry is the main purpose of PoH. Every person may join and manage its associated entry and records. The registry is built on ethereum L1, but allows entry from cheap L2s, which then synchronize back to L1, making it the single source of truth.

## UBI
### Universal Basic Income
In short UBI - it is a main token of the PoH Registry used to drive its incentive mechanisms. Its goal is to secure the Registry in form of required deposit and provide opportunity of fairly distributed wealth transfer.

Every registered Human receives approximately 1 UBI per hour, and they can do with it whatever they want, including transfers, selling it on the free market or burning it to decrease its total supply.

UBI is required to fund Deposit of new Humans in the registry, which allows it to act as a "rate-limiter" for new registrations. Having a UBI-based deposit is also beneficial for people who are anxious about risks of depositing harder assets, like ETH or stablecoins into unknown contracts just to register. Since UBI is tightly connected to PoH, the risk is removed, because if PoH was a scam, UBI that is printed by it would turn out to be worthless anyway.

All operations on the registry, like updating own records (name, bio, other text records), requires some UBI to be burned (destroyed), which also adds additional friction to any spam attempts. This is especially important in L2 environments, where gas is cheap.

#### Example
![](https://i.imgur.com/lc0ZdxE.png)

Alice is registered in PoH system, and she has accrued 1500 units of spendable UBI.

![](https://i.imgur.com/w5fvzvq.png)

1. Alice decides to Vouch and Fund Bob, because he is her close friend. Since UBI she got was free anyway, she doesn't experience any meaningful sense of loss.
2. After Bob gets accepted into the Registry, he starts accruing UBI at the same rate as Alice. He decides, he wants to onboard his friend Charlie, but he hasn't yet accrued spendable amount of UBI to cover Charlies deposit. Charlie doesn't want to wait a month for Bob to accrue UBI.
3. Charlie decides to buy it off the free market for DAI; and
4. Begin registration process immediately.

#### Notes
UBI value doesn't come from nothing. At first, it's measured in utility of getting into the registry. Many people may be willing to buy UBI in order to self-fund their application (they still require at least one vouch). Once the registry gets sizeable, it should be relatively easy to influence businesses, like marketplaces, to self-tax and stream small portion of profits back to Humanity by simply passing it to smart contract, like UBI Burner that DCAs into UBI and burns it.

POH DAO or another related organization could promote UBI-friendly initiatives, like:
1. Promote / certify NFT marketplaces that pass e.g. % of sales fees to UBI Burner
2. Promote artists, who commit % of their revenue from their art to UBI Burner
3. Many european countries allow passing 1% of their income tax to charity organization of choice. Non-profits registered there, could convert this 1% of fiat to stables and pass it directly to UBI Burner.
4. Award individual burners with collectibles, POAPs, etc
5. Allow committing UBI Substream to burn income immediately or direct it to the PoH DAO.

### Universal Burn Rate
UBI is only increasing with time and Humans registered in the Registry, which makes it a highly inflationary token. We cannot make any assumptions that an average Circulating Supply per Person will decrease due to the Registry expansion or other utility fees.

In order to combat this and to protect value coming from it to people who need it promptly, we need to introduce some mechanism that will limit hoarding. One such idea could be per-person limit, but because everyone is free to transfer their tokens to another address or lock them in a liquidity pool, we need a more universal approach of limiting Total Supply of UBI tokens.

Universal Burn Rate or UBR is similar to "Negative Interest Rates" known from [traditional Central Banking](https://www.ecb.europa.eu/ecb/educational/explainers/tell-me-more/html/why-negative-interest-rate.en.html) or [decentralized collateralized stablecoin design](https://dankradfeist.de/ethereum/2021/09/27/stablecoins-supply-demand.html). Unlike examples above, UBI isn't a loan in either direction, therefore calling it "Negative Interest Rates" would be misleading, so we need more precise and intuitive terminology.

#### Example
Alice has saved up 10k UBI (>1 year worth) and the UBR is 25%. We don't want to consider new UBI inflow (1UBI/h), so let's assume that Alice transfers 10k UBI to a different wallet not used in registration. After a year, she only has 7.5k UBI on this wallet and a year later, only ~5.6k and so on. Note that she is still accruing it on her main account with rate 1UBI/h, so while she lost 2.5k during that year, she has still gained almost 8.7k UBI on her main wallet.

How would the situation look like, if she saved up 30k UBI, instead of 10k UBI? It turns out, she'd be close to net-zero, because at a constant rate of +1 UBI/h she'd be losing a similar amount in her account due to Universal Burn. That would basically stabilize her savings at max ~3.5 years of UBI, including locked Deposit.

#### Notes
Main reason for Negative Rates existence is incentivizing "shorting" (betting against) the currency when it's worth more than its target value, either expressed in $, CPI or other indicator. Having a constant Burn rate of UBI incentives selling it as soon as it is received, which may cause additional selling pressure, since savers are aware that it's more profitable to sell it every day or week (assuming cheap gas on L2s), rather than holding it for long.

This is not so different if compared to debasing currencies, like USD, which from 2010 to 2022 debased on average ~9% yearly (and ~7% before 2020-2021 Quantitative Easing). In UBI, since there is no physical cash, and it's all "electronic money" and with it there is no need to freeze numerical value of any note - we have the flexibility of being more straightforward and rebase it instead of debasing, thus allowing maintaining similar purchasing power of a single UBI token even after 50 years of operating the system, where each country with fiat currency must periodically increase minimum wage, social benefits, etc. in numerical terms.

### Deposit
A mandatory portion of locked UBI equal to every person. Its main goal is to act as a bounty for registry gatekeepers - Seekers. In case, a given Person turns out to be a Sybil, deposit is partially burned, partially acts as a reward to successful Seekers and partially is spent as Court fees and pays for Jury time.

Deposit is a function of Total Supply divided by the number of registered Humans, i.e. 25% with some minimum value, like 720 UBI (roughly 1 person-month of streaming) and may increase over time, if UBI isn't burned fast enough. The locked-in deposit is not reflected in visible Account Balance, since it's not "spendable". In case, no UBI isn't voluntarily burned, it may slow down the effective increase of spendable UBI by up to 25%, which means that hourly increase of effective balance is 0.75 UBI/h in worst case scenario.

#### Notes
It's possible that UBI price could be so low due to lack of charitable actions, that even 1 year of it wouldn't be worth any trouble to the Seekers. In such scenario, to protect integrity of the registry from Sybils, it might be required to readjust minimum deposit from one month slowly to even two years of UBI, but a side effect would be that spendable account value would stop increasing for some time for people who have little or no savings, until the missing Deposit value is filled. This readjustment can be automated with oracle system.

We shouldn't be worried about UBI value at first. If the registry is successful, there will be high demand for UBI in order to fund new peoples deposits. This "growth phase" may take many years. After the growth phase ends, high deposit expressed in UBI-time is justifiable, because, assuming the registry success, the only new people joining will be children of people already present there.

### Web Of Trust
Previous implementation of PoH did not utilize any advanced Web Of Trust mechanics other than a single Vouch.

WoT purpose is to enable better protection measures from Sybils that would attempt to infiltrate social network by reducing its "connectiveness". An obvious example of it impersonating Twitter account with lots of followers (all bots). Absolute number of followers is meaningless and easy to fake in this context, because none of these bot accounts are connected to you in any significant way.

On top of current mechanics, we may add increased flow of UBI to incentive people to Link for distant (in graph theoretical terms) relationships. Let's say that linking requires committing additional deposit due to impact on the network, but at the same time, it increases UBI rate very slightly and up to a certain limit, e.g. people with no connections receive 1 UBI/h, but people with a significant network, receive even up to 2 UBI/h. Clustering connections within family members gives significantly smaller boost than connecting with coworkers or someone you've randomly met at an airport, because such "clustering" connection doesn't bring other people in the network any closer.

#### Direct Connection
Mutually confirmed relationship rooted in real world (Vouch-like). In Graph terms it's an Edge between People who both openly confirm that they know each other.

It's also worth ensuring that if a connection is one-sided (follower), then a person targeted still gets the benefits of connectivity, but the follower doesn't. This is useful to prop-up local politicians or celebrities, etc. within your local network.

#### Connection Distance
Any pair of people has a distance assigned between them, which tells us what's the distance of the shortest path in Social Graph between them. Distance between you and a person you're directly connected with is exactly 1. Distance between you and any other person is the smallest Distance to that person from any person directly connected to you plus 1. Special value +Infinity applies to completely disconnected people, which should be rare.

Additional useful metric to point connection rank "Connection Strength": how many direct connections (links) would need to break in order for Connection Distance between these 2 people to increase. Let's use notation `(Distance, Strength)`. If Alice and Bob connection is `(2, 5)`. It means they have 5 common friends and should probably hang out. At the same time, `(2, 1)` could be a fluke or an attempt at social engineering and should be considered weaker than `(3, 20)`. Other scoring metric can be used as well to simplify above findings.

Social Distance between each pair of people varies over time as people join and connect, and it should include last recalculated timestamp/block to let people see if that information isn't stale.

##### Connection Closing Distance
Optional - may be useful for calculating rewards for connecting people. Other metrics that calculate some nothion of []"centrality"](https://en.wikipedia.org/wiki/Centrality) should be explored.

How much of total Distance is being "closed" (reduced) thanks to the existence of this particular Connection. If you meet a person at an airport in a foreign country and Connect, many people will get closer to one another. This metric measures the potential benefit of a particular connection to the whole network.

As density of the network increases, the rewards for existing Connections will decrease over time.

Additional, small amount of stake must be committed per-connection, but boost coming from Network expansion should be at least net-neutral.

##### Privacy
Private profile can create following attestations / badges:
- I'm within immediate social circle of this person. Verifiable whistleblower.
- I'm closer than distance 3 to 80% of people registered on this forum. Honest opinion, whistle blowing.

Base PoH doesn't need to provide these features from the start, but the DAO should facilitate and encourage standards.

#### Notes
Granting additional UBI for maintaining connections may come up as unfair, but if videos aren't enough (A.I. generation improves), it may become required for the system to rely on additional information, like graph analysis, to properly secure it. PoH V1 model doesn't incentivize extensive graph building, because most people only care about single vouch.

Calculating Web Of Trust matrix requires significant amount of off-chain computation. Final on-chain results or subset of them may need to be provided with ZK proof.

We can't really verify that people know each other, unless they both provide transparent and verifiable proof that they know each other. We should not attempt to verify each connection transparently. A successful Sybil would not only need to create fake profile, but get connected with sufficiently dispersed groups of people in order to be plausible globally. In case, a Sybil is detected, each Connection is not only slashed, but also barred for some time (a year?) from creating new Connections. This system may be overlayed by other social networks, but since these allow non-humans or operate on Follower (IG, Twitter) basis than Connection, it seems there is some composable vacuum to be filled.

Relative Social Distance scoring may be a very useful tool for scoring relative local relevancy of another Person or their unlikelihood of being a Sybil in various Social Media platforms. 


### Simulation
Let's run a long simulation of UBI, assuming some parameters, like UBR, elastic deposit fraction and average growth of registry population. In these scenarios, we don't calculate effects of charity or taxes on the price of UBI - we only measure supply and deposit sizing.

#### Code
```python
import math

import matplotlib.pyplot as plt

income_daily = 24.0  # Every registered Human receives 1 UBI/h
burn_rate = 0.75  # Universal Burn Rate yearly
burn_rate_daily = math.pow(burn_rate, 1.0 / 365)  # Universal Burn Rate daily
deposit_total_fraction = 0.25  # 1/4 of total supply is locked up as Per Human Deposit
deposit_min = income_daily*30  # 1 month minimum deposit value in case there is little per-human UBI in circulation

# every starting person gets X days of UBI to facilitate initial growth
starting_humans_count = 100
starting_humans_boost = income_daily*90

daily_human_growth = math.pow(1.10, 1.0 / 30)  # ~10% monthly increase or ~3.1x growth each year
months = 12*50  # 50 years of simulation
days = months * 30  # it's only an estimate
max_human_count = 10 * 10**9  # assume max population is 10 billion


def sim() -> (int, float, float):
    total_supply: float = starting_humans_count * starting_humans_boost
    human_count: int = starting_humans_count

    def per_human_deposit():
        return max(total_supply / human_count * deposit_total_fraction, deposit_min)

    for d in range(days):
        # add money to existing people
        new_ubi = human_count * income_daily
        total_supply += new_ubi

        # burn
        total_supply *= burn_rate_daily

        # calculate spendable supply
        spendable_supply = total_supply - per_human_deposit() * human_count

        # try adding some new people
        new_humans = math.ceil((daily_human_growth-1.0) * human_count)
        # ensure new people are capped by total spendable supply (assume all people share their UBI)
        new_humans = min(new_humans, int(spendable_supply / per_human_deposit()))
        # ensure max population isn't exceeded
        if new_humans + human_count >= max_human_count:
            new_humans = max_human_count - human_count

        # decrease spendable supply
        spendable_supply -= new_humans * per_human_deposit()
        # update human counter
        human_count += new_humans
        if d % 30 == 0:
            yield human_count, total_supply, spendable_supply


# run simulation
results = list(sim())


# plot
def plot_totals():
    plt.grid(True)
    plt.xlabel('Month')

    plt.plot(range(months), [r[1]-r[2] for r in results], label='UBI Deposits')
    plt.plot(range(months), [r[2] for r in results], label='UBI Spendable Supply')
    plt.plot(range(months), [r[0] for r in results], label='Humans')
    plt.yscale('log')
    plt.title('Supply and Human count over time')
    plt.legend()
    plt.show()


def plot_per_human():
    fig, ax = plt.subplots()

    ax.bar(range(months), [(r[1] - r[2]) / r[0] for r in results], label='Deposit')
    ax.bar(range(months), [r[2] / r[0] for r in results], bottom=[(r[1] - r[2]) / r[0] for r in results],
           label='Spendable')
    ax.set_title("Per-Human average accumulated UBI")
    ax.set_ylabel('UBI')
    ax.legend()
    plt.xlabel('Month')
    plt.show()

# select plot
#plot_totals()
plot_per_human()
```

### Results
![](https://i.imgur.com/pERdvjy.png)
![](https://i.imgur.com/xOyZ1OP.png)


We may noteice two distinct phases: Growth, where there is a small amount of UBI in circulation and Stagnation when there may be more. As noted above, these results assume no charity burn, but even at 10 billion people, even committing 1 trillion $ yearly would allow 20% of poorest to receive 500$ each.

## Court
Court is a mechanism allowing to resolve conflicts in the registry using random quorum of juries. It mainly evaluates evidence provided by Seekers who aim at disrupting 

### Sybil
A [Sybil](https://en.wikipedia.org/wiki/Sybil_attack) in PoH Registry could be considered any person or other entity that violates rule of one Human <-> one Entry mapping in order to gain some benefit, like:
1. Gaining monetary value from owning multiple sources of UBI.
2. Manipulating this or another DAO voting if defined by Quadratic Voting or similar approaches aimed at encouraging direct involvement more than delegated.
3. Gaining an increased influence over Social Media integrating with the PoH Registry by manipulating its members opinions by normalizing certain viewpoints.
4. Benefiting in another way from the Registry destruction or simply trolling / griefing it.

In order for the registry to be viable, it must have builtin protections from such actors that will make these attacks expensive, slow and economically unfeasible to pull off at large scale and in longer time-frame.

Common types of Sybils, include:
1. Duplicate - multiple submissions of the same person pretending to be different people. The easiest one to discover due to availability of face-recognition software.
2. Fake - A.I. Deep-Fakes. It's possible to Deep-Fake external Evidence, like a photo or a video with made-up faces.
3. Puppet - it's also possible to bribe or force some real people to record a video on behalf of an Attacker. We must ensure to keep Applicants well-informed about benefits of PoH and UBI.

The system should penalize Sybils and their Vouchers disproportionately more than benefits they could potentially gain. It should also account for the fact, that good fake detection software may not be available for some time even after the registration, therefore any security deposit should be permanent (bounty).

#### Challenges
We should come up with variety of challenges that could make certain Sybils less likely to be successful. An example, could be:

Seekers should be able to challenge Puppets to record updated video with Time Proof (recent eth block hash). This should eliminate cases where Puppets are recruited en-masse on the street.

Suspected Fakes can be requested to record a video under conditions that usually confuse Deep Fake algorithms, take multiple angles, record live session (requires time coordination) with juries, etc.

These challenges should have cool downs, like 6 months and consecutive prosecution failures should increase required amount of time between challenges exponentially with some limit, like up to 4 years.

#### Protect against honest mistakes
A different approach should be considered when dealing with minor issues. Unless the application isn't fully inadmissible (griefing cases), minor issues, like mistake in spoken phrase or poor quality of video / audio, partially hidden face details, etc should be resolvable pre-trial with a guarantee of a tip.

If a Seeker finds an issue with application, they open challenge the same way as usual and selects specific type of issue. Applicant may then choose to either agree with it or not. If the challenge is not acknowledged, it is directed to a court and Applicant may lose full amount of their deposit and not get registered. On the other hand, if the person agrees with the challenge, a 10% tip is secured on behalf of the challenger and Applicant may re-upload their Submission. The challenger may then Accept new submission or not. If challenger accepts it, the normal registration process is resumed, but if not, it ends up in the Court. It may take multiple rounds of pre-trial corrections, before all issues are resolved.

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
We should ensure that there is a single source - ethereum L1 seems like a good bet. Other chains, specifically L2s can run their own contracts, but should be orchestrated from Main Registry on L1 and push registrants originating in L2s back to L1. This way, mainnet can still set UBI parameters (deposit, etc) in single place and not spread it across multiple chains.

It also makes easier migrations of registrants in bulk in case there is an issue with L2 without need to re-register.

It's also better to have a single source of truth and not-conflicting separate domains. PoHv2 is built for multi-domain PoH, which isn't hierarchical.

TODO: complete
