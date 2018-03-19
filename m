Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755448AbeCSJrf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 05:47:35 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:31637 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755291AbeCSJre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 05:47:34 -0400
Subject: Re: [PATCH net-next 04/10] phy: add 2.5G SGMII mode to the phy_mode
 enum
To: Antoine Tenart <antoine.tenart@bootlin.com>, <davem@davemloft.net>,
        <linux@armlinux.org.uk>, <gregory.clement@bootlin.com>,
        <andrew@lunn.ch>, <jason@lakedaemon.net>,
        <sebastian.hesselbarth@gmail.com>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
 <20180316103351.16616-5-antoine.tenart@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <thomas.petazzoni@bootlin.com>, <maxime.chevallier@bootlin.com>,
        <miquel.raynal@bootlin.com>, <nadavh@marvell.com>,
        <stefanc@marvell.com>, <ymarkman@marvell.com>, <mw@semihalf.com>,
        <linux-arm-kernel@lists.infradead.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <8b8ffdcb-f365-09c6-24f2-7fcebe3b5f76@ti.com>
Date: Mon, 19 Mar 2018 15:16:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20180316103351.16616-5-antoine.tenart@bootlin.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday 16 March 2018 04:03 PM, Antoine Tenart wrote:
> This patch adds one more generic PHY mode to the phy_mode enum, to allow
> configuring generic PHYs to the 2.5G SGMII mode by using the set_mode
> callback.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  include/linux/phy/phy.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index 4f8423a948d5..5a80e9de3686 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -28,6 +28,7 @@ enum phy_mode {
>  	PHY_MODE_USB_DEVICE,
>  	PHY_MODE_USB_OTG,
>  	PHY_MODE_SGMII,
> +	PHY_MODE_2500SGMII,
>  	PHY_MODE_10GKR,
>  	PHY_MODE_UFS_HS_A,
>  	PHY_MODE_UFS_HS_B,
> 
