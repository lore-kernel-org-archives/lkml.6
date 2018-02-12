Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932543AbeBLVqF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 16:46:05 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:22306 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932204AbeBLVqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 16:46:02 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180212214600epoutp015b31e30a8505a76b99b6bf9211a9e007~SsjQFBLk41561915619epoutp01e
X-AuditID: b6c32a46-3a9ff70000001029-af-5a820b17efef
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5A820B19.8080902@samsung.com>
Date: Tue, 13 Feb 2018 06:46:01 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-clk@vger.kernel.org
Cc: sboyd@codeaurora.org, mturquette@baylibre.com,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzk@kernel.org, b.zolnierkie@samsung.com, m.szyprowski@samsung.com
Subject: Re: [PATCH v2] clk: exynos5433: Extend list of available AUD_PLL
 output frequencies
In-reply-to: <20180212155227.20605-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdljTTFecuynKoP+ZqcXGGetZLc6f38Bu
        8bHnHqvF5V1z2CxmnN/HZLH2yF12i4unXC0Ov2lntfhxppvFgdPj/Y1Wdo/Lfb1MHptWdbJ5
        9G1ZxejxeZNcAGtUqk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKL
        T4CuW2YO0D1KCmWJOaVAoYDE4mIlfTubovzSklSFjPziElulaENDIz1DA3M9IyMjPRPjWCsj
        U6CShNSMXftXMBc84KjYcvAASwPjNPYuRk4OCQETiebZR1i7GLk4hAR2MEpcvPqBEcL5ziix
        Y/EfuKrLPV3MEIndjBJPrh1lBknwCghK/Jh8j6WLkYODWUBe4silbJAws4CmxNbd69kh6u8x
        SjxftRCshldAS+Jysy9IDYuAqsTShe/ZQGw2oPD+FzfAbH4BRYmrPx4zgtiiAhESO+d/Ywdp
        FRHwkpjXoAsykhnkhDk7j4CdICwQJ/FpWQtYPaeAjUTDz+ssIEUSAo/ZJFperGOBeMBF4ljr
        FkYIW1ji1fEtUI9JSzxbtZERoqGdUaJ97zxmCGcKo8S56/eYIKqMJZ4t7GKCeI1PouPwX7CT
        JAR4JTrahCBKPCS+rDnPBmE7Snxr/QZ2nZBAP6PEpEOqExjlZiGF1yxEeM1CCq8FjMyrGMVS
        C4pz01OLjQqM9IoTc4tL89L1kvNzNzGCU6CW2w7GJed8DjEKcDAq8fB2zG6MEmJNLCuuzD3E
        KMHBrCTC+6cZKMSbklhZlVqUH19UmpNafIjRFBjeE5mlRJPzgek5ryTe0MTSwMTMzMjczAKY
        wMR5WwNcooQE0hNLUrNTUwtSi2D6mDg4pRoYGZebXsz+UcoTdK5cLnyf3pnDphsmvlmt1556
        OCnayU6q7MaqN3NfX1A9oLTqhYtShyp3k/ihH5mi7/RvKB+boVofLXg8VdLM9axF0IOoItmG
        5h8P32z7v9/botNZ291rpk9dd0/B03P5i1w33HgWNP+c8K0d14xuneFLFg++qpdauIgvUSNS
        iaU4I9FQi7moOBEA+VBmBZcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsVy+t9jAV1x7qYogyfHOC02zljPanH+/AZ2
        i48991gtLu+aw2Yx4/w+Jou1R+6yW1w85Wpx+E07q8WPM90sDpwe72+0sntc7utl8ti0qpPN
        o2/LKkaPz5vkAlijuGxSUnMyy1KL9O0SuDJ27V/BXPCAo2LLwQMsDYzT2LsYOTkkBEwkLvd0
        MXcxcnEICexklFjx+w4rSIJXQFDix+R7LF2MHBzMAvISRy5lg4SZBdQlJs1bBFX/gFHi64Oz
        bCA1vAJaEpebfUFqWARUJZYufM8GYrMBhfe/uAFm8wsoSlz98ZgRpFxUIEKi+0QliCki4CUx
        r0EXZCKzwG5GiSUd18FOExaIk/i0rIURYtVERokvH88wgiQ4BWwkGn5eZ5nAKDALyaWzEC6d
        heTSBYzMqxglUwuKc9Nzi40KjPJSy/WKE3OLS/PS9ZLzczcxAkN/22Gt/h2Mj5fEH2IU4GBU
        4uHtmN0YJcSaWFZcmXuIUYKDWUmE908zUIg3JbGyKrUoP76oNCe1+BCjNAeLkjgvf/6xSCGB
        9MSS1OzU1ILUIpgsEwenVAPj0ZR3j21uTgxYLhkoFZE3eXLLuc7UourPvh+eTRXo0nVaLDz1
        9vP1twW2ro6RrOi+wXNsxre729cu8s6Kf1Ok1CDFfyL0wJv7vxaeX3j3mdTZ8LCSsjdTbmr/
        6Zw/796nXd2npjfu3HZCU0Hq8f2tQRtWLTLd27BXY9bH6wuaFloX77RPufJnU6YSS3FGoqEW
        c1FxIgC5w4lAeQIAAA==
X-CMS-MailID: 20180212214559epcas2p34289e55206c38d0ad4b947067f3af9af
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180212155239epcas2p34dad3d106036f65e5ee566a593a983e3
X-RootMTR: 20180212155239epcas2p34dad3d106036f65e5ee566a593a983e3
References: <CGME20180212155239epcas2p34dad3d106036f65e5ee566a593a983e3@epcas2p3.samsung.com>
        <20180212155227.20605-1-s.nawrocki@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 02월 13일 00:52, Sylwester Nawrocki wrote:
> Add one more entry to the exynos5433_aud_pll_rates table, this allows
> to support audio sample rates: 48000, 96000, 192000 Hz with minimum
> error. The M, P, S, K values re confirmed by the HW team.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5433.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
> index ebd18586e325..b08a9028653f 100644
> --- a/drivers/clk/samsung/clk-exynos5433.c
> +++ b/drivers/clk/samsung/clk-exynos5433.c
> @@ -765,6 +765,7 @@ static const struct samsung_pll_rate_table exynos5433_aud_pll_rates[] __initcons
>  	PLL_36XX_RATE(294912000U,  98, 1, 3,  19923),
>  	PLL_36XX_RATE(288000000U,  96, 1, 3,      0),
>  	PLL_36XX_RATE(252000000U,  84, 1, 3,      0),
> +	PLL_36XX_RATE(196608001U, 197, 3, 3, -25690),
>  	{ /* sentinel */ }
>  };

Looks good to me.
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
