Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A10C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E7EB2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550781655;
	bh=kxMFmDnojVNjAj0MDwlaOlC8Zy/gwVqw8RZhK2RvIk4=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=DeIWGiCNgSBseGRha7cL65vrj/+N7wCeId5X2m7IWZv8lp1VTYbjrhpQV64WmUiMt
	 dD8lHFYEKyzmbwTdpcHTstDCD9ZTeZafhApet+dl/MoLO6gGd5jxXiOqAaS0QNJv+C
	 9jNQr97Bt6edowKh9xeqXYs44uMtr9OYzF2XAAqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfBUUky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 15:40:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:43346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbfBUUkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 15:40:53 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D331D20823;
        Thu, 21 Feb 2019 20:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550781652;
        bh=kxMFmDnojVNjAj0MDwlaOlC8Zy/gwVqw8RZhK2RvIk4=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=Cdu92N5QvZZUoF1atUl2tHCUzjQjuHGooDn9lnYS4cEUEOUdOhBuqHZUUmPyDABt7
         ICDcSO4xB816rawAUOAMhDnxTG0FV7Wq/7Ghz75Dpk7PaiAFt2wQ6rPjPjAX+bppgz
         X1sJ5DXKMJU5C39gytiLwCvVeDPCevfmrC+qIExM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/3] dt-bindings: imx8mq-clock: Add the missing ARM clock
Message-ID: <155078165204.77512.3168550625470285332@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1550252913-24532-1-git-send-email-abel.vesa@nxp.com> <1550252913-24532-3-git-send-email-abel.vesa@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1550252913-24532-3-git-send-email-abel.vesa@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Angus Ainslie <angus.ainslie@puri.sm>,
        Lucas Stach <l.stach@pengutronix.de>,
        Mike Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Anson Huang <anson.huang@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abel.vesa@nxp.com>
Date:   Thu, 21 Feb 2019 12:40:52 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2019-02-15 09:48:45)
> Add the missing ARM clock which will be used by cpufreq
>=20
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  include/dt-bindings/clock/imx8mq-clock.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/dt-bindings/clock/imx8mq-clock.h b/include/dt-bindin=
gs/clock/imx8mq-clock.h
> index 04f7ac3..47c790c 100644
> --- a/include/dt-bindings/clock/imx8mq-clock.h
> +++ b/include/dt-bindings/clock/imx8mq-clock.h
> @@ -391,5 +391,7 @@
> =20
>  #define IMX8MQ_CLK_NAND_USDHC_BUS_RAWNAND_CLK  267
> =20
> -#define IMX8MQ_CLK_END                         268
> +#define IMX8MQ_CLK_ARM                         268
> +

This conflicts with Fabio's patch. And also depends on rc6 material that
seems to have gone through a different tree than clk tree. I'm just
going to fix the numbering.
