Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0EAC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F7A20892
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XcW9n0uK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5F7A20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbeKJFzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 00:55:40 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:57261 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbeKJFzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 00:55:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=cbEMN2WmWZAQFBupFHAWbImU1hEvzQ8fi0pOU3wko2s=;
        b=XcW9n0uKyiwN5gRCUiuHda4gw4eezkEu6+hGjw2OMhIKX4BKiXiG+/j+WS1+kaRkDSrsDQgzTxFOQEXkzWmHi69ltBvzYy8KDamkkXXBKD5i8o0acdb7/Cx98HW0B8hxeRm7ZJRQacMkI5RtOxuLQuoAl9cqu2IyMC7jJner268=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gLD9k-000373-UU; Fri, 09 Nov 2018 21:13:28 +0100
Date:   Fri, 9 Nov 2018 21:13:28 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        David Miller <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "maintainer:BROADCOM BCM63XX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM63XX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson SoC support" 
        <linux-amlogic@lists.infradead.org>
Subject: Re: [PATCH net-next v3 2/2] net: phy: remove flag PHY_HAS_INTERRUPT
 from driver configs
Message-ID: <20181109201328.GW5259@lunn.ch>
References: <203c4d9e-f39a-7a08-46c3-4ee6e61f181e@gmail.com>
 <15f15b61-1dc2-e204-0a08-f2d8f73c227d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15f15b61-1dc2-e204-0a08-f2d8f73c227d@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 06:17:22PM +0100, Heiner Kallweit wrote:
> Now that flag PHY_HAS_INTERRUPT has been replaced with a check for
> callbacks config_intr and ack_interrupt, we can remove setting this
> flag from all driver configs.
> Last but not least remove flag PHY_HAS_INTERRUPT completely.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Thanks for removing them all.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
