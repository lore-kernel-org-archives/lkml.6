Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EA0C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 06:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7821B208F7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 06:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7821B208F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbeHWKVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 06:21:34 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:36057 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeHWKVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 06:21:34 -0400
Received: from [192.168.178.69] ([109.104.46.209]) by mrelayeu.kundenserver.de
 (mreue102 [212.227.15.183]) with ESMTPSA (Nemesis) id
 0MFtVW-1fduKD2BwE-00Ewjf; Thu, 23 Aug 2018 08:52:59 +0200
Subject: Re: [PATCH] ARM: dts: imx6ull: correct machine model name
To:     Anson Huang <Anson.Huang@nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
References: <1535005849-14046-1-git-send-email-Anson.Huang@nxp.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <69b53468-ce73-9eeb-e11a-b6fa012a7ea6@i2se.com>
Date:   Thu, 23 Aug 2018 08:52:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535005849-14046-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:xEYaJgbQIZNhVvzY5n9+dRFrsnJ2NcS5qIOcYFW6s4zqqudnp1y
 UMEqP/aR0azW2Jzb7j2WRs6tlrOUAEptoTrZBFV5rB2h/DW7Y4dA0QKcMqT/VxPI0DGyjw7
 PzPHSDXv3qcHS3/vmqG75FHtKqrDgEluVDWO0HSYkZzmyZ7xSNvM16DSLEcH/8ow6p5hcHs
 k15o4liWMVnhjlq4caBzg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:avIY74tb4A8=:PVWfNU0GC3BnorOp8v4gUX
 LggT6pjHxUEdHZDsbqnEAm/6/4lcwMkiogWK6gj8mqcK+TWgIJ+b/1+An8QC4YovawfzPIlxz
 PSHIjgsbMPFVTWktMXroa8nJGKjGp01hUslZMoTJZSXjwqUFyj4w2l6fDFgf3KuwvysKmnUgz
 Y8ou0/qcx3EYdaPOKNYMaL8IhD18XE0C/F+aZY+fpLazoRaJb3aQsUIZWHseHQljm/dtKrmId
 uSgOIBc6Ja9E86/9irGMcdRhsZnfMxlcDodeRO4scH7pCEc2NcSd6O2ls98BQDDnSQbr+HLA+
 2H/ZlvNtbSyoW5JMkrnV6gOOgbuUkRS3GUXJW6f4OdhEgkLFqqJltcZjHQhnhmwTOj02fpZCC
 yY7Qk/t0027dILV95YPGBJK1w30pXi2y9POdhlcldUO2jxSOwkG3PBy8+Jti8GadYNf32HfDm
 ecJnmeFVgSdT36zArGze6dWYLg1FOZ4ghCUgN22jx4V4Lxr1WwePbOg9xqXR0ZLEfOM60C5dr
 TXB/4AkMlq6V1Xcw6DAAARWRaYNGrCWXMT0k/Qtokf3UDNDaBESUX6k1cUgP1/OQKLXZvCB3L
 Nm0xkVRnl05Z6MsFxDiMK3yV+LaEoIEA2ZGQxJKrwo5d/1K15QHPTgAIhfAfJs2/tdBA+q6Zm
 ZT1e7xbq4b6x3NfSvWsVYPAgSWBrOCf4TRMcQgRM368hKirFbULN/WBuAr5IMYthYTvom++Fh
 pTeJJGdGk1DRBUbh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,


Am 23.08.2018 um 08:30 schrieb Anson Huang:
> i.MX6ULL is a lite version of i.MX6UL, its full name
> is i.MX6 UltraLiteLite, NOT UlltraLite.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm/boot/dts/imx6ull-14x14-evk.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/imx6ull-14x14-evk.dts b/arch/arm/boot/dts/imx6ull-14x14-evk.dts
> index 30ef603..0ba6454 100644
> --- a/arch/arm/boot/dts/imx6ull-14x14-evk.dts
> +++ b/arch/arm/boot/dts/imx6ull-14x14-evk.dts
> @@ -45,7 +45,7 @@
>  #include "imx6ul-14x14-evk.dtsi"
>  
>  / {
> -	model = "Freescale i.MX6 UlltraLite 14x14 EVK Board";
> +	model = "Freescale i.MX6 UltraLiteLite 14x14 EVK Board";
>  	compatible = "fsl,imx6ull-14x14-evk", "fsl,imx6ull";
>  };
>  

looks good, but this compatible should be documented in
Documentation/devicetree/bindings/arm/fsl.txt (should be a separate patch).

Regards
Stefan

