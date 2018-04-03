Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753298AbeDCUlD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 16:41:03 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33449 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752558AbeDCUlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 16:41:01 -0400
X-Google-Smtp-Source: AIpwx48rgrzQlBtziOZw63xJe/U5QrN1+nYshVAq4/05T3bkmzYwxzpa+0YDwMo3HXc1eY1MmeP8Zw==
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH net 1/2] net: bcmgenet: Fix sparse warnings in
 bcmgenet_put_tx_csum()
To: Al Viro <viro@ZenIV.linux.org.uk>, David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, opendmb@gmail.com,
        linux-kernel@vger.kernel.org
References: <20180402225856.4351-1-f.fainelli@gmail.com>
 <20180402225856.4351-2-f.fainelli@gmail.com>
 <20180403162933.GJ30522@ZenIV.linux.org.uk>
 <20180403.123305.1783530733365447500.davem@davemloft.net>
 <20180403164545.GK30522@ZenIV.linux.org.uk>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <932b5de7-97ed-3f7b-11ec-d056a67c7e9f@gmail.com>
Date: Tue, 3 Apr 2018 13:40:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180403164545.GK30522@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2018 09:45 AM, Al Viro wrote:
> On Tue, Apr 03, 2018 at 12:33:05PM -0400, David Miller wrote:
> 
>> Yes Al, however the pattern choosen here is probably cheaper on little endian:
>>
>> 	__beXX val = x;
>> 	switch (val) {
>> 	case htons(ETH_P_FOO):
>> 	 ...
>> 	}
>>
>> This way only the compiler byte swaps the constants at compile time,
>> no code is actually generated to do it.
> 
> That's not obvious, actually - depends upon how sparse the switch ends
> up being.  You can easily lose more than a single byteswap insn on
> worse cascase of comparisons.

David is right though here and this is used primarily on LE hosts, the
code produced with your suggested change does fix the sparse warning and
is functional, but results in less efficient code with a rev16
instruction being used. If you would prefer me to use __constant_htons()
to make that clearer, I don't have any objection to that.

172 instructions including a rev16

