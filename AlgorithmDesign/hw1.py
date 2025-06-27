def max_credits(times, credits, max_time):
    n = len(times)
    dp = [[0] * (max_time + 1) for _ in range(n + 1)]

    for i in range(1, n + 1):
        for j in range(max_time + 1):
            if j >= times[i - 1]:
                dp[i][j] = max(dp[i - 1][j], dp[i - 1][j - times[i - 1]] + credits[i - 1])
            else:
                dp[i][j] = dp[i - 1][j]

    return dp[n][max_time]

def max_credits_new(times, credits, max_time):
    n = len(times)
    dp = [[0] * (max_time + 1) for _ in range(n + 1)]

    for i in range(1, n + 1):
        for j in range(max_time + 1):
            if j >= times[i - 1]:
                dp[i][j] = max(dp[i - 1][j], dp[i - 1][j - times[i - 1]] + credits[i - 1])
            else:
                dp[i][j] = dp[i - 1][j]

    selected_courses = []
    j = max_time
    for i in range(n, 0, -1):
        if dp[i][j] != dp[i-1][j]:
            selected_courses.append(i)
            j -= times[i-1]

    selected_courses.reverse()
    return dp[n][max_time], selected_courses

print(max_credits([2, 1, 3, 2], [1.2, 1.0, 2.0, 1.5], 5))
print(max_credits_new([5, 15, 22, 27, 30], [1.2, 3.0, 4.4, 4.6, 4.7], 50))
