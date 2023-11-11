def checkPurmutation(s1,s2):
    start,end=0,0
    s1hash,s2hash={},{}
    while end<len(s1):
        if s1[end] not in s1hash:
            s1hash[s1[end]]=0
        s1hash[s1[end]]+=1
        if s2[end] not in s2hash:
            s2hash[s2[end]]=0
        s2hash[s2[end]]+=1
        end+=1
    while end-start+1>len(s1):
        if s1hash==s2hash:
            return True
        s2hash[s2[start]]-=1
        if s2hash[s2[start]]==0:
            del s2hash[s2[start]]
        start+=1
        if end<len(s2):
            if s2[end] not in s2hash:
                s2hash[s2[end]]=0
            s2hash[s2[end]]+=1
            end+=1
    return False
        
    
def main():
    result=checkPurmutation('abc','dsdsbcafse')
    print(result)

main()
