Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752590AbeBFCpD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 21:45:03 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:21519 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752264AbeBFCoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 21:44:54 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180206024451epoutp0348a338a646d4ae1e179c0bf185a6298b~QnHLcVLx61630816308epoutp03C
X-AuditID: b6c32a35-879ff70000001031-06-5a7916a0f0f0
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5A7916A2.7010307@samsung.com>
Date: Tue, 06 Feb 2018 11:44:50 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-clk@vger.kernel.org
Cc: sboyd@codeaurora.org, mturquette@baylibre.com,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com
Subject: Re: [PATCH 1/3] clk: exynos5433: Extend list of available AUD_PLL
 output frequencies
In-reply-to: <20180205142230.9755-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdlhTX3eBWGWUwZVj2hYbZ6xntdj0+Bqr
        xceee6wWl3fNYbOYcX4fk8XaI3fZLS6ecrU4/Kad1eLHmW4WB06P9zda2T0u9/UyeWxeUu/R
        t2UVo8fnTXIBrFGpNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+
        AbpumTlA5ygplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJWiDQ2N9AwNzPWMjIz0TIxjrYxM
        gUoSUjO+/b3GXvCZt+LrnZ9MDYxzuLsYOTkkBEwkfryYyQhiCwnsYJR4vt2hi5ELyP7OKPHx
        6lI2mKLL/2ewQCQ2MEo035nABJLgFRCU+DH5HlCCg4NZQF7iyKVskDCzgKbE1t3r2SGG3mOU
        OHSOF6SEV0BL4vAxRZAwi4CqxPn311lBbDag8P4XN8BW8QsoSlz98RjsHlGBCImd87+xg7SK
        CHhJzGvQBbmAWeASo8Tt9+1gNcIC8RL7Hp4EW8UpYC2xu+URO0iRhMB9NonHS1axQNzvIrF4
        1iaoX4QlXh3fAjZUQkBa4tJRW4j6dkaJ9r3zmCGcKYwS567fY4JoMJZ4trCLCeIxPol3X3tY
        IZp5JTrahCBKPCS+nJvOCmE7Srz/twAaVn2MEqffnmSZwCg3Cym4ZiGCaxZScC1gZF7FKJZa
        UJybnlpsWGCoV5yYW1yal66XnJ+7iRGc/LRMdzBOOedziFGAg1GJh1cgoyJKiDWxrLgy9xCj
        BAezkgiv0/XyKCHelMTKqtSi/Pii0pzU4kOMpsDwnsgsJZqcD0zMeSXxhiaWBiZmRsDEZWlo
        qCTOGxDgEiUkkJ5YkpqdmlqQWgTTx8TBKdXAuCDaZrNiJLf+mTWKskosX0U5zy3secaxRuVO
        k+HG5PenlzYpRE5SOCHIkbzCm5N7k+s2RR6f668Sus+6TmaJ7cwPXZf5858M8/WHh1dW227k
        PuW2T5qZ2aMp+r2KbPjM6z9t0ze/ED06OdDgZIvt6oQ2c/vNxn5n/1+69PrsHM6fhsCMkK6s
        xFKckWioxVxUnAgAC8cTp5QDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsVy+t9jQd0FYpVRBrf/SFpsnLGe1WLT42us
        Fh977rFaXN41h81ixvl9TBZrj9xlt7h4ytXi8Jt2VosfZ7pZHDg93t9oZfe43NfL5LF5Sb1H
        35ZVjB6fN8kFsEZx2aSk5mSWpRbp2yVwZXz7e4294DNvxdc7P5kaGOdwdzFyckgImEhc/j+D
        pYuRi0NIYB2jxJZrHxlBErwCghI/Jt8DSnBwMAvISxy5lA0SZhZQl5g0bxEzRP0DRokFB/uZ
        QWp4BbQkDh9TBKlhEVCVOP/+OiuIzQYU3v/iBhuIzS+gKHH1x2NGkHJRgQiJ7hOVIKaIgJfE
        vAZdkInMApcYJU5v3AfWKiwQL7Hv4Ul2iFUTGCX6by8CO41TwFpid8sj9gmMArOQXDoL4dJZ
        SC5dwMi8ilEytaA4Nz232KjAMC+1XK84Mbe4NC9dLzk/dxMjMPC3Hdbq28F4f0n8IUYBDkYl
        Ht6MrIooIdbEsuLK3EOMEhzMSiK8TtfLo4R4UxIrq1KL8uOLSnNSiw8xSnOwKInz3s47Fikk
        kJ5YkpqdmlqQWgSTZeLglGpgNPpUmrHQ6PMBHrEb1Rfl5z3WUlXgFmdP33Dm232tG/qXXxoF
        Sx13izzSMT+ck1v596zVZgJfK/55qqmkvJZm/GrQonIsX0X7ssyf6W/LpnRvaJ6+ymJT3Q1F
        40b9RuMauxJmd81fXdIrL7iWswo0terFsm8s7Mk4I3Fravfl5/4cyiwmFXeVWIozEg21mIuK
        EwGRLibVeAIAAA==
X-CMS-MailID: 20180206024448epcas1p39e7de92af12365f06840f17610d31754
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180205142252epcas1p4471e32e2b513806420c64b323af2ffa6
X-RootMTR: 20180205142252epcas1p4471e32e2b513806420c64b323af2ffa6
References: <CGME20180205142252epcas1p4471e32e2b513806420c64b323af2ffa6@epcas1p4.samsung.com>
        <20180205142230.9755-1-s.nawrocki@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sylwester,

When I developed the clk-exynos5433.c I referred to the following description.
TRM specified that "Samsung recommends only the values
between 252MH ~ 400MHz in the PMS2460X PMS value" for aud_pll.

It looks like that you refer to clk-exynos5420.c driver.
But, I'm wondering exynos5433 might not guarantee the additional clock
of this patch as the stable clock.

On 2018년 02월 05일 23:22, Sylwester Nawrocki wrote:
> Add more definitions to the exynos5433_aud_pll_rates table so the
> AUD_PLL can be used as a root clock source for the I2S1 and the HDMI
> interface.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5433.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
> index db270908037a..74b70ddab4d6 100644
> --- a/drivers/clk/samsung/clk-exynos5433.c
> +++ b/drivers/clk/samsung/clk-exynos5433.c
> @@ -765,6 +765,14 @@ static const struct samsung_pll_rate_table exynos5433_aud_pll_rates[] __initcons
>  	PLL_36XX_RATE(294912000U,  98, 1, 3,  19923),
>  	PLL_36XX_RATE(288000000U,  96, 1, 3,      0),
>  	PLL_36XX_RATE(252000000U,  84, 1, 3,      0),
> +	PLL_36XX_RATE(200000000U, 200, 3, 3,      0),
> +	PLL_36XX_RATE(196608001U, 197, 3, 3, -25690),
> +	PLL_36XX_RATE(180633609U, 301, 5, 3,   3671),
> +	PLL_36XX_RATE(131072006U, 131, 3, 3,   4719),
> +	PLL_36XX_RATE(100000000U, 200, 3, 4,      0),
> +	PLL_36XX_RATE(65536003U,  131, 3, 4,   4719),
> +	PLL_36XX_RATE(49152000U,  197, 3, 5, -25690),
> +	PLL_36XX_RATE(32768001U,  131, 3, 5,   4719),
>  	{ /* sentinel */ }
>  };
> 
> --
> 2.14.2
> 
> 
> 

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
