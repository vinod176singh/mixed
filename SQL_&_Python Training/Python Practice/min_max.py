def minmaxofArray(arr,n):
    left,right=0,n-1
    min_ele,max_ele=0,0
    if arr[left]>arr[right]:
        min_ele=arr[right]
    else:
        min_ele=arr[left]
    while arr[right]<arr[left]:
        left+=1
        right-=1
    max_ele=arr[right]
    return [min_ele,max_ele]

arr=[10,20,30,40,50,60,45,35,25,15,5]
result =minmaxofArray(arr,11)
print(result)

# 1,100,99,98,9,3
# 1,100,95,91,90,3