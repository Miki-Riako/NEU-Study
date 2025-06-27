def min_coins(coins, amount):
    # Using amount + 1 represents the infinite value.
    dp = [[0] * len(coins) for _ in range(amount + 1)]
    min_coins = [amount + 1] * (amount + 1)
    min_coins[0] = 0

    for i in range(1, amount + 1):
        for j, coin in enumerate(coins):
            if i - coin >= 0:
                if min_coins[i - coin] + 1 < min_coins[i]:
                    min_coins[i] = min_coins[i - coin] + 1
                    dp[i] = dp[i - coin].copy()
                    dp[i][j] += 1

    if min_coins[amount] == amount + 1:
        return -1, []
    else:
        return min_coins[amount], dp[amount]

print(min_coins([1, 5, 6], int(input())))
