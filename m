Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDBDC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA1D20820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA1D20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390487AbeKWSif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 13:38:35 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37008 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387556AbeKWSif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 13:38:35 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAN7tPKZ129774;
        Fri, 23 Nov 2018 01:55:25 -0600
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAN7tPUr090289
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 23 Nov 2018 01:55:25 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 23
 Nov 2018 01:55:25 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 23 Nov 2018 01:55:25 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAN7tNHS006024;
        Fri, 23 Nov 2018 01:55:24 -0600
Subject: Re: [PATCH] phy: renesas: rcar-gen3-usb2: follow the hardware manual
 procedure
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
References: <1542787663-32142-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <f9a22d1d-6b40-0182-0be2-976494c95063@ti.com>
Date:   Fri, 23 Nov 2018 13:25:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542787663-32142-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21/11/18 1:40 PM, Yoshihiro Shimoda wrote:
> This patch modifies rcar_gen3_init_otg() procedure to follow Figure
> 73.4 of "R-Car Series, 3rd Generation User's Manual: Hardware Rev.1.00".
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  This patch is based on the latest linux-phy / next branch
> (commit id = 0eb86fa77f0f0c81631a030f10679a45c05df33a).

This patch has some weird characters which I saw while applying.

You can see "=20", =3D in the raw format
https://lore.kernel.org/lkml/1542787663-32142-1-git-send-email-yoshihiro.shimoda.uh@renesas.com/raw

Please fix and repost the patch.

Thanks
Kishon
> 
>  drivers/phy/renesas/phy-rcar-gen3-usb2.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> index d0f412c..a9e53e8 100644
> --- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> +++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> @@ -307,16 +307,21 @@ static void rcar_gen3_init_otg(struct rcar_gen3_chan *ch)
>  	void __iomem *usb2_base = ch->base;
>  	u32 val;
>  
> +	rcar_gen3_set_linectrl(ch, 0, 1);
> +	val = readl(usb2_base + USB2_LINECTRL1);
> +	writel(val | USB2_LINECTRL1_DPRPD_EN | USB2_LINECTRL1_DMRPD_EN,
> +	       usb2_base + USB2_LINECTRL1);
> +
>  	val = readl(usb2_base + USB2_VBCTRL);
>  	writel(val | USB2_VBCTRL_DRVVBUSSEL, usb2_base + USB2_VBCTRL);
> -	writel(USB2_OBINT_BITS, usb2_base + USB2_OBINTSTA);
> -	rcar_gen3_control_otg_irq(ch, 1);
>  	val = readl(usb2_base + USB2_ADPCTRL);
>  	writel(val | USB2_ADPCTRL_IDPULLUP, usb2_base + USB2_ADPCTRL);
> -	val = readl(usb2_base + USB2_LINECTRL1);
> -	rcar_gen3_set_linectrl(ch, 0, 0);
> -	writel(val | USB2_LINECTRL1_DPRPD_EN | USB2_LINECTRL1_DMRPD_EN,
> -	       usb2_base + USB2_LINECTRL1);
> +
> +	msleep(20);
> +
> +	writel(USB2_OBINT_BITS, usb2_base + USB2_OBINTSTA);
> +
> +	rcar_gen3_control_otg_irq(ch, 1);
>  
>  	rcar_gen3_device_recognition(ch);
>  }
> 
