Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752517AbeBFEIW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 23:08:22 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:64336 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752165AbeBFEIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 23:08:12 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180206040810epoutp02661cf4479cd14fb36daa4f30f7e39b8f~QoP63ctu90853208532epoutp02a
X-AuditID: b6c32a47-187ff7000000100c-43-5a792a29ae82
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5A792A2B.60603@samsung.com>
Date: Tue, 06 Feb 2018 13:08:11 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-clk@vger.kernel.org
Cc: sboyd@codeaurora.org, mturquette@baylibre.com,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com
Subject: Re: [PATCH 3/3] clk: exynos5433: Add CLK_IGNORE_UNUSED flag to
 sclk_ioclk_i2s1_bclk
In-reply-to: <20180205142230.9755-3-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeWyLcRjH8+vb4y3KT12PCeoNiVVaa9etr2PiGMqGJv6ROrrX9ku7rFf6
        tmOOWMRMhrG4lk3mjLAYs3VVYxbbEibOMTZiQkUMCUJsWVxt3wr/Pcfnub55aEpZJE2gc10+
        4nVxDkY6SBxsTTRqEtUFlqTaxunspfKLErYu/ETCftnTI2EfNR6VsuX3r4vYmrYXMvbh7YVs
        68diCdt/Z7d4rtz0qatIZnpUuldkqj+9zVQaqEamr3UTzBILmW0nXA7xqogr252T67KlMRkr
        rQusKalJOo1uBmtkVC7OSdKY9EyzZlGuI7IOo8rnHP5IyMzxPDN9zmyv2+8jKrub96Uxq3U6
        vVaXZNTq9XqtIXntTH1KBMki9n3d5WLPkcEbGxveoEIUkpcgOQ3YAN0361EJGkQrcQjBk7Kf
        lOD0IQieei/7S3XePRdPXEUw0NUpiiYUeDj0H+gRlyCapvBEaOvIi4YpnAgNVy/KBL4HQcfh
        ABL4qfDqR680aovxFAg2d0qithSrofldVyw+DE+Czv5wjB+FV8GVY99l0f4j8VKoKtREe1K4
        A8HzT8UxZgReB+HzTbFF5XgW1AxUxgYDfimFQxdeI+GCdGhvOCsS7BHw/mYgftk4eFt9CQkF
        xQiKm6oowTmI4N7TnnhFMrw9USISbhsKu1p/xlYCrIBdO5UCYoKHZe3xpvOgtrE+LlczglCo
        l9qPJlT8p1jFP8Uq/lPsOKKq0Wji4Z02wus9yVqec/J+l02b7XbWodgLqheHUPBeZgvCNGKG
        KLB9o0Up4fL5AmcLAppiRirmP91gUSpyuIJNxOu2ev0OwreglIjgZVTCqGx35KFdPqvOMCPJ
        kJqqN6aykRcboygyp1uU2Mb5SB4hHuL9Wyei5QmFSJp1MuivnJy3FFWy2w68CnryunYuvKGc
        uLh7K9lqXD7Jxuq2Z2WE863mN+3XyjWM3uH/NWTJtMlzHqx5vKLq2Sp76Rnlg8DYl2f3NVvT
        V1vCGbdrKqoK19Zt7h0uCqv62kKXv2UeNTT1LdsxELgzXr0pYcut36XJtWg9Hjz68IfPaYyY
        t3M6NeXluT9oOnmtmAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsVy+t9jAV1NrcoogwWN4hYbZ6xntdj0+Bqr
        xceee6wWl3fNYbOYcX4fk8XaI3fZLS6ecrU4/Kad1eLHmW4WB06P9zda2T0u9/UyeWxeUu/R
        t2UVo8fnTXIBrFFcNimpOZllqUX6dglcGf03Z7AUTOeu2LX1CWMD4w7OLkZODgkBE4mrZ1cy
        dzFycQgJ7GSUWPf4CQtIgldAUOLH5HtANgcHs4C8xJFL2SBhZgF1iUnzFkHVP2CUOLz2BDNE
        vYbEwz8v2UBsFgFViW37r7KC2GwCWhL7X9wAi/MLKEpc/fGYEWSmqECERPeJShBTRMBLYl6D
        LshIZoFLjBKnN+4DaxUWiJN4vGYvO8Su/YwSUw4cZARJcApYS6z9NZt9AqPALCSnzkI4dRaS
        UxcwMq9ilEwtKM5Nzy02KjDKSy3XK07MLS7NS9dLzs/dxAgM/W2Htfp3MD5eEn+IUYCDUYmH
        VyCjIkqINbGsuDL3EKMEB7OSCK/T9fIoId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rz8+ccihQTS
        E0tSs1NTC1KLYLJMHJxSDYy2k9bEvy48YCJrV8Xy9FMsc/ykri3sPYI7kx9ae8y5fULjHrMN
        303lxOOLNrfv63pwb8KGiXH2z2v9XqU4r+8Su1/+/7bAbB7tJW2LzHleVc5ft/h7w7rnxi2G
        6v9+rd7sJjNPO/liq/7CDqk7ijHLF61TfWOsvMQv98xL664YLs1nBwR1u2cqsRRnJBpqMRcV
        JwIAvTKH3XkCAAA=
X-CMS-MailID: 20180206040809epcas2p43c489752ec7124c3b426b9b2b1966119
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180205142314epcas1p2c9b9bdcba33290a9528a1b24fbc849eb
X-RootMTR: 20180205142314epcas1p2c9b9bdcba33290a9528a1b24fbc849eb
References: <20180205142230.9755-1-s.nawrocki@samsung.com>
        <CGME20180205142314epcas1p2c9b9bdcba33290a9528a1b24fbc849eb@epcas1p2.samsung.com>
        <20180205142230.9755-3-s.nawrocki@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018년 02월 05일 23:22, Sylwester Nawrocki wrote:
> The sclk_ioclk_i2s1_bclk clock is not currently handled by any driver
> and disabling this clock by the clk core prevents proper operation
> of the I2S1 block. CLK_IGNORE_UNUSED flag is added as a temporary fix.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5433.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
> index d74361736e64..15177f74e125 100644
> --- a/drivers/clk/samsung/clk-exynos5433.c
> +++ b/drivers/clk/samsung/clk-exynos5433.c
> @@ -1680,7 +1680,7 @@ static const struct samsung_gate_clock peric_gate_clks[] __initconst = {
>  			ENABLE_SCLK_PERIC, 11, CLK_SET_RATE_PARENT, 0),
>  	GATE(CLK_SCLK_IOCLK_I2S1_BCLK, "sclk_ioclk_i2s1_bclk",
>  			"ioclk_i2s1_bclk_in", ENABLE_SCLK_PERIC, 10,
> -			CLK_SET_RATE_PARENT, 0),
> +			CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0),
>  	GATE(CLK_SCLK_SPDIF, "sclk_spdif", "sclk_spdif_peric",
>  			ENABLE_SCLK_PERIC, 8, CLK_SET_RATE_PARENT, 0),
>  	GATE(CLK_SCLK_PCM1, "sclk_pcm1", "sclk_pcm1_peric",
> 

If any device driver handles the sclk_ioclk_i2s1_bclk on later,
CLK_IGNORE_UNUSED will be ignored. Looks good to me.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
