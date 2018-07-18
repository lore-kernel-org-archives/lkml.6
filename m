Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218B2ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D948820854
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 20:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D948820854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=math.uni-bielefeld.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbeGRVMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 17:12:44 -0400
Received: from smtp.math.uni-bielefeld.de ([129.70.45.10]:60067 "EHLO
        smtp.math.uni-bielefeld.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726992AbeGRVMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 17:12:43 -0400
Received: from [192.168.0.100] (pC19F5CC7.dip0.t-ipconnect.de [193.159.92.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by smtp.math.uni-bielefeld.de (Postfix) with ESMTPSA id 4F3EF5F8F8;
        Wed, 18 Jul 2018 22:33:08 +0200 (CEST)
Subject: Re: [PATCH] clk: samsung: Remove unused
 mout_user_aclk400_mcuisp_p4x12 variable
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180718195620.5331-1-krzk@kernel.org>
From:   Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Openpgp: preference=signencrypt
Autocrypt: addr=tjakobi@math.uni-bielefeld.de; prefer-encrypt=mutual; keydata=
 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
 24xKzP1yWf7TCvc+DT6gUl4T65RXUQyTeJ0=
Message-ID: <c5e83bb8-840a-9e91-648c-4472b956c111@math.uni-bielefeld.de>
Date:   Wed, 18 Jul 2018 22:33:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.7.0
MIME-Version: 1.0
In-Reply-To: <20180718195620.5331-1-krzk@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Speaking of the ISP clocks driver, I wonder why this one was never merged?
https://patches.linaro.org/patch/115531/

- Tobias


Krzysztof Kozlowski wrote:
> Remove unused 'mout_user_aclk400_mcuisp_p4x12' variable to fix GCC warning:
> 
>     drivers/clk/samsung/clk-exynos4412-isp.c:40:27: warning:
>         'mout_user_aclk400_mcuisp_p4x12' defined but not used [-Wunused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/clk/samsung/clk-exynos4412-isp.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos4412-isp.c b/drivers/clk/samsung/clk-exynos4412-isp.c
> index d5f1ccb36300..cfaa057035ad 100644
> --- a/drivers/clk/samsung/clk-exynos4412-isp.c
> +++ b/drivers/clk/samsung/clk-exynos4412-isp.c
> @@ -37,8 +37,6 @@ static const unsigned long exynos4x12_clk_isp_save[] __initconst = {
>  	E4X12_GATE_ISP1,
>  };
>  
> -PNAME(mout_user_aclk400_mcuisp_p4x12) = { "fin_pll", "div_aclk400_mcuisp", };
> -
>  static struct samsung_div_clock exynos4x12_isp_div_clks[] = {
>  	DIV(CLK_ISP_DIV_ISP0, "div_isp0", "aclk200", E4X12_DIV_ISP0, 0, 3),
>  	DIV(CLK_ISP_DIV_ISP1, "div_isp1", "aclk200", E4X12_DIV_ISP0, 4, 3),
> 

