Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D55AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8A120820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D8A120820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393892AbeKWUQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:16:34 -0500
Received: from mail.bootlin.com ([62.4.15.54]:50614 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387987AbeKWUQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:16:34 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C9C38215DD; Fri, 23 Nov 2018 10:33:04 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id EAEAF20D29;
        Fri, 23 Nov 2018 10:27:30 +0100 (CET)
Date:   Fri, 23 Nov 2018 10:27:30 +0100
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>
Subject: Re: [PATCH v2] phy: mvebu-cp110-comphy: fix spelling in structure
 name
Message-ID: <20181123092730.GA10195@kwain>
References: <20181123092115.20617-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181123092115.20617-1-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On Fri, Nov 23, 2018 at 10:21:15AM +0100, Miquel Raynal wrote:
> Rename the mvebu_comhy_conf structure to be mvebu_comphy_conf, which is
> probably what the original author meant.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Acked-by: Antoine Tenart <antoine.tenart@bootlin.com>

Thanks!
Antoine

> ---
> 
> Changes since v1
> ================
> * Removed the Fixes: tag after Antoine's request.
> 
> 
>  drivers/phy/marvell/phy-mvebu-cp110-comphy.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
> index 86a5f7b9448b..31b9a1c18345 100644
> --- a/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
> +++ b/drivers/phy/marvell/phy-mvebu-cp110-comphy.c
> @@ -114,7 +114,7 @@
>  #define MVEBU_COMPHY_LANES	6
>  #define MVEBU_COMPHY_PORTS	3
>  
> -struct mvebu_comhy_conf {
> +struct mvebu_comphy_conf {
>  	enum phy_mode mode;
>  	unsigned lane;
>  	unsigned port;
> @@ -129,7 +129,7 @@ struct mvebu_comhy_conf {
>  		.mux = _mux,				\
>  	}
>  
> -static const struct mvebu_comhy_conf mvebu_comphy_cp110_modes[] = {
> +static const struct mvebu_comphy_conf mvebu_comphy_cp110_modes[] = {
>  	/* lane 0 */
>  	MVEBU_COMPHY_CONF(0, 1, PHY_MODE_SGMII, 0x1),
>  	MVEBU_COMPHY_CONF(0, 1, PHY_MODE_2500SGMII, 0x1),
> -- 
> 2.19.1
> 

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
