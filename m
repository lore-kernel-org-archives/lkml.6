Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031146AbeBNOxG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:53:06 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:19402 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030675AbeBNOxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:53:02 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180214145300epoutp0143468ee443cbacf2a274a8b14dca81a1~TONN1oXNE3042830428epoutp01N
X-AuditID: b6c32a37-44bff70000001029-c8-5a844d4b8118
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
Subject: Re: [PATCH 3/3] clk: exynos5433: Add CLK_IGNORE_UNUSED flag to
 sclk_ioclk_i2s1_bclk
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-clk@vger.kernel.org, sboyd@codeaurora.org,
        mturquette@baylibre.com, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <847021bf-d8b0-2070-86b3-fa63ce5e0517@samsung.com>
Date: Wed, 14 Feb 2018 15:52:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
In-reply-to: <5A792A2B.60603@samsung.com>
Content-language: en-GB
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsWy7bCmga63b0uUQd9CcYuNM9azWlz/8pzV
        YtPja6wWH3vusVpc3jWHzWLG+X1MFmuP3GW3uHjK1eLHmW4WB06P9zda2T0u9/UyeWxeUu/R
        t2UVo8fnTXIBrFFcNimpOZllqUX6dglcGV37ZrAVPOKu2P3oHXMD42/OLkZODgkBE4nlk6+x
        g9hCAjsYJVq2GHUxcgHZ3xklejauYe5i5AArWrPJGyK+m1HiRdcmsAZeAUGJH5PvsYDYzAKa
        Ei++TGKBKLrPKPFp8UVWkISwQJzE4zV7wRpEBDQkZv69wghSxCzwllFi/alJzCAJNgFDid6j
        fYwQU+0k7u3oAIuzCKhK3PrUCrZBVCBCYuHUp2A1nEDbVl9fzAaxWVzi2P2bjBC2vMTBK8/B
        rpAQeMwmsWXBFxaIP10krv67zwRhC0u8Or6FHeI1aYlLR20h6vsZJT4e3w/VvJpR4vW3XawQ
        DdYSh49DvMMswCfx7msPK0Qzr0RHmxBEiYfExYkn2SFsR4kNuzYzQ4LiDqPEpdn7WCYwys1C
        CrJZSEE2C8kTs5A8sYCRZRWjWGpBcW56arFhgbFecWJucWleul5yfu4mRnCa0TLfwbjhnM8h
        RgEORiUeXgObligh1sSy4srcQ4wSHMxKIrzG55ujhHhTEiurUovy44tKc1KLDzFKc7AoifMG
        BLhECQmkJ5akZqemFqQWwWSZODilGhh9r930lJr9TOxCEoPQ5Vn3dRfxnrjLMOlRcfFXngbj
        hJVt7GFRW7yFHLzjN/xfsevrPmtdw+kRkvu6qiQ1Sx+5mwXELnj03m95zZtX71oP6k4vl3rR
        5M/2+9uXbwbTf8s3PnvNuU7vuN1loW/3nU2kFxfzJHy9FxCbOetd8Y75rRtkQk7dnBygxFKc
        kWioxVxUnAgAcx3aVC8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsVy+t9jAV0v35Yog/5OPYuNM9azWlz/8pzV
        YtPja6wWH3vusVpc3jWHzWLG+X1MFmuP3GW3uHjK1eLHmW4WB06P9zda2T0u9/UyeWxeUu/R
        t2UVo8fnTXIBrFFcNimpOZllqUX6dglcGV37ZrAVPOKu2P3oHXMD42/OLkYODgkBE4k1m7y7
        GLk4hAR2Mko82nWJsYuRk4NXQFDix+R7LCA1zALqElOm5ELUPGSUeHv6JStIjbBAnMTjNXvZ
        QWwRAQ2JmX+vMIIUMQu8ZZR4s3IfM0THHUaJ5tlLwarYBAwleo/2QW2wk7i3o4MZxGYRUJW4
        9amVBcQWFYiQ6Fw5H8zmFNCUWH19MRuIzSwgLnHs/k1GCFte4uCV5ywTGAVmITl2FsKxs5B0
        zELSsYCRZRWjZGpBcW56brFRgWFearlecWJucWleul5yfu4mRmBUbDus1beD8f6S+EOMAhyM
        Sjy8BjYtUUKsiWXFlbmHGCU4mJVEeI3PN0cJ8aYkVlalFuXHF5XmpBYfYpTmYFES572ddyxS
        SCA9sSQ1OzW1ILUIJsvEwSnVwKjquzLBO83/zdS2s5xXvXaYT0uLsC9kklnJOXOV6jfjHRuN
        7vkJX39zpIWh82Vs3oRQ7jf/f4RkL+iR387/elp+56/rcz3nNNiZl2WVnW5a8DBH2/P6+xvn
        v/Ffn57O71iWFvrBXjD00Pmki4d58vM3Cc8O3tG5778okxpbQs3UI2KKkXuuH1diKc5INNRi
        LipOBAB5gB7nhgIAAA==
X-CMS-MailID: 20180214145258epcas1p28f48284e36a444f701c5aa6e4eeab4fc
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180205142314epcas1p2c9b9bdcba33290a9528a1b24fbc849eb
X-RootMTR: 20180205142314epcas1p2c9b9bdcba33290a9528a1b24fbc849eb
References: <20180205142230.9755-1-s.nawrocki@samsung.com>
        <CGME20180205142314epcas1p2c9b9bdcba33290a9528a1b24fbc849eb@epcas1p2.samsung.com>
        <20180205142230.9755-3-s.nawrocki@samsung.com> <5A792A2B.60603@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2018 05:08 AM, Chanwoo Choi wrote:
> On 2018년 02월 05일 23:22, Sylwester Nawrocki wrote:
>> The sclk_ioclk_i2s1_bclk clock is not currently handled by any driver
>> and disabling this clock by the clk core prevents proper operation
>> of the I2S1 block. CLK_IGNORE_UNUSED flag is added as a temporary fix.
>>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> ---
>>  drivers/clk/samsung/clk-exynos5433.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
>> index d74361736e64..15177f74e125 100644
>> --- a/drivers/clk/samsung/clk-exynos5433.c
>> +++ b/drivers/clk/samsung/clk-exynos5433.c
>> @@ -1680,7 +1680,7 @@ static const struct samsung_gate_clock peric_gate_clks[] __initconst = {
>>  			ENABLE_SCLK_PERIC, 11, CLK_SET_RATE_PARENT, 0),
>>  	GATE(CLK_SCLK_IOCLK_I2S1_BCLK, "sclk_ioclk_i2s1_bclk",
>>  			"ioclk_i2s1_bclk_in", ENABLE_SCLK_PERIC, 10,
>> -			CLK_SET_RATE_PARENT, 0),
>> +			CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0),
>>  	GATE(CLK_SCLK_SPDIF, "sclk_spdif", "sclk_spdif_peric",
>>  			ENABLE_SCLK_PERIC, 8, CLK_SET_RATE_PARENT, 0),
>>  	GATE(CLK_SCLK_PCM1, "sclk_pcm1", "sclk_pcm1_peric",
>>
> If any device driver handles the sclk_ioclk_i2s1_bclk on later,
> CLK_IGNORE_UNUSED will be ignored. Looks good to me.
> 
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks, I have applied the patch to clk/samsung tree.
