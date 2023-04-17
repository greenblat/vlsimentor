
import logs
   
def xteaEncrypt(key, val, n=32):
    v0 = int(val[8:16],16)
    v1 = int(val[0:8],16)
    k = [int(key[24:32],16), int(key[16:24],16), int(key[8:16],16), int(key[0:8],16)]
 
    sum, delta, mask = 0, 0x9e3779b9, 0xffffffff
    for round in range(n):
        v0 = (v0 + (((v1 << 4 ^ v1 >> 5) + v1) ^
                    (sum + k[sum & 3]))) & mask
        sum = (sum + delta) & mask
        v1 = (v1 + (((v0 << 4 ^ v0 >> 5) + v0) ^
                    (sum + k[sum >> 11 & 3]))) & mask

    res =  hex(v0)[2:][::-1]+hex(v1)[2:][::-1]
    res = '%08x%08x' % (v1,v0)
    logs.log_info('ENCRYPT key=%s val=%s res=%s' % (key,val,res))
    return res

def xteaDecrypt(key, val, n=32):
    v1 = int(val[8:16][::-1],16)
    v0 = int(val[0:8][::-1],16)
    k = [int(key[24:32],16), int(key[16:24],16), int(key[8:16],16), int(key[0:8],16)]

    delta, mask = 0x9e3779b9, 0xffffffff
    sum = (delta * n) & mask
    for round in range(n):
        v1 = (v1 - (((v0 << 4 ^ v0 >> 5) + v0) ^
                    (sum + k[sum >> 11 & 3]))) & mask
        sum = (sum - delta) & mask
        v0 = (v0 - (((v1 << 4 ^ v1 >> 5) + v1) ^
                    (sum + k[sum & 3]))) & mask

    return '{:08x}'.format(v1)+'{:08x}'.format(v0)


