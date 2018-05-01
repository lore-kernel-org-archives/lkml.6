Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756045AbeEAP0U (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 11:26:20 -0400
Received: from muru.com ([72.249.23.125]:39474 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755692AbeEAP0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 11:26:18 -0400
Date: Tue, 1 May 2018 08:26:15 -0700
From: Tony Lindgren <tony@atomide.com>
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, bcousson@baylibre.com, robh+dt@kernel.org,
        mark.rutland@arm.com, paul@pwsan.com, lokeshvutla@ti.com,
        linux@armlinux.org.uk
Subject: Re: [PATCH 1/3] ARM: dra762: hwmod: Add MCAN support
Message-ID: <20180501152615.GB98604@atomide.com>
References: <1523181542-3770-1-git-send-email-faiz_abbas@ti.com>
 <1523181542-3770-2-git-send-email-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523181542-3770-2-git-send-email-faiz_abbas@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Faiz Abbas <faiz_abbas@ti.com> [180408 09:59]:
> From: Lokesh Vutla <lokeshvutla@ti.com>
> 
> Add MCAN hwmod data and register it for dra762 silicons.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 32 +++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> index 62352d1..a2cd7f8 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> @@ -1356,6 +1356,29 @@ static struct omap_hwmod dra7xx_mailbox13_hwmod = {
>  };
>  
>  /*
> + * 'mcan' class
> + *
> + */
> +static struct omap_hwmod_class dra76x_mcan_hwmod_class = {
> +	.name	= "mcan",
> +};

Looks like you're missing the related struct omap_hwmod_class_sysconfig
entry for this with the rev and sysconfig registers.

Regards,

Tony
