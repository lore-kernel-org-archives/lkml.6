Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD0DC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D88205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D88205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbeKBBA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:00:28 -0400
Received: from gloria.sntech.de ([185.11.138.130]:39940 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728964AbeKBBA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 21:00:28 -0400
Received: from ip5f5a86be.dynamic.kabel-deutschland.de ([95.90.134.190] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gIFL2-0001tT-VZ; Thu, 01 Nov 2018 16:56:53 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: rk3x: fix some typo
Date:   Thu, 01 Nov 2018 16:56:52 +0100
Message-ID: <5544442.bXqbKBZQMR@diego>
In-Reply-To: <20181101153749.22935-1-tiny.windzz@gmail.com>
References: <20181101153749.22935-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Donnerstag, 1. November 2018, 16:37:49 CET schrieb Yangtao Li:
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

while the changes really are pretty self-explanatory, it is always
nice to describe changes in a real commit message, like

Fix multiple instances of a misspelled "Calculates".

Change itself looks good, so
Reviewed-by: Heiko Stuebner <heiko@sntech.de>


Thanks
Heiko

> ---
>  drivers/i2c/busses/i2c-rk3x.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
> index b8a2728dd4b6..fe347e8e2a23 100644
> --- a/drivers/i2c/busses/i2c-rk3x.c
> +++ b/drivers/i2c/busses/i2c-rk3x.c
> @@ -555,7 +555,7 @@ static const struct i2c_spec_values
> *rk3x_i2c_get_spec(unsigned int speed) *
>   * @clk_rate: I2C input clock rate
>   * @t: Known I2C timing information
> - * @t_calc: Caculated rk3x private timings that would be written into regs
> + * @t_calc: Calculated rk3x private timings that would be written into regs
> *
>   * Returns: 0 on success, -EINVAL if the goal SCL rate is too slow. In that
> case * a best-effort divider value is returned in divs. If the target rate
> is @@ -716,7 +716,7 @@ static int rk3x_i2c_v0_calc_timings(unsigned long
> clk_rate, *
>   * @clk_rate: I2C input clock rate
>   * @t: Known I2C timing information
> - * @t_calc: Caculated rk3x private timings that would be written into regs
> + * @t_calc: Calculated rk3x private timings that would be written into regs
> *
>   * Returns: 0 on success, -EINVAL if the goal SCL rate is too slow. In that
> case * a best-effort divider value is returned in divs. If the target rate
> is