00002da8 <bcmgenet_insert_status>:
    2da8:       e1d038b8        ldrh    r3, [r0, #136]  ; 0x88
    2dac:       e92d4070        push    {r4, r5, r6, lr}
    2db0:       e6bf3fb3        rev16   r3, r3			<==============
    2db4:       e6ff3073        uxth    r3, r3
    2db8:       e3530b02        cmp     r3, #2048       ; 0x800
    2dbc:       0a000020        beq     2e44 <bcmgenet_insert_status+0x9c>
    2dc0:       e30826dd        movw    r2, #34525      ; 0x86dd
    2dc4:       e1530002        cmp     r3, r2
    2dc8:       1a00001c        bne     2e40 <bcmgenet_insert_status+0x98>
    2dcc:       e5906098        ldr     r6, [r0, #152]  ; 0x98
    2dd0:       e1d028bc        ldrh    r2, [r0, #140]  ; 0x8c
    2dd4:       e0862002        add     r2, r6, r2
    2dd8:       e5d22006        ldrb    r2, [r2, #6]
    2ddc:       e242e011        sub     lr, r2, #17
    2de0:       e1d0c6b4        ldrh    ip, [r0, #100]  ; 0x64
    2de4:       e16fef1e        clz     lr, lr
    2de8:       e590509c        ldr     r5, [r0, #156]  ; 0x9c
    2dec:       e1d046b6        ldrh    r4, [r0, #102]  ; 0x66
    2df0:       e1a0e2ae        lsr     lr, lr, #5
    2df4:       e3520006        cmp     r2, #6
    2df8:       11a0200e        movne   r2, lr
    2dfc:       038e2001        orreq   r2, lr, #1
    2e00:       e3520000        cmp     r2, #0
    2e04:       0a00000b        beq     2e38 <bcmgenet_insert_status+0x90>
    2e08:       e0455006        sub     r5, r5, r6
    2e0c:       e3530b02        cmp     r3, #2048       ; 0x800
    2e10:       13a0e000        movne   lr, #0
    2e14:       020ee001        andeq   lr, lr, #1
    2e18:       e04c3005        sub     r3, ip, r5
    2e1c:       e35e0000        cmp     lr, #0
    2e20:       e2433040        sub     r3, r3, #64     ; 0x40
    2e24:       e6ff3073        uxth    r3, r3
    2e28:       e0844003        add     r4, r4, r3
    2e2c:       e1842803        orr     r2, r4, r3, lsl #16
    2e30:       e3822102        orr     r2, r2, #-2147483648    ; 0x80000000
    2e34:       13822902        orrne   r2, r2, #32768  ; 0x8000
    2e38:       e5812030        str     r2, [r1, #48]   ; 0x30
    2e3c:       e8bd8070        pop     {r4, r5, r6, pc}
    2e40:       e8bd8070        pop     {r4, r5, r6, pc}
    2e44:       e5906098        ldr     r6, [r0, #152]  ; 0x98
    2e48:       e1d028bc        ldrh    r2, [r0, #140]  ; 0x8c
    2e4c:       e0862002        add     r2, r6, r2
    2e50:       e5d22009        ldrb    r2, [r2, #9]
    2e54:       eaffffe0        b       2ddc <bcmgenet_insert_status+0x34>


Whereas my changes result in:

164 instructions, and no rev* since everything is resolved at compile time.

00000810 <bcmgenet_insert_status>:
     810:       e92d4070        push    {r4, r5, r6, lr}
     814:       e1d0e8b8        ldrh    lr, [r0, #136]  ; 0x88
     818:       e35e0008        cmp     lr, #8
     81c:       0a000020        beq     8a4 <bcmgenet_insert_status+0x94>
     820:       e30d3d86        movw    r3, #56710      ; 0xdd86
     824:       e15e0003        cmp     lr, r3
     828:       1a00001c        bne     8a0 <bcmgenet_insert_status+0x90>
     82c:       e5906098        ldr     r6, [r0, #152]  ; 0x98
     830:       e1d038bc        ldrh    r3, [r0, #140]  ; 0x8c
     834:       e0863003        add     r3, r6, r3
     838:       e5d33006        ldrb    r3, [r3, #6]
     83c:       e2434011        sub     r4, r3, #17
     840:       e1d0c6b4        ldrh    ip, [r0, #100]  ; 0x64
     844:       e16f4f14        clz     r4, r4
     848:       e590209c        ldr     r2, [r0, #156]  ; 0x9c
     84c:       e1d056b6        ldrh    r5, [r0, #102]  ; 0x66
     850:       e1a042a4        lsr     r4, r4, #5
     854:       e3530006        cmp     r3, #6
     858:       11a03004        movne   r3, r4
     85c:       03843001        orreq   r3, r4, #1
     860:       e3530000        cmp     r3, #0
     864:       0a00000b        beq     898 <bcmgenet_insert_status+0x88>
     868:       e0422006        sub     r2, r2, r6
     86c:       e35e0008        cmp     lr, #8
     870:       13a0e000        movne   lr, #0
     874:       0204e001        andeq   lr, r4, #1
     878:       e04c2002        sub     r2, ip, r2
     87c:       e35e0000        cmp     lr, #0
     880:       e2422040        sub     r2, r2, #64     ; 0x40
     884:       e6ff2072        uxth    r2, r2
     888:       e0855002        add     r5, r5, r2
     88c:       e1853802        orr     r3, r5, r2, lsl #16
     890:       e3833102        orr     r3, r3, #-2147483648    ; 0x80000000
     894:       13833902        orrne   r3, r3, #32768  ; 0x8000
     898:       e5813030        str     r3, [r1, #48]   ; 0x30
     89c:       e8bd8070        pop     {r4, r5, r6, pc}
     8a0:       e8bd8070        pop     {r4, r5, r6, pc}
     8a4:       e5906098        ldr     r6, [r0, #152]  ; 0x98
     8a8:       e1d038bc        ldrh    r3, [r0, #140]  ; 0x8c
     8ac:       e0863003        add     r3, r6, r3
     8b0:       e5d33009        ldrb    r3, [r3, #9]
     8b4:       eaffffe0        b       83c <bcmgenet_insert_status+0x2c>

-- 
Florian
