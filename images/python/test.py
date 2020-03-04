n = 1000003

def verify_flt(n):
    for i in range(2, n):
        if pow(i, n - 1, n) != 1:
            return False

    return True

verify_flt(n)
