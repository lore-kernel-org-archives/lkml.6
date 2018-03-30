Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752453AbeC3H1m (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 03:27:42 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:45833 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752384AbeC3H1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 03:27:38 -0400
Date: Fri, 30 Mar 2018 09:27:33 +0200
From: Simon Horman <horms@verge.net.au>
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, phil.edworthy@renesas.com,
        Michel Pollet <buserror+upstream@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 8/8] DT: arm: Add the RZN1D-DB Board to Renesas
 Makefile target
Message-ID: <20180330072733.z7lffttcqb6adfnu@verge.net.au>
References: <1522309629-10152-1-git-send-email-michel.pollet@bp.renesas.com>
 <1522309629-10152-9-git-send-email-michel.pollet@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522309629-10152-9-git-send-email-michel.pollet@bp.renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2018 at 08:47:04AM +0100, Michel Pollet wrote:
> This adds the newly added board to the Renesas built target
> 
> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm/boot/dts/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 8164c12..1849228 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -806,6 +806,7 @@ dtb-$(CONFIG_ARCH_RENESAS) += \
>  	r8a7793-gose.dtb \
>  	r8a7794-alt.dtb \
>  	r8a7794-silk.dtb \
> +	r9a06g032-rzn1d400-db.dtb \
>  	sh73a0-kzm9g.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += \
>  	rv1108-evb.dtb \

I think you can squash this patch into the one that adds the corresponding
dts file.
