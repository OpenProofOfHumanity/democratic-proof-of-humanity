<p align="center">
<img src="docs/images/poh.png" width="150" title="Open & Democratic Proof of Humanity">
</p>


# Proof of Humanity Protocol.

Sybil-resistant registry of Humans using social verification and independent courts. Streaming Universal Basic Income 💧 and building a decentralized democracy.

For more information read the [Protocol Specification](SPECIFICATION.md). 


## Setup

1. Clone Repository

    ```sh
    $ git clone https://github.com/OpenProofOfHumanity/democratic-proof-of-humanity.git
    $ cd democractic-proof-of-humanity
    ```

2.  Install [Foundry](https://github.com/foundry-rs/foundry).

    ```sh
    curl -L https://foundry.paradigm.xyz | bash
    ```

    Then, run `foundryup` in a new terminal session or after reloading your `PATH`.

3.  Interact with Contract.

    Copy the `.env.example` file into `.env`.

    ```bash
    cp .env.example .env
    ```

    Set the appropiate values.

    ```bash
    PRIVATE_KEY=# Enter the private key of the blockchain address that will deploy
    RPC_URL='https://{network}.infura.io/v3/{api_key}' # or alchemy URL.
    ```

    Then you can:

    * Build it.

        ```sh
        make build
        ```
    * Test it.

        ```sh
        make test
        ```
    * Deploy it.

        ```sh
        make deploy
        ```
    
## Deploy

Project is currently under development.

## Contribute

These contracts are free, open source and censorship resistant. Support development efforts via [Open Collective](https://opencollective.com/democracyearth).

## License

This software is under an [MIT License](LICENSE.md).