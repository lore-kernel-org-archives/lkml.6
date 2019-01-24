Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E71DC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B424207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="usbGqsri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfAXNLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 08:11:24 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:53927 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfAXNLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 08:11:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=dpKYsHR9R3erJG/f2VUvutmnTg12Ktx8h74zMmPZFZg=; b=usbGqsriSNH0Bf5EuCCtxIp6Jg
        z6127v/Zv7cNAJUSpvpabVgKyWIDNzhJWr16EtoPcC+sMx/Cy9icRL7os6lDiWdbow+B/4Bgl/zic
        SgblcN85QcPnH9J3JIx+Shya6l+pbL2VUBq5ybQVy8h00OQP4p+BpFVzGhz/f1eGA8R0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gmems-0007c8-HE; Thu, 24 Jan 2019 14:11:18 +0100
Date:   Thu, 24 Jan 2019 14:11:18 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, sd@queasysnail.net, f.fainelli@gmail.com,
        hkallweit1@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, quentin.schulz@bootlin.com,
        allan.nielsen@microchip.com
Subject: Re: [PATCH net-next 02/10] net: macsec: convert to SPDX
Message-ID: <20190124131118.GA28903@lunn.ch>
References: <20190123155638.13852-1-antoine.tenart@bootlin.com>
 <20190123155638.13852-3-antoine.tenart@bootlin.com>
 <20190123170306.GG5310@lunn.ch>
 <20190124085456.GB3662@kwain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124085456.GB3662@kwain>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> That's right, I'll fix it in v2. In such cases, the license text takes
> precedence over the MODULE_LICENSE() definition ?
 
Hi Antoine

IANAL

I've also not seen any real discussion about this. But when i recently
proposed patches to cleanup similar issues in drivers/net/phy, i gave
the license text precedence, since it is a lot easier for a human to
understand, and it is likely a human made the error....


	    Andrew
