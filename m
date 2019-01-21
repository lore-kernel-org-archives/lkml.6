Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6257C2F441
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72EFC21019
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4y4wDCeC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730448AbfAUQ21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 11:28:27 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:50516 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727205AbfAUQ21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 11:28:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=8z+l7hrgcg6JWUf07qf/+9XbIc9X6LugAausayRBG0A=;
        b=4y4wDCeCw2rYj0bmKKObeCYS8BMZyhVEJNs8dr6trBW/51Z1z73CFZHkp+irdzOd3c5OQ4woqCr/lbF31AWtgtadU6e0scHBCEYVs3MmB4HYSa37MjXF9YJr+G6mOcw/yO7gfe2aHbDqcLZMN2oSVbU4oAkJmkz7oWEpDBV9+Wg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1glcQx-0002gn-9K; Mon, 21 Jan 2019 17:28:23 +0100
Date:   Mon, 21 Jan 2019 17:28:23 +0100
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
Subject: Re: [PATCH net-next 1/7] net: phy: Extract genphy_c45_read_abilities
 from marvell10g
Message-ID: <20190121162823.GD8620@lunn.ch>
References: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
 <20190118152352.26417-2-maxime.chevallier@bootlin.com>
 <20190120185107.GA19714@lunn.ch>
 <20190121172004.78a341f7@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121172004.78a341f7@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, the term 'Ability' is used in the 802.3 specifications, both in
> the register names and the descriptions.
 
O.K, please keep with what the standard uses.

     Andrew
