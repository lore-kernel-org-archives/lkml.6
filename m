Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751952AbeFESox (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 14:44:53 -0400
Received: from sandeen.net ([63.231.237.45]:37626 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751786AbeFESot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 14:44:49 -0400
Subject: Re: [PATCH] xfs: mark sb_fname as nonstring
To: Arnd Bergmann <arnd@arndb.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>, linux-xfs@vger.kernel.org
Cc: Eric Sandeen <sandeen@redhat.com>, Martin Sebor <msebor@gmail.com>,
        Brian Foster <bfoster@redhat.com>, Dave Chinner <dchinner@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20180525151421.2317292-1-arnd@arndb.de>
From: Eric Sandeen <sandeen@sandeen.net>
Openpgp: preference=signencrypt
Autocrypt: addr=sandeen@sandeen.net; prefer-encrypt=mutual; keydata=
 xsFNBE6x99QBEADMR+yNFBc1Y5avoUhzI/sdR9ANwznsNpiCtZlaO4pIWvqQJCjBzp96cpCs
 nQZV32nqJBYnDpBDITBqTa/EF+IrHx8gKq8TaSBLHUq2ju2gJJLfBoL7V3807PQcI18YzkF+
 WL05ODFQ2cemDhx5uLghHEeOxuGj+1AI+kh/FCzMedHc6k87Yu2ZuaWF+Gh1W2ix6hikRJmQ
 vj5BEeAx7xKkyBhzdbNIbbjV/iGi9b26B/dNcyd5w2My2gxMtxaiP7q5b6GM2rsQklHP8FtW
 ZiYO7jsg/qIppR1C6Zr5jK1GQlMUIclYFeBbKggJ9mSwXJH7MIftilGQ8KDvNuV5AbkronGC
 sEEHj2khs7GfVv4pmUUHf1MRIvV0x3WJkpmhuZaYg8AdJlyGKgp+TQ7B+wCjNTdVqMI1vDk2
 BS6Rg851ay7AypbCPx2w4d8jIkQEgNjACHVDU89PNKAjScK1aTnW+HNUqg9BliCvuX5g4z2j
 gJBs57loTWAGe2Ve3cMy3VoQ40Wt3yKK0Eno8jfgzgb48wyycINZgnseMRhxc2c8hd51tftK
 LKhPj4c7uqjnBjrgOVaVBupGUmvLiePlnW56zJZ51BR5igWnILeOJ1ZIcf7KsaHyE6B1mG+X
 dmYtjDhjf3NAcoBWJuj8euxMB6TcQN2MrSXy5wSKaw40evooGwARAQABzSVFcmljIFIuIFNh
 bmRlZW4gPHNhbmRlZW5Ac2FuZGVlbi5uZXQ+wsF7BBMBAgAlAhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgAUCUzMzbAIZAQAKCRAgrhaS4T3e4Fr7D/wO+fenqVvHjq21SCjDCrt8HdVj
 aJ28B1SqSU2toxyg5I160GllAxEHpLFGdbFAhQfBtnmlY9eMjwmJb0sCIrkrB6XNPSPA/B2B
 UPISh0z2odJv35/euJF71qIFgWzp2czJHkHWwVZaZpMWWNvsLIroXoR+uA9c2V1hQFVAJZyk
 EE4xzfm1+oVtjIC12B9tTCuS00pY3AUy21yzNowT6SSk7HAzmtG/PJ/uSB5wEkwldB6jVs2A
 sjOg1wMwVvh/JHilsQg4HSmDfObmZj1d0RWlMWcUE7csRnCE0ZWBMp/ttTn+oosioGa09HAS
 9jAnauznmYg43oQ5Akd8iQRxz5I58F/+JsdKvWiyrPDfYZtFS+UIgWD7x+mHBZ53Qjazszox
 gjwO9ehZpwUQxBm4I0lPDAKw3HJA+GwwiubTSlq5PS3P7QoCjaV8llH1bNFZMz2o8wPANiDx
 5FHgpRVgwLHakoCU1Gc+LXHXBzDXt7Cj02WYHdFzMm2hXaslRdhNGowLo1SXZFXa41KGTlNe
 4di53y9CK5ynV0z+YUa+5LR6RdHrHtgywdKnjeWdqhoVpsWIeORtwWGX8evNOiKJ7j0RsHha
 WrePTubr5nuYTDsQqgc2r4aBIOpeSRR2brlT/UE3wGgy9LY78L4EwPR0MzzecfE1Ws60iSqw
 Pu3vhb7h3c7BTQROsffUARAA0DrUifTrXQzqxO8aiQOC5p9Tz25Np/Tfpv1rofOwL8VPBMvJ
 X4P5l1V2yd70MZRUVgjmCydEyxLJ6G2YyHO2IZTEajUY0Up+b3ErOpLpZwhvgWatjifpj6bB
 SKuDXeThqFdkphF5kAmgfVAIkan5SxWK3+S0V2F/oxstIViBhMhDwI6XsRlnVBoLLYcEilxA
 2FlRUS7MOZGmRJkRtdGD5koVZSM6xVZQSmfEBaYQ/WJBGJQdPy94nnlAVn3lH3+N7pXvNUuC
 GV+t4YUt3tLcRuIpYBCOWlc7bpgeCps5Xa0dIZgJ8Louu6OBJ5vVXjPxTlkFdT0S0/uerCG5
 1u8p6sGRLnUeAUGkQfIUqGUjW2rHaXgWNvzOV6i3tf9YaiXKl3avFaNW1kKBs0T5M1cnlWZU
 Utl6k04lz5OjoNY9J/bGyV3DSlkblXRMK87iLYQSrcV6cFz9PRl4vW1LGff3xRQHngeN5fPx
 ze8X5NE3hb+SSwyMSEqJxhVTXJVfQWWW0dQxP7HNwqmOWYF/6m+1gK/Y2gY3jAQnsWTru4RV
 TZGnKwEPmOCpSUvsTRXsVHgsWJ70qd0yOSjWuiv4b8vmD3+QFgyvCBxPMdP3xsxN5etheLMO
 gRwWpLn6yNFq/xtgs+ECgG+gR78yXQyA7iCs5tFs2OrMqV5juSMGmn0kxJUAEQEAAcLBXwQY
 AQIACQUCTrH31AIbDAAKCRAgrhaS4T3e4BKwD/0ZOOmUNOZCSOLAMjZx3mtYtjYgfUNKi0ki
 YPveGoRWTqbis8UitPtNrG4XxgzLOijSdOEzQwkdOIp/QnZhGNssMejCnsluK0GQd+RkFVWN
 mcQT78hBeGcnEMAXZKq7bkIKzvc06GFmkMbX/gAl6DiNGv0UNAX+5FYh+ucCJZSyAp3sA+9/
 LKjxnTedX0aygXA6rkpX0Y0FvN/9dfm47+LGq7WAqBOyYTU3E6/+Z72bZoG/cG7ANLxcPool
 LOrU43oqFnD8QwcN56y4VfFj3/jDF2MX3xu4v2OjglVjMEYHTCxP3mpxesGHuqOit/FR+mF0
 MP9JGfj6x+bj/9JMBtCW1bY/aPeMdPGTJvXjGtOVYblGZrSjXRn5++Uuy36CvkcrjuziSDG+
 JEexGxczWwN4mrOQWhMT5Jyb+18CO+CWxJfHaYXiLEW7dI1AynL4jjn4W0MSiXpWDUw+fsBO
 Pk6ah10C4+R1Jc7dyUsKksMfvvhRX1hTIXhth85H16706bneTayZBhlZ/hK18uqTX+s0onG/
 m1F3vYvdlE4p2ts1mmixMF7KajN9/E5RQtiSArvKTbfsB6Two4MthIuLuf+M0mI4gPl9SPlf
 fWCYVPhaU9o83y1KFbD/+lh1pjP7bEu/YudBvz7F2Myjh4/9GUAijrCTNeDTDAgvIJDjXuLX pA==
Message-ID: <ea7ec2ef-f30f-c4dc-c1d3-c0a2a4810fd5@sandeen.net>
Date: Tue, 5 Jun 2018 13:44:48 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180525151421.2317292-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/25/18 10:14 AM, Arnd Bergmann wrote:
> gcc-8 reports two warnings for the newly added getlabel/setlabel code:
> 
> fs/xfs/xfs_ioctl.c: In function 'xfs_ioc_getlabel':
> fs/xfs/xfs_ioctl.c:1822:38: error: argument to 'sizeof' in 'strncpy' call is the same expression as the source; did you mean to use the size of the destination? [-Werror=sizeof-pointer-memaccess]
>   strncpy(label, sbp->sb_fname, sizeof(sbp->sb_fname));
>                                       ^
> In function 'strncpy',
>     inlined from 'xfs_ioc_setlabel' at /git/arm-soc/fs/xfs/xfs_ioctl.c:1863:2,
>     inlined from 'xfs_file_ioctl' at /git/arm-soc/fs/xfs/xfs_ioctl.c:1918:10:
> include/linux/string.h:254:9: error: '__builtin_strncpy' output may be truncated copying 12 bytes from a string of length 12 [-Werror=stringop-truncation]
>   return __builtin_strncpy(p, q, size);
> 
> In both cases, part of the problem is that one of the strncpy()
> arguments is a fixed-length character array with zero-padding rather
> than a zero-terminated string. In the first one case, we also get an
> odd warning about sizeof-pointer-memaccess, which doesn't seem right
> (the sizeof is for an array that happens to be the same as the second
> strncpy argument).
> 
> To work around the bogus warning, I use a plain 'XFSLABEL_MAX' for
> the strncpy() length when copying the label in getlabel. For setlabel(),
> using memcpy() with the correct length that is already known avoids
> the second warning and is slightly simpler.
> 
> In a related issue, it appears that we accidentally skip the trailing
> \0 when copying a 12-character label back to user space in getlabel().
> Using the correct sizeof() argument here copies the extra character.
> 
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=85602
> Fixes: f7664b31975b ("xfs: implement online get/set fs label")
> Cc: Eric Sandeen <sandeen@redhat.com>
> Cc: Martin Sebor <msebor@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/xfs/xfs_ioctl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index 84fbf164cbc3..eb79f2bc4dcc 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -1819,12 +1819,12 @@ xfs_ioc_getlabel(
>  	BUILD_BUG_ON(sizeof(sbp->sb_fname) > FSLABEL_MAX);
>  
>  	spin_lock(&mp->m_sb_lock);
> -	strncpy(label, sbp->sb_fname, sizeof(sbp->sb_fname));
> +	strncpy(label, sbp->sb_fname, XFSLABEL_MAX);
>  	spin_unlock(&mp->m_sb_lock);
>  
>  	/* xfs on-disk label is 12 chars, be sure we send a null to user */
>  	label[XFSLABEL_MAX] = '\0';
> -	if (copy_to_user(user_label, label, sizeof(sbp->sb_fname)))
> +	if (copy_to_user(user_label, label, sizeof(label)))

I /think/ this also runs the risk of copying out stack memory.

I'll send another proposal based on this with slight modifications.

>  		return -EFAULT;
>  	return 0;
>  }
> @@ -1860,7 +1860,7 @@ xfs_ioc_setlabel(
>  
>  	spin_lock(&mp->m_sb_lock);
>  	memset(sbp->sb_fname, 0, sizeof(sbp->sb_fname));
> -	strncpy(sbp->sb_fname, label, sizeof(sbp->sb_fname));
> +	memcpy(sbp->sb_fname, label, len);
>  	spin_unlock(&mp->m_sb_lock);
>  
>  	/*
> 
