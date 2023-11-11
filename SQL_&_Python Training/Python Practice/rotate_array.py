def rotate_array_brf(arr,k):
    result=[0 for i in range(len(arr))]
    n=len(arr)
    m=n-k
    j=0
    for i in range(m,n):
        result[j]=arr[i]
        j+=1
    for i in range(0,m):
        result[j]=arr[i]
        j+=1
    return result

def main():
    result=rotate_array_brf([1,2,3,4,5],2)
    print(result)

main()