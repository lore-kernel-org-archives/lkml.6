Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86443C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 15:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F769204FD
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 15:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZLpBKDLk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfBWPmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 10:42:02 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:36191 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbfBWPmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 10:42:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=TyELZ5qb79p6HuoHH7fuOTqRAmyYJZscCBAYUnFWpzY=; b=ZLpBKDLkA8sb10VWOYPg37zBf+
        jmzwgHJrS8fhaHhP9I56GDtv2dHPWaqV6EgyPyE1rXF1Qy3d8/JrzyslTzgH9BBVKHNz34DEtKtSr
        LfkT/moTYdrhfDZuGypBvJKaxDFyDMIcKrynhdfNPMM3JazS24Djxh4NlA115OA81F+g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gxZR8-0003xY-36; Sat, 23 Feb 2019 16:41:58 +0100
Date:   Sat, 23 Feb 2019 16:41:58 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next v2 7/7] net: phy: marvell10g: add support for
 the 88x2110 PHY
Message-ID: <20190223154158.GK10693@lunn.ch>
References: <20190222233744.25735-1-maxime.chevallier@bootlin.com>
 <20190222233744.25735-8-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222233744.25735-8-maxime.chevallier@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2019 at 12:37:44AM +0100, Maxime Chevallier wrote:
> This patch adds support for the 88x2110 PHY, which is similar to the
> already supported 88x3310 PHY without the SFP interface.
> 
> It supports 10/100/1000BASET along with 2.5GBASET, 5GBASET and 10GBASET,
> with the same interface modes that are used by the 3310.
> 
> This PHY don't have the same issue as the 88x3310 regarding 2.5/5G
> abilities, and correctly follows the 802.3bz standard to list the
> supported abilities.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Suggested-by: Antoine Tenart <antoine.tenart@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
