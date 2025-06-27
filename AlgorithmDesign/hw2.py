def knapsack(weight, value, c):
    n = len(weight)
    dp = [0] * (c + 1)
    decision = [[0] * (c + 1) for _ in range(n)]

    for i in range(n):
        for j in range(c, weight[i] - 1, -1):
            if dp[j] < dp[j - weight[i]] + value[i]:
                dp[j] = dp[j - weight[i]] + value[i]
                decision[i][j] = 1

    j = c
    chosen_items = [0] * n
    for i in range(n - 1, -1, -1):
        if decision[i][j] == 1:
            chosen_items[i] = 1
            j -= weight[i]

    # return dp[c], chosen_items
    return chosen_items

print(knapsack([2, 1, 3, 2], [12, 10, 20, 15], 5))