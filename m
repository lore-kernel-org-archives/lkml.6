Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C17C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F0182147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YKBWfNkH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfBGORg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:17:36 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:42489 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbfBGORg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:17:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=o1d8lM/zw7LGBDBylD6tq0xUajJgVfOhqnUALUTg83M=; b=YKBWfNkH85zk0XQGFMlWumgzFz
        wGaYndJonDd6M7uIvTwesQPbRJyym6r1F4WpSlNDmc+Va09MyRwz9dWbeDie54bQ0kUR5JWX0kvtu
        iMLqVJiu2rmbxgQ8o/Kz7MlmA2yi+cXV39xoROGsrHUrcq/NavGRCWb0y5GdWfu1pRio=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1grkUe-00074d-Kt; Thu, 07 Feb 2019 15:17:32 +0100
Date:   Thu, 7 Feb 2019 15:17:32 +0100
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
Subject: Re: [PATCH net-next v2 09/10] net: mvpp2: Add 2.5GBaseT support
Message-ID: <20190207141732.GK32483@lunn.ch>
References: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
 <20190207094939.27369-10-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207094939.27369-10-maxime.chevallier@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 10:49:38AM +0100, Maxime Chevallier wrote:
> The PPv2 controller is able to support 2.5G speeds, allowing to use
> 2.5GBASET in conjunction with PHYs that use 2500BASEX as their MII
> interface when using this mode.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
