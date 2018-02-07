Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753803AbeBGK3v (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 05:29:51 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:38084 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753496AbeBGK3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 05:29:49 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180207102947epoutp0155222f6565cf66c1f07cfc6889af7d4d~RBGZh3ACH1440514405epoutp01Q
X-AuditID: b6c32a45-3ebff70000001023-e3-5a7ad51a630d
Subject: Re: [PATCH 1/3] clk: exynos5433: Extend list of available AUD_PLL
 output frequencies
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-clk@vger.kernel.org, sboyd@codeaurora.org,
        mturquette@baylibre.com, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <75cac4e7-9bbb-e591-36a1-dcacc3f94ace@samsung.com>
Date: Wed, 07 Feb 2018 11:29:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <5A7916A2.7010307@samsung.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7bCmha7U1aoogwf3WCw2zljPanH9y3NW
        i02Pr7FafOy5x2pxedccNosZ5/cxWaw9cpfd4uIpV4sfZ7pZHDg93t9oZfe43NfL5LF5Sb1H
        35ZVjB6fN8kFsEZx2aSk5mSWpRbp2yVwZSyZ/oCloImv4veHNrYGxvncXYycHBICJhI73r9j
        AbGFBHYwSsy6mtbFyAVkf2eUWPCqjw2maObVA+wQid2MEpufHmWEcO4zSnw83sUIUiUsEC+x
        7+FJdhBbREBDYubfK2BFzAJvGSXWn5rEDJJgEzCU6D3aB9bAK2AnsaR1K1gDi4CqxJ+5f8Bq
        RAUiJBZOfQpVIyjxY/I9oPs4ODgFtCVevCoBCTMLaEq8+DKJBcIWlzh2/yYjhC0vsXnNW2aQ
        vRICj9kkfi+6wATxgovE1yXtzBC2sMSr41vYIWxpiWerNjJCNPQzSpxY0wzlzGCUuNM+Aarb
        WuLw8YusECv4JDoO/2UHuUhCgFeio00IosRD4su56awQtqPE+38LWCBBtJ5R4taWKywTGOVm
        IXloFpIvZiH5YhaSLxYwsqxiFEstKM5NTy02KjDUK07MLS7NS9dLzs/dxAhONFquOxhnnPM5
        xCjAwajEw9uxqTJKiDWxrLgy9xCjBAezkgjvz5VVUUK8KYmVValF+fFFpTmpxYcYpTlYlMR5
        2wJcooQE0hNLUrNTUwtSi2CyTBycUg2M3O/ybTW/7nVgDluvwha8ruk2d2RCcMa15a+zzp3w
        yYqrjm4ofpd91WJ5ztrlIev01jKffMdfa/KaZ/WzLbdLG6+/K7eQuRPRZSa7JGDv49Xrum2z
        Cm0n6u3ceH6Ok0qEm0bexl6ryDdriraJ34u70dy1UHw9s1CYfMOG9Pclz5/f7c2bLfFfiaU4
        I9FQi7moOBEA+CtSCzADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsVy+t9jAV3Jq1VRBge2qFlsnLGe1eL6l+es
        FpseX2O1+Nhzj9Xi8q45bBYzzu9jslh75C67xcVTrhY/znSzOHB6vL/Ryu5xua+XyWPzknqP
        vi2rGD0+b5ILYI3isklJzcksSy3St0vgylgy/QFLQRNfxe8PbWwNjPO5uxg5OSQETCRmXj3A
        3sXIxSEksJNRou1hOxtIQkjgIaPE1/1yILawQLzEvocn2UFsEQENiZl/rzCCNDALvGWUeLNy
        HzNE93pGiZX/TjGBVLEJGEr0Hu1jBLF5BewklrRuBetmEVCV+DP3DzOILSoQIdG5cj4LRI2g
        xI/J94BsDg5OAW2JF69KQExmAXWJKVNyQSqYBcQljt2/yQhhy0tsXvOWeQKjwCwkzbMQOmYh
        6ZiFpGMBI8sqRsnUguLc9NxiowKjvNRyveLE3OLSvHS95PzcTYzAmNh2WKt/B+PjJfGHGAU4
        GJV4eA02VEYJsSaWFVfmHmKU4GBWEuH9ubIqSog3JbGyKrUoP76oNCe1+BCjNAeLkjgvf/6x
        SCGB9MSS1OzU1ILUIpgsEwenVAPjYdMbBjmP57l02NS0bUhtU3+z/aaTwp1jG6a6iaVc2Zzq
        kvlyseCn2Vm1vydPOmWbv/nt7XSlF37/S/7mfhR+kDDtr96R7coG01+2zrkR0imiPVX+c3Px
        hk+SO/9HLTDvkd5VOivKo3rb0ueJ2Sk+H4SqY6qmC9QFGN/rZEif/vvnUcvWA4mzlFiKMxIN
        tZiLihMBjKliqYUCAAA=
X-CMS-MailID: 20180207102945epcas2p1a7849465bfdb23a0a67f40d1cabd9c7d
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180205142252epcas1p4471e32e2b513806420c64b323af2ffa6
X-RootMTR: 20180205142252epcas1p4471e32e2b513806420c64b323af2ffa6
References: <CGME20180205142252epcas1p4471e32e2b513806420c64b323af2ffa6@epcas1p4.samsung.com>
        <20180205142230.9755-1-s.nawrocki@samsung.com>
        <5A7916A2.7010307@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2018 03:44 AM, Chanwoo Choi wrote:
> When I developed the clk-exynos5433.c I referred to the following description.
> TRM specified that "Samsung recommends only the values
> between 252MH ~ 400MHz in the PMS2460X PMS value" for aud_pll.

Thanks, I somehow missed it. There is also another sentence pointing to
a contact person if other values are needed.

> It looks like that you refer to clk-exynos5420.c driver.
> But, I'm wondering exynos5433 might not guarantee the additional clock
> of this patch as the stable clock.

I took the values from downstream SM-N910C_LL kernel, I would say they
are well tested and reliable. How about adding just these 3 entries:

+	PLL_36XX_RATE(196608001U, 197, 3, 3, -25690),
+	PLL_36XX_RATE(180633609U, 301, 5, 3,   3671),
+	PLL_36XX_RATE(131072006U, 131, 3, 3,   4719),
?
 
They are needed for audio sample rates that are multiple of 32000, 44100
or 48000 Hz. The AUD PLL frequency values which are currently defined
are not useful for anything except fs 48000 (fpll = 393216000 Hz).

We could add new PLL rates: 361267218, 262144000, but I'm not convinced
these would be any better than values used in a shipped product. We would 
need to confirm below values with the HW team, and I'm not sure what 
would be the P, M, S, K set for 262144000 frequency.

	PLL_36XX_RATE(361267218U, 301, 5, 2,   3671),

As it turns out, the 393216000 Hz entry needs correction, the actual 
frequency value from the P, M, S, K equation is 393216003:

-	PLL_36XX_RATE(393216000U, 197, 3, 2, -25690),
+	PLL_36XX_RATE(393216003U, 197, 3, 2, -25690),

Hmm, I have tested with the PLL frequency set to 393216003 Hz and there
are some glitches during audio playback, I can't get it to work properly.

--
Regards,
Sylwester
