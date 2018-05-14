Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752312AbeENUvL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 16:51:11 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:58702 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752041AbeENUvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 16:51:10 -0400
Date: Mon, 14 May 2018 22:51:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH net-next v3 7/7] MAINTAINERS: Add entry for Microsemi
 Ethernet switches
Message-ID: <20180514205105.GE1057@lunn.ch>
References: <20180514200500.2953-1-alexandre.belloni@bootlin.com>
 <20180514200500.2953-8-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514200500.2953-8-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 10:05:00PM +0200, Alexandre Belloni wrote:
> Add myself as a maintainer for the Microsemi Ethernet switches.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0a1410d5a621..b632deb3f503 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9280,6 +9280,12 @@ F:	include/linux/cciss*.h
>  F:	include/uapi/linux/cciss*.h
>  F:	Documentation/scsi/smartpqi.txt
>  
> +MICROSEMI ETHERNET SWITCH DRIVER
> +M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
> +L:	netdev@vger.kernel.org
> +S:	Supported
> +F:	drivers/net/ethernet/mscc/
> +
>  MICROSOFT SURFACE PRO 3 BUTTON DRIVER
>  M:	Chen Yu <yu.c.chen@intel.com>
>  L:	platform-driver-x86@vger.kernel.org
> -- 
> 2.17.0
> 
