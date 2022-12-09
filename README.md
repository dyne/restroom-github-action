## Introduction
This GitHub Action starts a service with the restroom middlewares port `3000`.

This is useful when running tests against restroom contracts


## Example
```yaml
on: [push]

jobs:
  restroom_job:
    runs-on: ubuntu-latest
    name: Start restroom and request a simple contract
    steps:
      - name: Checkout
        uses: actions/checkout@v1
      - name: Start restroom
        uses: dyne/restroom-github-action
        with:
          restroom-contracts: "${{ github.workspace }}/contracts"
      - name: Install curl
        run: sudo apt install curl
      - name: Try to fetch
        run: curl http://localhost:3000/api/test
```
