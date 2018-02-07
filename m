Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754599AbeBGPSo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 10:18:44 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:51788 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754138AbeBGPSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 10:18:40 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180207151838epoutp014aab8df0ae2f054e255ea14ed87642ce~RFCmX6wiz2588525885epoutp01y
X-AuditID: b6c32a36-ca9ff70000001028-3d-5a7b18cdb18d
Subject: Re: [PATCH 2/3] clk: exynos5433: Allow audio subsystem clock rate
 propagation
To: Chanwoo Choi <cw00.choi@samsung.com>, linux-clk@vger.kernel.org
Cc: sboyd@codeaurora.org, mturquette@baylibre.com,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <3fcfad37-4c8f-7375-b2c2-5154607aa47a@samsung.com>
Date: Wed, 07 Feb 2018 16:18:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <5A7929C1.8040706@samsung.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7bCmvu5Zieoog/sHzC02zljPanH9y3NW
        i02Pr7FafOy5x2pxedccNosZ5/cxWaw9cpfd4uIpV4sfZ7pZHDg93t9oZfe43NfL5LF5Sb1H
        35ZVjB6fN8kFsEZx2aSk5mSWpRbp2yVwZXSsW8BeME+44mA/RwPjK74uRk4OCQETiRMnjzJ3
        MXJxCAnsYJRYufQ7O4TznVHi/t7ZjDBV15sWMUEkNjBKnLk7nxHCuc8oseTJT6AWDg5hgQiJ
        O2e1QBpEBJwlFly6C1bDLHCJUeL2+3awSWwChhK9R/sYQep5Bewk3jUIgIRZBFQl1q37ygxi
        iwKNWTj1KVg5r4CgxI/J91hAbE4BbYkD1/+C1TALaEq8+DKJBcIWlzh2/yYjhC0vsXnNW7B3
        JATus0ks/7yDBeIDF4m7Z49AfSMs8er4FrCbJQSkJS4dtYWo72eUOLGmmRHCmcEocad9AhNE
        g7XE4eMXWSE28Em8+9rDCtHMK9HRJgRR4iHRc2IB1C5HiQUnm9hBbCGBB4wS++4GTmCUm4Xk
        n1lIfpiF5IdZSH5YwMiyilEstaA4Nz212LDASK84Mbe4NC9dLzk/dxMjOMVome1gXHTO5xCj
        AAejEg+vwYbKKCHWxLLiytxDjBIczEoivO7s1VFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeQMC
        XKKEBNITS1KzU1MLUotgskwcnFINjAbfFRSOXVdb0TuH8UULG1upaJzv27Wz3mUUM0hm83uu
        /XtEPH+7Vli3dvalCqYFil/9ioJUTWdvEZhzezL/chnJ6H+RXN59nk8Klzj5pTkKmL+M2+T0
        tY1ZqM5gqsMxFp7Lunop7tcPTnb9sv7j/H83bytVhd0TZnSR5E2dY9/B/PxDUnaFEktxRqKh
        FnNRcSIAv6300S0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsVy+t9jQd2zEtVRBpc+qFhsnLGe1eL6l+es
        FpseX2O1+Nhzj9Xi8q45bBYzzu9jslh75C67xcVTrhY/znSzOHB6vL/Ryu5xua+XyWPzknqP
        vi2rGD0+b5ILYI3isklJzcksSy3St0vgyuhYt4C9YJ5wxcF+jgbGV3xdjJwcEgImEtebFjF1
        MXJxCAmsY5T4dfgfI4TzkFFi4uut7F2MHBzCAhESd85qgTSICDhLLLh0F6yGWeASo8TpjftY
        IRruMUq8OdLDDFLFJmAo0Xu0jxGkmVfATuJdgwBImEVAVWLduq9gJaJAMztXzmcBsXkFBCV+
        TL4HZnMKaEscuP6XGaSVWUBdYsqUXJAws4C4xLH7NxkhbHmJzWveMk9gFJiFpHsWQscsJB2z
        kHQsYGRZxSiZWlCcm55bbFRgmJdarlecmFtcmpeul5yfu4kRGBHbDmv17WC8vyT+EKMAB6MS
        D2/HpsooIdbEsuLK3EOMEhzMSiK87uzVUUK8KYmVValF+fFFpTmpxYcYpTlYlMR5b+cdixQS
        SE8sSc1OTS1ILYLJMnFwSjUwBibXKjwW63QrWHHXR5xR9+0HdhbDKxd6rmS93jz7d6RW3TmX
        z82B7Kpayy7NNFwW9mCPtIl7/dpMqwC5V3ZbHCQzDVm/dP1e8PG2zxel9r2xqf1VDVelfBxn
        x9+LCb8rUVhy7sozBUW5h9wP7y+pN6o0XG/27dmDMOcjtxR//+TL32f/SPKQEktxRqKhFnNR
        cSIAHZl3sIQCAAA=
