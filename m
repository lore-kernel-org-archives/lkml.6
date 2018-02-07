Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753989AbeBGLYW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 06:24:22 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:42754 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753837AbeBGLYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 06:24:19 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180207112417epoutp021549ffc27cbcce5d83a2987a05fd646e~RB1-hlunN2416524165epoutp02W
X-AuditID: b6c32a36-ca9ff70000001028-3d-5a7ae1e10ad9
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Message-id: <5A7AE1E0.8000509@samsung.com>
Date: Wed, 07 Feb 2018 20:24:16 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: linux-clk@vger.kernel.org, sboyd@codeaurora.org,
        mturquette@baylibre.com, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com
Subject: Re: [PATCH 1/3] clk: exynos5433: Extend list of available AUD_PLL
 output frequencies
In-reply-to: <75cac4e7-9bbb-e591-36a1-dcacc3f94ace@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdlhTX/fhw6oog8+ruSw2zljParHp8TVW
        i48991gtLu+aw2Yx4/w+Jou1R+6yW1w85Wpx+E07q8WPM90sDpwe72+0sntc7utl8ti8pN6j
        b8sqRo/Pm+QCWKNSbTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8
        AnTdMnOAzlFSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CpFGxoa6RkamOsZGRnpmRjHWhmZ
        ApUkpGasmf+GqWCdcMXWCfeYGhjX83cxcnJICJhI7Oz4ztjFyMUhJLCDUeLg689QzndGiRen
        zzDCVN1+9BsqsYFRouXoalaQBK+AoMSPyfdYuhg5OJgF5CWOXMoGCTMLaEq8+DKJBaL+HqPE
        n96JLBD1WhJ3uneA9bIIqEp07vkAtoANKL7/xQ02EJtfQFHi6o/HYHFRgQiJnfO/sYPYIgL6
        EktWXWQDGcos8JZRYv2pScwgCWGBeIl9D0+CFXEK2EvcfnqIFeLq22wSL+8aQ9guEqcf72OB
        sIUlXh3fwg5ytISAtMSlo7YgMyUE2hkl2vfOY4ZwpjBKnLt+jwmiwVji2cIuJojX+CTefe1h
        hWjmlehoE4Io8ZD4cm461F5Hiff/FoDtEhJ4wijRfVJjAqPcLKTwmoUIr1lI4bWAkXkVo1hq
        QXFuemqxYYGRXnFibnFpXrpecn7uJkZwAtQy28G46JzPIUYBDkYlHl6DDZVRQqyJZcWVuYcY
        JTiYlUR4f66sihLiTUmsrEotyo8vKs1JLT7EaAoM7onMUqLJ+cDknFcSb2hiaWBiZgRMXpaG
        hkrivAEBLlFCAumJJanZqakFqUUwfUwcnFINjEujEkpFJ4hm6R3qUaq2m8fzVaZZ115MvOTc
        ZTZZH+PO+qKbM9MC1GtsmYyWXVqWrmXBlZIrXnUq72nL3tKDq2ySl04UC74TtO6/pk7GrUXL
        otc0dH/kFnohrXKDS8fJYEOqtEeP7qvP5q81Xj/a9tMzxsh+aag589RIxXLHtFUcDJN/Gboq
        sRRnJBpqMRcVJwIAV3uM+ZYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsVy+t9jQd0HD6uiDI5/UrfYOGM9q8Wmx9dY
        LT723GO1uLxrDpvFjPP7mCzWHrnLbnHxlKvF4TftrBY/znSzOHB6vL/Ryu5xua+XyWPzknqP
        vi2rGD0+b5ILYI3isklJzcksSy3St0vgylgz/w1TwTrhiq0T7jE1MK7n72Lk5JAQMJG4/eg3
        YxcjF4eQwDpGiQW7frGCJHgFBCV+TL7H0sXIwcEsIC9x5FI2hKkuMWVKLkT5A0aJAz+PM0OU
        a0nc6d4B1soioCrRuecDI4jNBhTf/+IGG4jNL6AocfXHY0aQOaICERLdJypBwiIC+hJLVl1k
        A5nJLPCWUeLNyn1gM4UF4iX2PTzJDrHsCaPErfvTwBKcAvYSt58eYp3AKDALyamzEE6dhXDq
        AkbmVYySqQXFuem5xUYFhnmp5XrFibnFpXnpesn5uZsYgYG/7bBW3w7G+0viDzEKcDAq8fB2
        bKqMEmJNLCuuzD3EKMHBrCTC+3NlVZQQb0piZVVqUX58UWlOavEhRmkOFiVx3tt5xyKFBNIT
        S1KzU1MLUotgskwcnFINjE56+Qt6bas8Z/80/37Y/0/UoTmHdM/3Z32Yk7x7vcui3NtMP16z
        rIsXmrpKRq1MvO0A9y05/5Uuv9/XGa7wCm6t1TGPWt/ZP332W7db1jNn8OpdONbZ2VByZQ2v
        68mVu/Yx9hSdeBhtF50VVfz9VonLXdf5p7Z8bVxY8lHvrU9hu83SJudmViWW4oxEQy3mouJE
        ACY4if94AgAA
