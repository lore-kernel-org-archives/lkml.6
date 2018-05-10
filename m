Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756847AbeEJIoW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 04:44:22 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:60752 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756379AbeEJIoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 04:44:17 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180510084414euoutp02cef2cc9c3591a69a139cc89e782abc1a~tPAg7Y6Vx1966019660euoutp02Z
X-AuditID: cbfec7f2-5ffe19c000011644-0f-5af4065cca86
Subject: Re: [PATCH 2/2] i2c: exynos5: remove pointless initializers
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
Cc: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <b69f6656-3831-86ea-5f13-fc805d86b288@samsung.com>
Date: Thu, 10 May 2018 10:44:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180509194532.28929-2-peda@axentia.se>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRjl3b27uxtOrvNjLypJi+gD0oSKS5mJCO1X5L8Yad3ypqZutjlT
        o5RBuYma2Ww2NbPUdEXW/BYdNstpNWdmkpH5Q+1DmUib6BC1bVfJf+c8zznveQ68OCIws4Px
        VGkWLZdS6SKMh3YMumyHzmNOyeG2Li5ZotKxyLszCwhps73ikMaZCTapXncC8nNPNUZW2kws
        ss9cC8jmIT1C9v1wgBie+EF/FUdsNGgw8aPheHFrfb54SLeCioffz6Jih3HXWY6EF5VEp6dm
        0/KI6Iu8lOEBA5p5j5PzouQpVgCm2EWAi0PiCHz5ZhQUAR4uIJoA1Nd1shniBNAwN4cyxAGg
        bXWRtW2xFpduqZ65Vf3NGEPsAJaZnqMelT8RBzUVP72OAOIUrJj4w/KIEKKXBVvuD3rTMeIA
        XG+dxDyYT0TDt6ZijgejxF7Y9L0K8eBA4hxU/XJxGI0fHH446w3gEkfhwuSG14sQYbDTXo0w
        WAi/zdZ6wyAxxoGTJf1uM+4mcbC3nmYq+MN5SxuHwaFws7t2q9oNOPlbhTJeNYDTa4UYszgB
        Byyf2J53EPfRLT0RzPgkNHavIMzzvvCr3Y85wReWd+i2xnyoviNg1LvhtLUdYbAQNowuY2Vg
        j35HMf2OMvodZfT/cx8D1ACEtFKRkUwrIqX09XAFlaFQSpPDL8syjMD9sz5sWP52geWxS2ZA
        4EDkw6/kOSQCNpWtyM0wA4gjogD+6oh7xE+icvNoueyCXJlOK8wgBEdFQn7i/lsSAZFMZdFp
        NJ1Jy7e3LJwbXADS9rW9y4y6apUNdWmzVKVaiVPSYA3k1mhaY1IHziyV5y+hU6wrQQuuPLUr
        qLxHcvy0zhRJa2qwupGE2PY84bWwbFmHQHt7MadwdS3no0/j6wJDiFJ2M+nYl8a0RH9TKKVN
        GKeCkufji2LlEumTdUvf5vhoVCnfMtdqNSjtIlSRQkUeROQK6h82tByAVQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xe7qRbF+iDFackbXobZrOZNH/+DWz
        xfnzG9gtNj2+xmrR8fcLo8XlXXPYLGac38dksffQfEaLlSdmMVvsvfeZ0YHLY9qB2ewem1Z1
        snnMOxnosXlJvceJ6d9ZPE6eesLi8XmTXAB7lJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYml
        nqGxeayVkamSvp1NSmpOZllqkb5dgl7GycOrWAomsles6V3M1sB4l7WLkZNDQsBE4mxPH5DN
        xSEksJRRYvHSVewQCXGJ3fPfMkPYwhJ/rnWxQRS9ZpQ4c2UbE0hCWMBFonPqMzBbRMBeYuq1
        l0wgRcwC+5gkljfMYYbo2MwosfP9GkaQKjYBTYm/m2+ygdi8AnYSR/b1gK1jEVCVWHFnNtg6
        UYEIiXvnP0HVCEqcnPmEBcTmFDCVeH3zH1icWUBd4s+8S8wQtrzE9rdzoGxxiVtP5jNNYBSa
        haR9FpKWWUhaZiFpWcDIsopRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMwTrcd+7l5B+OljcGH
        GAU4GJV4eGdwfY4SYk0sK67MPcQowcGsJML74xxQiDclsbIqtSg/vqg0J7X4EKMp0HMTmaVE
        k/OBKSSvJN7Q1NDcwtLQ3Njc2MxCSZz3vEFllJBAemJJanZqakFqEUwfEwenVANjlM+6l+Vm
        fEm3jE2Nq9479zIwha2a3F6pVa7+41H5pAyLRwfllx/pP3vebP3X9hsJkk/6lUuaJKwmmpxS
        N+E9tXua7dObDAZlX/MmTL+V4faBMT/8SPqsj/3CZpPEnE+f1Snx+Dt1xY33N70/2n7tXpK7
        gWdBsjX7bf4qK9bTQRnrp4hENF1XYinOSDTUYi4qTgQAn6vqfOkCAAA=
X-CMS-MailID: 20180510084410eucas1p16d234eaa2ae5822029754b9529ea01ab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180510084410eucas1p16d234eaa2ae5822029754b9529ea01ab
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180509194552epcas3p4777026e41c7b34663eb11345e4f3d82d
X-RootMTR: 20180509194552epcas3p4777026e41c7b34663eb11345e4f3d82d
References: <20180509194532.28929-1-peda@axentia.se>
        <CGME20180509194552epcas3p4777026e41c7b34663eb11345e4f3d82d@epcas3p4.samsung.com>
        <20180509194532.28929-2-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.05.2018 21:45, Peter Rosin wrote:
> The variables are always assigned before use anyway.
>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/i2c/busses/i2c-exynos5.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
> index a2cbc779c33a..185fba37e830 100644
> --- a/drivers/i2c/busses/i2c-exynos5.c
> +++ b/drivers/i2c/busses/i2c-exynos5.c
> @@ -707,7 +707,7 @@ static int exynos5_i2c_xfer(struct i2c_adapter *adap,
>  			struct i2c_msg *msgs, int num)
>  {
>  	struct exynos5_i2c *i2c = adap->algo_data;
> -	int i = 0, ret = 0, stop = 0;
> +	int i, ret, stop;

I hope gcc is smart enough to not complain in case of ret.
I think you can merge both patches into one.

Regards
Andrzej

>  
>  	if (i2c->suspended) {
>  		dev_err(i2c->dev, "HS-I2C is not initialized.\n");
