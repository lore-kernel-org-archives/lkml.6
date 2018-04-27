Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934626AbeD0Opj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 10:45:39 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:39233 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934495AbeD0Opf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 10:45:35 -0400
X-Google-Smtp-Source: AB8JxZpT/0EihCPosGAQFqjkLrHsC3ZTUSSmvWZTXeCbBGAr4N1sxIGiZkk2l3DCDtX68MR1DKDtIw==
Date: Fri, 27 Apr 2018 09:45:33 -0500
From: Rob Herring <robh@kernel.org>
To: jan.tuerk@emtrion.com
Cc: Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 5/7] dt-bindings: arm: Document emtrion emCON-MX6
 bindings
Message-ID: <20180427144533.5amxarufzc2borzh@rob-hp-laptop>
References: <20180420125108.14197-1-jan.tuerk@emtrion.com>
 <20180427132445.3458-1-jan.tuerk@emtrion.com>
 <20180427132445.3458-6-jan.tuerk@emtrion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427132445.3458-6-jan.tuerk@emtrion.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 03:24:40PM +0200, jan.tuerk@emtrion.com wrote:
> From: Jan Tuerk <jan.tuerk@emtrion.com>
> 
> Document the compatible strings for emtrion emCON-MX6 SoM's.
> 
> Signed-off-by: Jan Tuerk <jan.tuerk@emtrion.com>
> ---
> For v4:
>  - separate patch for the emtrion emCON-MX6 DT-bindings
> 
>  Documentation/devicetree/bindings/arm/emtrion.txt | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/emtrion.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/emtrion.txt b/Documentation/devicetree/bindings/arm/emtrion.txt
> new file mode 100644
> index 000000000000..3ff6c6c2034d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/emtrion.txt
> @@ -0,0 +1,13 @@
> +Emtrion Devicetree Bindings
> +===========================
> +
> +emCON Series:
> +-------------
> +
> +Required root node properties
> +	- compatible:
> +	- "emtrion,emcon-mx6", "fsl,imx6q", "fsl,imx6dl"; : emCON-MX6 Generic SoM

You can't have both a 6Q and 6DL present and I don't think 6Q is a 
perfect superset of 6DL.

> +	- "emtrion,emcon-mx6", "fsl,imx6q"; 		: emCON-MX6D or emCON-MX6Q SoM
> +	- "emtrion,emcon-mx6-avari", "fsl,imx6q";	: emCON-MX6D or emCON-MX6Q SoM on Avari Base
> +	- "emtrion,emcon-mx6", "fsl,imx6dl"; 		: emCON-MX6S or emCON-MX6DL SoM
> +	- "emtrion,emcon-mx6-avari", "fsl,imx6dl";	: emCON-MX6S or emCON-MX6DL SoM on Avari Base
> -- 
> 2.11.0
> 
