Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967026AbeBNKCA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 05:02:00 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:60442 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966706AbeBNKB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 05:01:58 -0500
Date: Wed, 14 Feb 2018 11:01:53 +0100
From: Simon Horman <horms@verge.net.au>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: geert@linux-m68k.org, magnus.damm@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/15] Documentation: devicetree: R-Car M3-N SoC DT
 bindings
Message-ID: <20180214100150.dv2fkffussrfqkme@verge.net.au>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org>
 <1518515162-23663-2-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518515162-23663-2-git-send-email-jacopo+renesas@jmondi.org>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 10:45:48AM +0100, Jacopo Mondi wrote:
> Add device tree bindings documentation for Renesas R-Car M3-N (r8a77965)
> SoC.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Thanks, this looks fine to me but I think the subject should be updated to

dt-bindings: arm: document R8A77965 SoC bindings

I'll let this sit for a few days to see if any other review is forthcoming.

> ---
>  Documentation/devicetree/bindings/arm/shmobile.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
> index 5c3af7e..7eb4830 100644
> --- a/Documentation/devicetree/bindings/arm/shmobile.txt
> +++ b/Documentation/devicetree/bindings/arm/shmobile.txt
> @@ -39,6 +39,8 @@ SoCs:
>      compatible = "renesas,r8a7795"
>    - R-Car M3-W (R8A77960)
>      compatible = "renesas,r8a7796"
> +  - R-Car M3-N (R8A77965)
> +    compatible = "renesas,r8a77965"
>    - R-Car V3M (R8A77970)
>      compatible = "renesas,r8a77970"
>    - R-Car D3 (R8A77995)
> -- 
> 2.7.4
> 
