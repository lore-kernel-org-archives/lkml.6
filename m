Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751848AbeBBHNW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 02:13:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:35222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750773AbeBBHNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 02:13:15 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B82CA21798
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Fri, 2 Feb 2018 15:13:05 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, Ian Ray <ian.ray@ge.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6q-bx50v3: disable SD card (usdhc2)
Message-ID: <20180202071304.GD25699@dragon>
References: <20180115144424.419-1-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180115144424.419-1-sebastian.reichel@collabora.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2018 at 03:44:24PM +0100, Sebastian Reichel wrote:
> From: Ian Ray <ian.ray@ge.com>
> 
> Disable the SD card interface from devicetree.
> 
> Signed-off-by: Ian Ray <ian.ray@ge.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

I applied the patch [1] from Ian.

Shawn

[1 ]https://www.spinics.net/lists/devicetree/msg209294.html

> ---
>  arch/arm/boot/dts/imx6q-bx50v3.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6q-bx50v3.dtsi b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
> index aefce581c0c3..86cfd4481e72 100644
> --- a/arch/arm/boot/dts/imx6q-bx50v3.dtsi
> +++ b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
> @@ -328,6 +328,10 @@
>  	};
>  };
>  
> +&usdhc2 {
> +	status = "disabled";
> +};
> +
>  &usdhc4 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usdhc4>;
> -- 
> 2.15.1
> 