X-CMS-MailID: 20180207151837epcas1p349df4f5d7538a7ac52f0f70dbb736e43
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180205142308epcas2p376f8656f7e421f8474938de788cea8db
X-RootMTR: 20180205142308epcas2p376f8656f7e421f8474938de788cea8db
References: <20180205142230.9755-1-s.nawrocki@samsung.com>
        <CGME20180205142308epcas2p376f8656f7e421f8474938de788cea8db@epcas2p3.samsung.com>
        <20180205142230.9755-2-s.nawrocki@samsung.com>
        <5A7929C1.8040706@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On 02/06/2018 05:06 AM, Chanwoo Choi wrote:
>>  drivers/clk/samsung/clk-exynos5433.c | 22 +++++++++++-----------
>>  1 file changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
>> index 74b70ddab4d6..d74361736e64 100644
>> --- a/drivers/clk/samsung/clk-exynos5433.c
>> +++ b/drivers/clk/samsung/clk-exynos5433.c
>> @@ -246,14 +246,14 @@ static const struct samsung_fixed_rate_clock top_fixed_clks[] __initconst = {
>>  
>>  static const struct samsung_mux_clock top_mux_clks[] __initconst = {
>>  	/* MUX_SEL_TOP0 */
>> -	MUX(CLK_MOUT_AUD_PLL, "mout_aud_pll", mout_aud_pll_p, MUX_SEL_TOP0,
>> -			4, 1),
>> +	MUX_F(CLK_MOUT_AUD_PLL, "mout_aud_pll", mout_aud_pll_p, MUX_SEL_TOP0,
>> +	      4, 1, CLK_SET_RATE_PARENT, 0),
>
> If you add CLK_SET_RATE_PARENT to 'mout_aud_pll' and mout_aud_pll changes the rate,
> fout_aud_pll's rate will be changed. But, fout_aud_pll is also the parent
> of 'mout_aud_pll_user'. It might change the rate of children of mout_aud_pll_user.
> mout_aud_pll_user would not want to change the parent's clock.
> 
>     fout_aud_pll                          2            2   196608009          0 0  
>        mout_aud_pll_user                  1            1   196608009          0 0  
>        mout_aud_pll                       0            0   196608009          0 0  

I'd say the range of changes is such that the consumers of the affected child 
clocks can cope and could adjust to the changed frequencies. Those consumer 
devices are all components/peripherals of the audio subsystem (LPASS) and, 
for example, in case of TM2 there is no issues at all with varying the AUD PLL
frequency depending on the HDMI audio sample rate. The other audio path uses
the audio CODEC's internal PLL as the root clock source. The AUD PLL frequency
will need to be adjusted somehow anyway, we could also get the PLL clock 
directly and set it's rate, instead of relying on that rate propagation 
algorithm.  I think we could also export a function from the exynos-lpass mfd 
driver for setting the PLL's rate directly, after listing the AUD PLL clock 
in the lpass DT node. That would be more flexible API, easier to adopt for 
various use cases/boards, now we have only TM2. I can't list the PLL clock 
in the sound node, that would not have passed the DT maintainters' review. 

-- 
Regards,
Sylwester
