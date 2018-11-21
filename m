Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBB9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2DF21479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 07:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A2DF21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free-electrons.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbeKUSc0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 13:32:26 -0500
Received: from mail.bootlin.com ([62.4.15.54]:36792 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbeKUSc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 13:32:26 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4B0F920791; Wed, 21 Nov 2018 08:58:56 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id 21B7F20510;
        Wed, 21 Nov 2018 08:58:56 +0100 (CET)
Date:   Wed, 21 Nov 2018 08:58:50 +0100
From:   Antoine Tenart <antoine.tenart@free-electrons.com>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tony Lindgren <tony@atomide.com>,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Carlo Caione <carlo@caione.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Manu Gautam <mgautam@codeaurora.org>
Subject: Re: [PATCH v3 4/5] phy: mvebu-cp110-comphy: convert to use eth phy
 mode and submode
Message-ID: <20181121075850.GA6494@kwain>
References: <20181120012424.11802-1-grygorii.strashko@ti.com>
 <20181120012424.11802-5-grygorii.strashko@ti.com>
 <d80901b2-a38a-7abf-23b2-c2b0c84ff321@ti.com>
 <20181121075220.z6smcpk3y7vab7ix@qschulz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20181121075220.z6smcpk3y7vab7ix@qschulz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On Wed, Nov 21, 2018 at 08:52:20AM +0100, Quentin Schulz wrote:
> On Wed, Nov 21, 2018 at 01:08:42PM +0530, Kishon Vijay Abraham I wrote:
> > 
> > On 20/11/18 6:54 AM, Grygorii Strashko wrote:
> > > Convert mvebu-cp110-comphy PHY driver to use recently introduced
> > > PHY_MODE_ETHERNET and phy_set_mode_ext().
> > 
> > Care to give ACK for this patch?
> > 
> 
> Acked-by Antoine and Tested-by Maxime given in v2:
> https://patchwork.kernel.org/patch/10676749/

The Acks were removed from v3 due to changes in the patches.

Thanks,
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
