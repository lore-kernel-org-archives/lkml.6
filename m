Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07683C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 16:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C508121773
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 16:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="F+Pt+dlN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfBIQZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 11:25:51 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:45238 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbfBIQZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 11:25:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=4xAdeiinY4nqo5YAnCCzTDhCcsuRsXI+5omS6I43QqE=; b=F+Pt+dlNLoSmqzriwIIiyFJMW4
        Jnqa4oeQBOup83wf/hjEYcUMoRPNligXGfVYTE95mFyYrRY1c/ibBPFoWTV34YQtS80++ZCZYmYzg
        W0AvI0C1Dppm5PQtqN7gvfoDMoA7x3tm91kcwmlPTREhNImqvWCVutaT+rsHPrXV75EI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gsVRp-00089Y-RA; Sat, 09 Feb 2019 17:25:45 +0100
Date:   Sat, 9 Feb 2019 17:25:45 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next v2 00/10] net: phy: Add support for 2.5GBASET
 PHYs
Message-ID: <20190209162545.GA30856@lunn.ch>
References: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
 <81c340ea-54b0-1abf-94af-b8dc4ee83e3a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81c340ea-54b0-1abf-94af-b8dc4ee83e3a@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd propose that you extract generic patches being submission-ready
> and split the patch series into two. I think the following patches
> would be candidates for the first series: 2, 3, 5, 6
> (provided they have no dependency on the other patches)
> Based on that both of us can go on with our work.
> 
> Andrew, what do you think?

Yes, that would help.

Heiner, can you also submit the .get_features patches soon. That is
another important piece of the puzzle for both drivers.

	Thanks
		Andrew
