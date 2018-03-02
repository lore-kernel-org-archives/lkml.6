Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936226AbeCBPmU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 10:42:20 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35216 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934173AbeCBPmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 10:42:17 -0500
X-Google-Smtp-Source: AG47ELseZZoS8Iyh8sDP+21IGx4KLWkx6Aq++eu0gP2pmDiByBp1o4JWsbj/cYoyUdN2l9JSRBzS9Q==
Date: Fri, 2 Mar 2018 09:42:15 -0600
From: Rob Herring <robh@kernel.org>
To: sean.wang@mediatek.com
Cc: matthias.bgg@gmail.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 16/19] arm: dts: mt7623: fixup available memory size
 on bananapi-r2
Message-ID: <20180302154215.xr3b2zlmuojw5i6l@rob-hp-laptop>
References: <cover.1519378871.git.sean.wang@mediatek.com>
 <e49485aac14bec85c14514c1953f8d7ea5401695.1519378872.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e49485aac14bec85c14514c1953f8d7ea5401695.1519378872.git.sean.wang@mediatek.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 06:16:36PM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> There is 2GB DDR3 available on bananapi-r2 board as [1] specified.
> 
> [1] http://www.banana-pi.org/r2.html
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> index 140ff78..3e8d02c 100644
> --- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> +++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> @@ -38,6 +38,11 @@
>  			default-state = "off";
>  		};
>  	};
> +
> +	memory {

Unit address?

> +		device_type = "memory";
> +		reg = <0 0x80000000 0 0x80000000>;
> +	};
>  };
>  
>  &afe {
> -- 
> 2.7.4
> 