X-CMS-MailID: 20180207112416epcas1p18d4f842b76d99539129c28378947bb98
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180205142252epcas1p4471e32e2b513806420c64b323af2ffa6
X-RootMTR: 20180205142252epcas1p4471e32e2b513806420c64b323af2ffa6
References: <CGME20180205142252epcas1p4471e32e2b513806420c64b323af2ffa6@epcas1p4.samsung.com>
        <20180205142230.9755-1-s.nawrocki@samsung.com>
        <5A7916A2.7010307@samsung.com>
        <75cac4e7-9bbb-e591-36a1-dcacc3f94ace@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018년 02월 07일 19:29, Sylwester Nawrocki wrote:
> On 02/06/2018 03:44 AM, Chanwoo Choi wrote:
>> When I developed the clk-exynos5433.c I referred to the following description.
>> TRM specified that "Samsung recommends only the values
>> between 252MH ~ 400MHz in the PMS2460X PMS value" for aud_pll.
> 
> Thanks, I somehow missed it. There is also another sentence pointing to
> a contact person if other values are needed.
> 
>> It looks like that you refer to clk-exynos5420.c driver.
>> But, I'm wondering exynos5433 might not guarantee the additional clock
>> of this patch as the stable clock.
> 
> I took the values from downstream SM-N910C_LL kernel, I would say they
> are well tested and reliable. How about adding just these 3 entries:
> 
> +	PLL_36XX_RATE(196608001U, 197, 3, 3, -25690),
> +	PLL_36XX_RATE(180633609U, 301, 5, 3,   3671),
> +	PLL_36XX_RATE(131072006U, 131, 3, 3,   4719),
> ?
>  
> They are needed for audio sample rates that are multiple of 32000, 44100
> or 48000 Hz. The AUD PLL frequency values which are currently defined
> are not useful for anything except fs 48000 (fpll = 393216000 Hz).

If you referred to SM-N910C released kernel, I agree.

> 
> We could add new PLL rates: 361267218, 262144000, but I'm not convinced
> these would be any better than values used in a shipped product. We would 
> need to confirm below values with the HW team, and I'm not sure what 
> would be the P, M, S, K set for 262144000 frequency.
> 
> 	PLL_36XX_RATE(361267218U, 301, 5, 2,   3671),
> 
> As it turns out, the 393216000 Hz entry needs correction, the actual 
> frequency value from the P, M, S, K equation is 393216003:
> 
> -	PLL_36XX_RATE(393216000U, 197, 3, 2, -25690),
> +	PLL_36XX_RATE(393216003U, 197, 3, 2, -25690),

As you described, 393216003 might be more correct than 393216000,
IMHO, I think that TRM specified 393216000 instead of 393216003,
because the following equation is clean without any decimal point.
- "393216000 / 8192 = 48000"

I have no any objection, if 393216003 is correct result.

Could you share your equation?
because your result is a little bit different of my result.
- my equation : ((mdiv + kdiv/65535) x 24MHz) / (pdiv x POWER(2,sdiv))

> 
> Hmm, I have tested with the PLL frequency set to 393216003 Hz and there
> are some glitches during audio playback, I can't get it to work properly.
> 

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
